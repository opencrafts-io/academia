import 'dart:io';

import 'package:billing/billing.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:database/app_database_v2.dart';
import 'package:database/daos/study_tools_dao.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../domain/entities/study_entities.dart';
import '../datasources/study_tools_local_datasource.dart';
import '../../presentation/audio/podcast_audio_handler.dart';

typedef PodcastDownloadProgress = void Function(
  int receivedBytes,
  int? totalBytes,
);

class PodcastSubscriptionException implements Exception {
  const PodcastSubscriptionException(
    this.message, {
    this.verificationUnavailable = false,
    this.upgradeRequired = true,
  });
  final String message;
  final bool verificationUnavailable;
  final bool upgradeRequired;
}

/// Owns account-scoped podcast metadata, resumable positions, entitlement
/// snapshots and private audio files. Audio payloads never enter Drift.
class PodcastLocalStore
    implements PodcastPlaybackAccessPolicy, PodcastPlaybackPositionStore {
  PodcastLocalStore({
    required this.dao,
    required this.scope,
    required this.billing,
    required this.accessPolicy,
    required this.clock,
    Future<Directory> Function()? supportDirectory,
    http.Client Function()? clientFactory,
  }) : _supportDirectory = supportDirectory ?? getApplicationSupportDirectory,
       _clientFactory = clientFactory ?? http.Client.new;

  final StudyToolsDao dao;
  final StudyToolsScope? Function() scope;
  final BillingService billing;
  final SubscriptionAccessPolicy accessPolicy;
  final BillingClock clock;
  final Future<Directory> Function() _supportDirectory;
  final http.Client Function() _clientFactory;
  final Map<String, http.Client> _activeClients = {};
  final Set<String> _activeDownloads = {};

  bool get supportsPersistentDownloads =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  StudyToolsScope? get _currentScope {
    final value = scope();
    if (value == null ||
        value.accountId.trim().isEmpty ||
        value.accountId == 'unresolved') {
      return null;
    }
    return value;
  }

  Future<String> verifySubscriptionForDownload() async {
    final current = _currentScope;
    if (current == null) {
      throw const PodcastSubscriptionException(
        'Sign in to save podcasts offline.',
        upgradeRequired: false,
      );
    }
    final result = await billing.refreshSubscriptionStatus();
    final status = result.fold(
      (failure) => throw PodcastSubscriptionException(
        'Subscription access could not be verified. Connect and retry.',
        verificationUnavailable: true,
      ),
      (value) => value,
    );
    final subscription = status.subscription;
    final now = clock.now();
    final canceledAtPeriodEndStillActive =
        subscription?.cancelAtPeriodEnd == true &&
        !now.isBefore(subscription!.currentPeriodStart) &&
        now.isBefore(subscription.currentPeriodEnd);
    final active =
        accessPolicy.evaluate(status, now) == SubscriptionAccessState.active ||
        canceledAtPeriodEndStillActive;
    await dao.saveEntitlementSnapshot(
      StudyOfflineEntitlementSnapshotsCompanion.insert(
        environment: current.environment,
        accountId: current.accountId,
        state: active ? 'active' : 'inactive',
        currentPeriodStart: Value(subscription?.currentPeriodStart),
        currentPeriodEnd: Value(subscription?.currentPeriodEnd),
        verifiedAt: clock.now(),
      ),
    );
    if (!active) {
      throw const PodcastSubscriptionException(
        'An active subscription is required to download podcasts for offline listening.',
      );
    }
    return current.accountId;
  }

  @override
  Future<bool> canListenOnline(StudyPodcast podcast) async {
    final current = _currentScope;
    if (current == null) return false;
    try {
      final results = await Connectivity().checkConnectivity();
      return results.any((result) => result != ConnectivityResult.none);
    } on Object {
      return false;
    }
  }

  @override
  Future<String?> eligibleDownloadPath(StudyPodcast podcast) async {
    final current = _currentScope;
    if (current == null) return null;
    final snapshot = await dao.entitlementSnapshot(
      current.environment,
      current.accountId,
    );
    if (snapshot == null || snapshot.state != 'active') return null;
    final now = clock.now();
    if (snapshot.currentPeriodStart != null &&
        now.isBefore(snapshot.currentPeriodStart!)) {
      return null;
    }
    if (snapshot.currentPeriodEnd == null ||
        !now.isBefore(snapshot.currentPeriodEnd!)) {
      return null;
    }
    final key = episodeKey(podcast);
    final records = await dao.downloads(current.environment, current.accountId);
    final record = records
        .where((row) => row.noteId == podcast.noteId && row.episodeKey == key)
        .firstOrNull;
    if (record == null || record.status != 'ready') return null;
    final file = File(record.localPath);
    if (!await file.exists() ||
        await file.length() != record.sizeBytes ||
        !await _hasMp3Header(file)) {
      await dao.removeDownload(
        current.environment,
        current.accountId,
        podcast.noteId,
        key,
      );
      return null;
    }
    return file.path;
  }

  @override
  Future<({Duration position, double speed})> read(StudyPodcast podcast) async {
    final current = _currentScope;
    if (current == null) return (position: Duration.zero, speed: 1.0);
    final row = await dao.playbackPosition(
      current.environment,
      current.accountId,
      podcast.noteId,
      episodeKey(podcast),
    );
    return (
      position: Duration(milliseconds: row?.positionMilliseconds ?? 0),
      speed: row?.speed ?? 1,
    );
  }

  @override
  Future<void> write(
    StudyPodcast podcast,
    Duration position,
    double speed,
  ) async {
    final current = _currentScope;
    if (current == null) return;
    await dao.savePlaybackPosition(
      StudyPlaybackPositionsCompanion.insert(
        environment: current.environment,
        accountId: current.accountId,
        noteId: podcast.noteId,
        episodeKey: episodeKey(podcast),
        positionMilliseconds: position.inMilliseconds.clamp(
          0,
          podcast.duration.inMilliseconds,
        ),
        speed: Value(speed),
        updatedAt: clock.now(),
      ),
    );
  }

  @override
  Future<void> clear(StudyPodcast podcast) async {
    await write(podcast, Duration.zero, 1);
  }

  Future<List<PodcastDownloadedEpisode>> downloads() async {
    final current = _currentScope;
    if (current == null) return const [];
    final rows = await dao.downloadManifests(
      current.environment,
      current.accountId,
    );
    final existing = <PodcastDownloadedEpisode>[];
    for (final row in rows) {
      final scopedKey =
          '${row.environment}:${row.accountId}:${row.noteId}:${row.episodeKey}';
      if (row.status == 'downloading') {
        if (_activeDownloads.contains(scopedKey)) continue;
        final partial = File('${row.localPath}.part');
        if (await partial.exists()) await partial.delete();
        await dao.removeDownload(
          current.environment,
          current.accountId,
          row.noteId,
          row.episodeKey,
        );
        continue;
      }
      if (row.status != 'ready') continue;
      final file = File(row.localPath);
      if (!await file.exists() ||
          await file.length() != row.sizeBytes ||
          !await _hasMp3Header(file)) {
        if (await file.exists()) await file.delete();
        await dao.removeDownload(
          current.environment,
          current.accountId,
          row.noteId,
          row.episodeKey,
        );
        continue;
      }
      final backup = File('${row.localPath}.previous');
      if (await backup.exists()) await backup.delete();
      existing.add(
        PodcastDownloadedEpisode(
          environment: row.environment,
          accountId: row.accountId,
          noteId: row.noteId,
          episodeKey: row.episodeKey,
          title: row.title,
          courseLabel: row.courseLabel,
          localPath: row.localPath,
          sizeBytes: row.sizeBytes,
          duration: Duration(
            milliseconds: (row.durationSeconds * 1000).round(),
          ),
          downloadedAt: row.downloadedAt,
          status: PodcastDownloadStatus.ready,
        ),
      );
    }
    return existing;
  }

  Future<void> download({
    required StudyPodcast podcast,
    required String title,
    required String courseLabel,
    required PodcastDownloadProgress onProgress,
  }) async {
    if (!supportsPersistentDownloads) {
      throw const PodcastSubscriptionException(
        'Offline podcast downloads are not supported on this device.',
        upgradeRequired: false,
      );
    }
    final current = _currentScope;
    if (current == null) {
      throw const PodcastSubscriptionException(
        'Sign in to save podcasts offline.',
        upgradeRequired: false,
      );
    }
    await verifySubscriptionForDownload();
    final key = episodeKey(podcast);
    final scopedKey =
        '${current.environment}:${current.accountId}:${podcast.noteId}:$key';
    if (!_activeDownloads.add(scopedKey)) return;
    if (await eligibleDownloadPath(podcast) != null) {
      _activeDownloads.remove(scopedKey);
      return;
    }
    final root = await _supportDirectory();
    final directory = Directory(
      p.join(
        root.path,
        'podcasts',
        current.environment,
        Uri.encodeComponent(current.accountId),
        '${podcast.noteId}',
      ),
    );
    await directory.create(recursive: true);
    final file = File(p.join(directory.path, '$key.mp3'));
    final partial = File('${file.path}.part');
    final client = _clientFactory();
    _activeClients[scopedKey] = client;
    final prior = await dao.downloadManifest(
      current.environment,
      current.accountId,
      podcast.noteId,
      key,
    );
    if (prior == null || prior.status != 'ready') {
      await dao.saveDownload(
        StudyPodcastDownloadsCompanion.insert(
          environment: current.environment,
          accountId: current.accountId,
          noteId: podcast.noteId,
          episodeKey: key,
          localPath: file.path,
          sizeBytes: 0,
          durationSeconds: podcast.duration.inMilliseconds / 1000,
          courseLabel: courseLabel,
          title: title,
          downloadedAt: const Value(null),
          status: 'downloading',
        ),
      );
    }
    try {
      final uri = Uri.parse(podcast.audioUrl);
      final response = await client.send(
        http.Request('GET', uri)..headers['Accept-Encoding'] = 'identity',
      );
      if (response.statusCode != 200) {
        throw StateError(
          'The podcast download could not be reached (${response.statusCode}).',
        );
      }
      final total = response.contentLength;
      final sink = partial.openWrite();
      var received = 0;
      await for (final chunk in response.stream) {
        if (!_activeDownloads.contains(scopedKey)) {
          throw const _DownloadCancelled();
        }
        sink.add(chunk);
        received += chunk.length;
        onProgress(received, total);
      }
      await sink.flush();
      await sink.close();
      if (received == 0 || (total != null && total != received)) {
        throw StateError('The downloaded podcast was incomplete.');
      }
      // Validate an audio/mpeg response before replacing the final path.
      if (!await _hasMp3Header(partial)) {
        throw StateError('The downloaded file is not a valid MP3 episode.');
      }
      final backup = File('${file.path}.previous');
      if (await backup.exists()) await backup.delete();
      if (await file.exists()) await file.rename(backup.path);
      try {
        await partial.rename(file.path);
        if (await backup.exists()) await backup.delete();
      } on Object {
        if (!await file.exists() && await backup.exists()) {
          await backup.rename(file.path);
        }
        rethrow;
      }
      await dao.saveDownload(
        StudyPodcastDownloadsCompanion.insert(
          environment: current.environment,
          accountId: current.accountId,
          noteId: podcast.noteId,
          episodeKey: key,
          localPath: file.path,
          sizeBytes: received,
          durationSeconds: podcast.duration.inMilliseconds / 1000,
          courseLabel: courseLabel,
          title: title,
          downloadedAt: Value(clock.now()),
          status: 'ready',
        ),
      );
    } catch (_) {
      if (await partial.exists()) await partial.delete();
      if (prior == null || prior.status != 'ready') {
        await dao.removeDownload(
          current.environment,
          current.accountId,
          podcast.noteId,
          key,
        );
      }
      rethrow;
    } finally {
      client.close();
      _activeClients.remove(scopedKey);
      _activeDownloads.remove(scopedKey);
    }
  }

  Future<void> cancelDownload(StudyPodcast podcast) async {
    final current = _currentScope;
    if (current == null) return;
    final scopedKey =
        '${current.environment}:${current.accountId}:${podcast.noteId}:${episodeKey(podcast)}';
    _activeClients[scopedKey]?.close();
    _activeDownloads.remove(scopedKey);
    final root = await _supportDirectory();
    final partial = File(
      p.join(
        root.path,
        'podcasts',
        current.environment,
        Uri.encodeComponent(current.accountId),
        '${podcast.noteId}',
        '${episodeKey(podcast)}.mp3.part',
      ),
    );
    if (await partial.exists()) await partial.delete();
    await dao.removeDownload(
      current.environment,
      current.accountId,
      podcast.noteId,
      episodeKey(podcast),
    );
  }

  Future<void> removeDownload(PodcastDownloadedEpisode episode) async {
    final current = _currentScope;
    if (current == null ||
        episode.environment != current.environment ||
        episode.accountId != current.accountId) {
      return;
    }
    final file = File(episode.localPath);
    if (await file.exists()) await file.delete();
    await dao.removeDownload(
      current.environment,
      current.accountId,
      episode.noteId,
      episode.episodeKey,
    );
  }

  Future<void> removeMaterialFiles(int noteId) async {
    final current = _currentScope;
    if (current == null) return;
    final prefix = '${current.environment}:${current.accountId}:$noteId:';
    for (final key
        in _activeClients.keys
            .where((key) => key.startsWith(prefix))
            .toList()) {
      _activeClients.remove(key)?.close();
      _activeDownloads.remove(key);
    }
    final root = await _supportDirectory();
    final directory = Directory(
      p.join(
        root.path,
        'podcasts',
        current.environment,
        Uri.encodeComponent(current.accountId),
        '$noteId',
      ),
    );
    if (await directory.exists()) await directory.delete(recursive: true);
  }

  Future<void> clearAccountData({String? accountId}) async {
    final current = _currentScope;
    if (current == null) return;
    final targetAccount = accountId ?? current.accountId;
    for (final client in _activeClients.values) {
      client.close();
    }
    _activeClients.clear();
    _activeDownloads.clear();
    final rows = await dao.downloads(current.environment, targetAccount);
    for (final row in rows) {
      final file = File(row.localPath);
      if (await file.exists()) await file.delete();
    }
    final root = await _supportDirectory();
    final directory = Directory(
      p.join(
        root.path,
        'podcasts',
        current.environment,
        Uri.encodeComponent(targetAccount),
      ),
    );
    if (await directory.exists()) await directory.delete(recursive: true);
    await dao.clearPodcastScope(current.environment, targetAccount);
  }

  static String episodeKey(StudyPodcast podcast) =>
      podcast.id?.toString() ??
      podcast.generatedAt.toUtc().microsecondsSinceEpoch.toString();

  Future<bool> _hasMp3Header(File file) async {
    RandomAccessFile? handle;
    try {
      handle = await file.open();
      final signature = await handle.read(3);
      return signature.length >= 3 &&
          ((signature[0] == 0x49 &&
                  signature[1] == 0x44 &&
                  signature[2] == 0x33) ||
              (signature[0] == 0xff && (signature[1] & 0xe0) == 0xe0));
    } on Object {
      return false;
    } finally {
      await handle?.close();
    }
  }
}

class _DownloadCancelled implements Exception {
  const _DownloadCancelled();
}

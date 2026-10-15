import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/study_entities.dart';
import 'podcast_playback_adapter.dart';

abstract interface class PodcastPlaybackAccessPolicy {
  /// The note metadata request has already authenticated ownership. This check
  /// confirms that an online source can be fetched now.
  Future<bool> canListenOnline(StudyPodcast podcast);

  /// Returns a verified, existing local file only while the saved subscription
  /// snapshot grants access for the current account and environment.
  Future<String?> eligibleDownloadPath(StudyPodcast podcast);
}

abstract interface class PodcastPlaybackPositionStore {
  Future<({Duration position, double speed})> read(StudyPodcast podcast);
  Future<void> write(StudyPodcast podcast, Duration position, double speed);
  Future<void> clear(StudyPodcast podcast);
}

abstract interface class PodcastAudioFocus {
  Stream<AudioInterruptionEvent> get interruptions;
  Stream<void> get becomingNoisy;
  Future<void> initialize();
  Future<bool> activate();
}

class AudioSessionPodcastFocus implements PodcastAudioFocus {
  AudioSession? _session;

  @override
  Stream<AudioInterruptionEvent> get interruptions =>
      _session?.interruptionEventStream ?? const Stream.empty();

  @override
  Stream<void> get becomingNoisy =>
      _session?.becomingNoisyEventStream ?? const Stream.empty();

  @override
  Future<void> initialize() async {
    if (_session != null) return;
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    _session = session;
  }

  @override
  Future<bool> activate() async {
    await initialize();
    return _session!.setActive(true);
  }
}

typedef PodcastEpisodeOpener = void Function(StudyPodcast podcast);

class PodcastAudioHandler extends BaseAudioHandler with SeekHandler {
  PodcastAudioHandler({
    required this._adapter,
    required this._access,
    required this._positions,
    this.mediaBaseUri,
    this._onEpisodeActivated,
    PodcastAudioFocus? focus,
  }) {
    _snapshotSubscription = _adapter.snapshots.listen(_onSnapshot);
    _adapterErrorSubscription = _adapter.errors.listen(_onAdapterError);
    _notificationClickSubscription = AudioService.notificationClicked.listen((
      clicked,
    ) {
      if (clicked) openCurrentEpisode();
    });
    _focus = focus ?? AudioSessionPodcastFocus();
    _sessionInitialization = _configureSession();
  }

  final PodcastPlaybackAdapter _adapter;
  final PodcastPlaybackAccessPolicy _access;
  final PodcastPlaybackPositionStore _positions;
  final Uri? mediaBaseUri;
  final PodcastEpisodeOpener? _onEpisodeActivated;
  late final StreamSubscription<PodcastPlaybackSnapshot> _snapshotSubscription;
  late final StreamSubscription<String> _adapterErrorSubscription;
  late final StreamSubscription<bool> _notificationClickSubscription;
  StreamSubscription<AudioInterruptionEvent>? _interruptionSubscription;
  StreamSubscription<void>? _noisySubscription;
  late final PodcastAudioFocus _focus;
  late final Future<void> _sessionInitialization;
  StudyPodcast? _episode;
  bool _loading = false;
  bool _resumeAfterInterruption = false;
  bool _interrupted = false;
  bool _pauseRequestedWhileLoading = false;
  int _commandGeneration = 0;
  int? _requestedNoteId;
  String? _localPath;
  bool _disposed = false;
  String? _errorMessage;
  DateTime _lastPositionWrite = DateTime.fromMillisecondsSinceEpoch(0);
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);
  final _errors = StreamController<String?>.broadcast();

  Stream<String?> get errors => _errors.stream;
  StudyPodcast? get currentEpisode => _episode;

  Future<void> _configureSession() async {
    try {
      await _focus.initialize();
      _interruptionSubscription = _focus.interruptions.listen((event) async {
        if (event.begin) {
          _interrupted = true;
          _resumeAfterInterruption = playbackState.value.playing;
          if (_resumeAfterInterruption) await _pause(userInitiated: false);
        } else {
          _interrupted = false;
          if (_resumeAfterInterruption) {
            _resumeAfterInterruption = false;
            await play();
          }
        }
      });
      _noisySubscription = _focus.becomingNoisy.listen((_) {
        _resumeAfterInterruption = false;
        unawaited(_pause(userInitiated: false));
      });
    } catch (error) {
      _setError('Audio focus could not be initialized. Try playback again.');
    }
  }

  Future<bool> _activateAudioSession() async {
    await _sessionInitialization;
    try {
      return await _focus.activate();
    } catch (_) {
      return false;
    }
  }

  bool _isCommandCurrent(int generation) =>
      generation == _commandGeneration && !_disposed;

  Future<void> playEpisode(
    StudyPodcast podcast, {
    required String title,
    String? courseLabel,
    bool preferDownload = false,
  }) async {
    if (_loading || _disposed) return;
    final generation = ++_commandGeneration;
    _loading = true;
    _requestedNoteId = podcast.noteId;
    _pauseRequestedWhileLoading = false;
    _setError(null);
    try {
      final downloadPath = preferDownload
          ? await _access.eligibleDownloadPath(podcast)
          : null;
      if (!_isCommandCurrent(generation)) return;
      if (preferDownload && downloadPath == null) {
        throw StateError('Offline access is unavailable for this episode.');
      }
      if (!preferDownload && !await _access.canListenOnline(podcast)) {
        throw StateError('Connect to the internet to listen to this episode.');
      }
      if (!_isCommandCurrent(generation)) return;
      if (!await _activateAudioSession()) {
        throw StateError(
          'Audio focus is unavailable while another app is using audio.',
        );
      }
      if (!_isCommandCurrent(generation)) return;

      final previousEpisode = _episode;
      if (previousEpisode != null) {
        await _positions.write(
          previousEpisode,
          playbackState.value.updatePosition,
          playbackState.value.speed,
        );
      }
      if (!_isCommandCurrent(generation)) return;
      _episode = null;
      _localPath = null;
      mediaItem.add(null);
      await _adapter.stop();
      _episode = podcast;
      _localPath = downloadPath;
      final mediaId = _mediaId(podcast);
      mediaItem.add(
        MediaItem(
          id: mediaId,
          album: courseLabel?.trim().isNotEmpty == true
              ? courseLabel
              : 'Study Tools',
          title: title.trim().isEmpty ? 'Study podcast' : title,
          artist: 'Academia',
          duration: podcast.duration,
          playable: true,
          extras: {
            'noteId': podcast.noteId,
            'episodeId': podcast.id,
            'generatedAt': podcast.generatedAt.toIso8601String(),
            'episodeKey':
                '${podcast.id ?? podcast.generatedAt.toUtc().microsecondsSinceEpoch}',
          },
        ),
      );
      playbackState.add(
        _state(processingState: AudioProcessingState.loading, playing: false),
      );
      final resume = await _positions.read(podcast);
      if (!_isCommandCurrent(generation)) return;
      await _adapter.setSpeed(resume.speed);
      if (downloadPath != null) {
        await _adapter.openDownloaded(downloadPath, startAt: resume.position);
      } else {
        final suppliedUri = Uri.parse(podcast.audioUrl);
        final uri = suppliedUri.hasScheme
            ? suppliedUri
            : mediaBaseUri?.resolveUri(suppliedUri);
        if (uri == null || !{'http', 'https'}.contains(uri.scheme)) {
          throw StateError(
            'This podcast audio link is invalid. Refresh the episode.',
          );
        }
        await _adapter.openOnline(uri, startAt: resume.position);
      }
      if (!_isCommandCurrent(generation)) return;
      if (_pauseRequestedWhileLoading || _interrupted) {
        await _adapter.pause();
        playbackState.add(
          _state(processingState: AudioProcessingState.ready, playing: false),
        );
      } else {
        await _adapter.play();
      }
    } on Object catch (error) {
      if (!_isCommandCurrent(generation)) return;
      await _adapter.stop();
      _setError(_friendlyError(error));
      playbackState.add(
        _state(processingState: AudioProcessingState.error, playing: false),
      );
    } finally {
      if (generation == _commandGeneration) {
        _loading = false;
        _requestedNoteId = null;
      }
    }
  }

  @override
  Future<void> play() async {
    if (_loading) return;
    final episode = _episode;
    if (episode == null) return;
    if (playbackState.value.processingState == AudioProcessingState.error) {
      await retryCurrentEpisode();
      return;
    }
    if (_localPath != null) {
      final path = await _access.eligibleDownloadPath(episode);
      if (path == null || path != _localPath) {
        await stop();
        _setError(
          'Offline subscription access has expired or the download is missing.',
        );
        return;
      }
    } else if (!await _access.canListenOnline(episode)) {
      _setError('Connect to the internet to resume this episode.');
      return;
    }
    if (!await _activateAudioSession()) {
      _setError('Audio focus is unavailable while another app is using audio.');
      return;
    }
    if (playbackState.value.processingState == AudioProcessingState.completed) {
      await _adapter.seek(Duration.zero);
    }
    _setError(null);
    await _adapter.play();
    playbackState.add(
      _state(processingState: AudioProcessingState.ready, playing: true),
    );
  }

  @override
  Future<void> pause() async {
    await _pause(userInitiated: true);
  }

  Future<void> _pause({required bool userInitiated}) async {
    if (userInitiated) _resumeAfterInterruption = false;
    if (_loading) _pauseRequestedWhileLoading = true;
    await _adapter.pause();
    await _persistPosition();
    playbackState.add(
      _state(processingState: AudioProcessingState.ready, playing: false),
    );
  }

  @override
  Future<void> stop() async {
    ++_commandGeneration;
    _loading = false;
    _pauseRequestedWhileLoading = false;
    _requestedNoteId = null;
    final episode = _episode;
    if (episode != null) {
      try {
        await _positions.write(
          episode,
          Duration.zero,
          playbackState.value.speed,
        );
      } on Object {
        // Playback controls still need to clear if local position storage fails.
      }
    }
    _episode = null;
    _localPath = null;
    mediaItem.add(null);
    playbackState.add(
      _state(processingState: AudioProcessingState.idle, playing: false),
    );
    try {
      await _adapter.stop();
    } finally {
      await super.stop();
    }
  }

  @override
  Future<void> seek(Duration position) async {
    final duration = mediaItem.value?.duration ?? Duration.zero;
    final clamped = position < Duration.zero
        ? Duration.zero
        : duration > Duration.zero && position > duration
        ? duration
        : position;
    await _adapter.seek(clamped);
  }

  @override
  Future<void> fastForward() =>
      seek(playbackState.value.updatePosition + const Duration(seconds: 10));

  @override
  Future<void> rewind() =>
      seek(playbackState.value.updatePosition - const Duration(seconds: 10));

  @override
  Future<void> setSpeed(double speed) => _adapter.setSpeed(speed);

  void openCurrentEpisode() {
    final episode = _episode;
    if (episode != null) _onEpisodeActivated?.call(episode);
  }

  Future<void> retryCurrentEpisode() async {
    final episode = _episode;
    final item = mediaItem.value;
    if (episode == null || item == null) return;
    await playEpisode(
      episode,
      title: item.title,
      courseLabel: item.album,
      preferDownload: _localPath != null,
    );
  }

  Future<void> discardIfNote(int noteId) async {
    if (_episode?.noteId != noteId && _requestedNoteId != noteId) return;
    ++_commandGeneration;
    _loading = false;
    _requestedNoteId = null;
    _episode = null;
    _localPath = null;
    mediaItem.add(null);
    try {
      await _adapter.stop();
    } finally {
      playbackState.add(
        _state(processingState: AudioProcessingState.idle, playing: false),
      );
      await super.stop();
    }
  }

  Future<void> _onSnapshot(PodcastPlaybackSnapshot snapshot) async {
    final episode = _episode;
    if (episode == null || _disposed) return;
    final processing = _errorMessage != null
        ? AudioProcessingState.error
        : snapshot.completed
        ? AudioProcessingState.completed
        : snapshot.buffering
        ? AudioProcessingState.buffering
        : AudioProcessingState.ready;
    playbackState.add(
      _state(
        processingState: processing,
        playing: _errorMessage == null && snapshot.playing,
        position: snapshot.position,
        buffered: snapshot.buffered,
        speed: snapshot.speed,
      ),
    );
    final now = DateTime.now();
    if (snapshot.completed ||
        now.difference(_lastPositionWrite) >= const Duration(seconds: 5)) {
      _lastPositionWrite = now;
      try {
        await _positions.write(episode, snapshot.position, snapshot.speed);
      } on Object {
        // Position persistence is best-effort and must not interrupt playback.
      }
    }
  }

  Future<void> _persistPosition() async {
    final episode = _episode;
    if (episode == null) return;
    try {
      await _positions.write(
        episode,
        playbackState.value.updatePosition,
        playbackState.value.speed,
      );
      _lastPositionWrite = DateTime.now();
    } on Object {
      // Position is best-effort; playback continues if local storage is busy.
    }
  }

  void _onAdapterError(String message) {
    if (_episode == null || _disposed) return;
    _setError(message);
    unawaited(_adapter.pause().catchError((_) {}));
    playbackState.add(
      _state(processingState: AudioProcessingState.error, playing: false),
    );
  }

  PlaybackState _state({
    required AudioProcessingState processingState,
    required bool playing,
    Duration? position,
    Duration? buffered,
    double? speed,
  }) => PlaybackState(
    controls: [
      MediaControl.rewind,
      playing ? MediaControl.pause : MediaControl.play,
      MediaControl.stop,
      MediaControl.fastForward,
    ],
    systemActions: const {
      MediaAction.seek,
      MediaAction.seekForward,
      MediaAction.seekBackward,
    },
    androidCompactActionIndices: const [0, 1, 3],
    processingState: processingState,
    playing: playing,
    updatePosition: position ?? playbackState.value.updatePosition,
    bufferedPosition: buffered ?? playbackState.value.bufferedPosition,
    speed: speed ?? playbackState.value.speed,
    queueIndex: 0,
  );

  void _setError(String? message) {
    _errorMessage = message;
    errorMessage.value = message;
    if (!_errors.isClosed) _errors.add(message);
  }

  String _friendlyError(Object error) {
    final text = error.toString().toLowerCase();
    if (text.contains('subscription')) return error.toString();
    if (text.contains('offline access')) {
      return 'Offline access is unavailable. Verify your subscription and saved episode, then retry.';
    }
    if (text.contains('connect to the internet')) {
      return 'Connect to the internet to listen to this episode.';
    }
    if (text.contains('range') || text.contains('audio host')) {
      return 'This audio host cannot stream the episode right now. Refresh and try again.';
    }
    if (text.contains('focus')) {
      return 'Audio focus is unavailable while another app is using audio.';
    }
    return 'Podcast playback could not start. Check your connection and retry.';
  }

  String _mediaId(StudyPodcast podcast) =>
      '${podcast.noteId}:${podcast.id ?? podcast.generatedAt.toUtc().microsecondsSinceEpoch}';

  @override
  Future<dynamic> customAction(
    String name, [
    Map<String, dynamic>? extras,
  ]) async {
    if (name == 'openEpisode') openCurrentEpisode();
    return super.customAction(name, extras);
  }

  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    await _snapshotSubscription.cancel();
    await _adapterErrorSubscription.cancel();
    await _notificationClickSubscription.cancel();
    await _interruptionSubscription?.cancel();
    await _noisySubscription?.cancel();
    await _sessionInitialization;
    await _persistPosition();
    await _adapter.dispose();
    await _errors.close();
    errorMessage.dispose();
  }

  String? get currentError => _errorMessage;
}

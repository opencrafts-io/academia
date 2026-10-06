import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

typedef PodcastPlaybackSnapshot = ({
  Duration position,
  Duration duration,
  Duration buffered,
  bool playing,
  bool buffering,
  bool completed,
  double speed,
});

abstract interface class PodcastPlaybackAdapter {
  Stream<PodcastPlaybackSnapshot> get snapshots;
  Stream<String> get errors;
  Future<void> initialize();
  Future<void> openOnline(Uri uri, {Duration startAt = Duration.zero});
  Future<void> openDownloaded(String path, {Duration startAt = Duration.zero});
  Future<void> play();
  Future<void> pause();
  Future<void> stop();
  Future<void> seek(Duration position);
  Future<void> setSpeed(double speed);
  Future<void> dispose();
}

/// SoLoud adapter. Online audio uses SoLoud's seekable pull-buffer stream and
/// HTTP Range requests; the unauthenticated media client never forwards
/// Professor bearer credentials to storage/CDN URLs.
class SoloudPodcastPlaybackAdapter implements PodcastPlaybackAdapter {
  SoloudPodcastPlaybackAdapter({
    SoLoud? engine,
    http.Client? mediaClient,
    this.rangeSizeBytes = 256 * 1024,
  }) : _engine = engine ?? SoLoud.instance,
       _mediaClient = mediaClient ?? http.Client();

  final SoLoud _engine;
  final http.Client _mediaClient;
  final int rangeSizeBytes;
  final StreamController<PodcastPlaybackSnapshot> _snapshots =
      StreamController.broadcast();
  final StreamController<String> _errors = StreamController.broadcast();
  final Map<int, Future<void>> _rangeRequests = {};
  final Map<int, Completer<void>> _requestAborters = {};
  AudioSource? _source;
  SoundHandle? _handle;
  Timer? _ticker;
  bool _initialized = false;
  bool _disposed = false;
  double _speed = 1;
  Duration _duration = Duration.zero;
  Duration _buffered = Duration.zero;
  bool _isBuffering = false;
  File? _temporaryOnlineFile;
  int _generation = 0;
  int _requestSequence = 0;
  int? _expectedRemoteSize;

  @override
  Stream<PodcastPlaybackSnapshot> get snapshots => _snapshots.stream;

  @override
  Stream<String> get errors => _errors.stream;

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    if (_disposed) throw StateError('The playback adapter has been disposed.');
    await _engine.init();
    _initialized = true;
  }

  @override
  Future<void> openOnline(Uri uri, {Duration startAt = Duration.zero}) async {
    await initialize();
    final generation = ++_generation;
    await _releaseSource();
    _duration = Duration.zero;
    _buffered = Duration.zero;
    _expectedRemoteSize = null;
    _isBuffering = true;
    _publish();

    _RangeChunk? first;
    try {
      first = await _requestRange(uri, 0);
    } on _RangeUnsupported {
      final file = await _downloadTemporaryFile(uri, generation);
      if (generation != _generation) {
        await file.delete();
        return;
      }
      late final AudioSource source;
      try {
        source = await _engine.loadFile(file.path, mode: LoadMode.disk);
      } on Object {
        if (await file.exists()) await file.delete();
        rethrow;
      }
      if (generation != _generation || _disposed) {
        await _engine.disposeSource(source);
        if (await file.exists()) await file.delete();
        return;
      }
      _temporaryOnlineFile = file;
      _source = source;
      _duration = _engine.getLength(source);
      _isBuffering = false;
      await _startHandle(startAt);
      return;
    }
    if (generation != _generation) return;
    final initialChunk = first;
    _expectedRemoteSize = initialChunk.totalBytes;
    final source = _engine.setPullBufferStream(
      audioSizeBytes: initialChunk.totalBytes,
      bufferSizeBytes: 8 * 1024 * 1024,
      bufferTriggerPosition: 0.72,
      format: BufferType.auto,
      onBuffering: (buffering, _, seconds) {
        _isBuffering = buffering;
        if (seconds.isFinite && seconds > 0) {
          _buffered = Duration(milliseconds: (seconds * 1000).round());
        }
        _publish();
      },
      onAudioDuration: (seconds) {
        if (seconds.isFinite && seconds > 0) {
          _duration = Duration(milliseconds: (seconds * 1000).round());
        }
        _publish();
      },
      onMoreDataIsNeeded: (offset) {
        unawaited(
          _feedRange(
            uri,
            source: _source,
            offset: offset,
            generation: generation,
          ),
        );
      },
    );
    _source = source;
    _engine.addPullBufferDataStream(source, initialChunk.bytes, offset: 0);
    _duration = Duration.zero;
    _isBuffering = false;
    await _startHandle(startAt);
  }

  @override
  Future<void> openDownloaded(
    String path, {
    Duration startAt = Duration.zero,
  }) async {
    await initialize();
    final generation = ++_generation;
    await _releaseSource();
    final source = await _engine.loadFile(path, mode: LoadMode.disk);
    if (generation != _generation || _disposed) {
      await _engine.disposeSource(source);
      return;
    }
    _source = source;
    _duration = _engine.getLength(source);
    _isBuffering = false;
    await _startHandle(startAt);
  }

  Future<void> _feedRange(
    Uri uri, {
    required AudioSource? source,
    required int offset,
    required int generation,
  }) async {
    if (source == null || generation != _generation || _disposed) return;
    if (_rangeRequests.containsKey(offset)) return _rangeRequests[offset];
    final request = () async {
      try {
        final chunk = await _requestRange(uri, offset);
        if (generation != _generation || source != _source || _disposed) return;
        if (chunk.totalBytes != _expectedRemoteSize) {
          throw StateError('The podcast audio changed while it was streaming.');
        }
        _engine.addPullBufferDataStream(source, chunk.bytes, offset: offset);
      } catch (_) {
        if (generation == _generation) {
          _isBuffering = true;
          _publish();
          if (!_errors.isClosed) {
            _errors.add(
              'The audio stream was interrupted. Check your connection and resume playback.',
            );
          }
        }
      }
    }();
    _rangeRequests[offset] = request;
    try {
      await request;
    } finally {
      _rangeRequests.remove(offset);
    }
  }

  Future<_RangeChunk> _requestRange(Uri uri, int offset) async {
    final end = offset + rangeSizeBytes - 1;
    final tracked = await _send(
      http.Request('GET', uri)
        ..headers.addAll({
          'Range': 'bytes=$offset-$end',
          'Accept-Encoding': 'identity',
        }),
    );
    try {
      final response = tracked.response;
      if (response.statusCode != 206) {
        await response.stream.listen(null).cancel();
        throw const _RangeUnsupported();
      }
      final contentRange = response.headers['content-range'];
      final match = contentRange == null
          ? null
          : RegExp(r'^bytes (\d+)-(\d+)/(\d+)$').firstMatch(contentRange);
      if (match == null || int.parse(match.group(1)!) != offset) {
        throw StateError('The audio host returned an invalid byte range.');
      }
      final endOffset = int.parse(match.group(2)!);
      final totalBytes = int.parse(match.group(3)!);
      final expectedLength = (totalBytes - offset)
          .clamp(0, rangeSizeBytes)
          .toInt();
      if (totalBytes <= 0 ||
          endOffset < offset ||
          endOffset - offset + 1 != expectedLength) {
        throw StateError('The audio host returned an incomplete byte range.');
      }
      final builder = BytesBuilder(copy: false);
      await for (final chunk in response.stream) {
        if (builder.length + chunk.length > rangeSizeBytes) {
          throw StateError(
            'The audio host returned an oversized audio segment.',
          );
        }
        builder.add(chunk);
      }
      final bytes = builder.takeBytes();
      if (bytes.isEmpty || bytes.length > rangeSizeBytes) {
        throw StateError('The audio host returned an invalid audio segment.');
      }
      if (bytes.length != expectedLength) {
        throw StateError('The audio host returned an incomplete byte range.');
      }
      return _RangeChunk(bytes, totalBytes);
    } finally {
      _finishRequest(tracked.id);
    }
  }

  Future<File> _downloadTemporaryFile(Uri uri, int generation) async {
    final tracked = await _send(
      http.Request('GET', uri)..headers['Accept-Encoding'] = 'identity',
    );
    try {
      final response = tracked.response;
      if (response.statusCode != 200) {
        await response.stream.listen(null).cancel();
        throw StateError(
          'The podcast audio could not be reached. Refresh the episode and retry.',
        );
      }
      final directory = await getTemporaryDirectory();
      final file = File(
        p.join(
          directory.path,
          'academia-podcast-${DateTime.now().microsecondsSinceEpoch}.tmp',
        ),
      );
      final sink = file.openWrite();
      var received = 0;
      try {
        await for (final chunk in response.stream) {
          if (generation != _generation || _disposed) {
            throw const _StalePlaybackRequest();
          }
          sink.add(chunk);
          received += chunk.length;
        }
        await sink.flush();
        await sink.close();
        if (received == 0 ||
            (response.contentLength != null &&
                received != response.contentLength)) {
          throw StateError('The podcast audio response was incomplete.');
        }
        return file;
      } catch (_) {
        await sink.close();
        if (await file.exists()) await file.delete();
        rethrow;
      }
    } finally {
      _finishRequest(tracked.id);
    }
  }

  Future<_TrackedResponse> _send(http.Request request) async {
    final id = ++_requestSequence;
    final aborter = Completer<void>();
    _requestAborters[id] = aborter;
    final abortable = http.AbortableRequest(
      request.method,
      request.url,
      abortTrigger: aborter.future,
    )..headers.addAll(request.headers);
    try {
      return _TrackedResponse(await _mediaClient.send(abortable), id);
    } on Object {
      _finishRequest(id);
      rethrow;
    }
  }

  void _finishRequest(int id) => _requestAborters.remove(id);

  Future<void> _startHandle(Duration startAt) async {
    final source = _source;
    if (source == null) return;
    final length = _duration;
    final position = startAt.isNegative
        ? Duration.zero
        : length > Duration.zero && startAt > length
        ? length
        : startAt;
    _handle = _engine.play(source, paused: true, scale: _speed);
    if (position > Duration.zero) _engine.seek(_handle!, position);
    _engine.setPause(_handle!, false);
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(milliseconds: 250), (_) {
      final handle = _handle;
      final current = _source;
      if (handle == null || current == null || !_engine.isInitialized) return;
      final currentPosition = _engine.getPosition(handle);
      final currentLength = _duration > Duration.zero
          ? _duration
          : _engine.getLength(current);
      final completed =
          !_engine.getIsValidVoiceHandle(handle) &&
          currentLength > Duration.zero &&
          currentPosition >= currentLength;
      _duration = currentLength;
      _snapshots.add((
        position: currentPosition,
        duration: currentLength,
        buffered: _buffered,
        playing:
            _engine.getIsValidVoiceHandle(handle) && !_engine.getPause(handle),
        buffering: _isBuffering,
        completed: completed,
        speed: _speed,
      ));
    });
    _publish();
  }

  @override
  Future<void> play() async {
    final handle = _handle;
    if (handle != null) _engine.setPause(handle, false);
    _publish();
  }

  @override
  Future<void> pause() async {
    final handle = _handle;
    if (handle != null) _engine.setPause(handle, true);
    _publish();
  }

  @override
  Future<void> stop() => _releaseSource();

  @override
  Future<void> seek(Duration position) async {
    final handle = _handle;
    if (handle == null) return;
    final max = _duration;
    final clamped = position.isNegative
        ? Duration.zero
        : max > Duration.zero && position > max
        ? max
        : position;
    _engine.seek(handle, clamped);
    _publish(position: clamped);
  }

  @override
  Future<void> setSpeed(double speed) async {
    if (!speed.isFinite) return;
    _speed = speed.clamp(0.5, 2.0);
    final handle = _handle;
    if (handle != null) _engine.setRelativePlaySpeed(handle, _speed);
    _publish();
  }

  void _publish({Duration? position}) {
    final handle = _handle;
    _snapshots.add((
      position:
          position ??
          (handle == null ? Duration.zero : _engine.getPosition(handle)),
      duration: _duration,
      buffered: _buffered,
      playing:
          handle != null &&
          _engine.getIsValidVoiceHandle(handle) &&
          !_engine.getPause(handle),
      buffering: _isBuffering,
      completed: false,
      speed: _speed,
    ));
  }

  Future<void> _releaseSource() async {
    for (final aborter in _requestAborters.values) {
      if (!aborter.isCompleted) aborter.complete();
    }
    _requestAborters.clear();
    _ticker?.cancel();
    _ticker = null;
    final handle = _handle;
    final source = _source;
    _handle = null;
    _source = null;
    _rangeRequests.clear();
    if (handle != null && _engine.isInitialized) _engine.stop(handle);
    if (source != null && _engine.isInitialized) {
      if (source.soundPath.isEmpty) _engine.resetPullBufferStream(source);
      await _engine.disposeSource(source);
    }
    final temporaryFile = _temporaryOnlineFile;
    _temporaryOnlineFile = null;
    if (temporaryFile != null && await temporaryFile.exists()) {
      await temporaryFile.delete();
    }
    _duration = Duration.zero;
    _buffered = Duration.zero;
    _expectedRemoteSize = null;
    _isBuffering = false;
    _publish();
  }

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    ++_generation;
    await _releaseSource();
    _mediaClient.close();
    await _snapshots.close();
    if (_engine.isInitialized) _engine.deinit();
    _initialized = false;
  }
}

class _RangeChunk {
  const _RangeChunk(this.bytes, this.totalBytes);
  final Uint8List bytes;
  final int totalBytes;
}

class _TrackedResponse {
  const _TrackedResponse(this.response, this.id);
  final http.StreamedResponse response;
  final int id;
}

class _RangeUnsupported implements Exception {
  const _RangeUnsupported();
}

class _StalePlaybackRequest implements Exception {
  const _StalePlaybackRequest();
}

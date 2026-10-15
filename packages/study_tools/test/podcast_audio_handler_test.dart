import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_tools/src/domain/entities/study_entities.dart';
import 'package:study_tools/src/presentation/audio/podcast_audio_handler.dart';
import 'package:study_tools/src/presentation/audio/podcast_playback_adapter.dart';

void main() {
  late _FakeAdapter adapter;
  late _FakeFocus focus;
  late _FakeAccess access;
  late _FakePositions positions;
  late PodcastAudioHandler handler;

  setUp(() {
    adapter = _FakeAdapter();
    focus = _FakeFocus();
    access = _FakeAccess();
    positions = _FakePositions()..speed = 1.5;
    handler = PodcastAudioHandler(
      adapter: adapter,
      access: access,
      positions: positions,
      focus: focus,
    );
  });

  tearDown(() async {
    await handler.dispose();
    await adapter.close();
    await focus.close();
  });

  test(
    'app and system commands share state and episode switching stops source',
    () async {
      final first = _podcast(1);
      final second = _podcast(2);

      await handler.playEpisode(first, title: 'First');
      expect(adapter.onlineUris, [Uri.parse(first.audioUrl)]);
      expect(handler.mediaItem.value?.title, 'First');
      expect(handler.playbackState.value.playing, isTrue);
      expect(adapter.speed, 1.5);

      await handler.pause();
      expect(adapter.pauses, 1);
      expect(handler.playbackState.value.playing, isFalse);

      await handler.playEpisode(second, title: 'Second');
      expect(adapter.stops, 2); // One release for each opened episode.
      expect(handler.mediaItem.value?.id, startsWith('2:'));

      await handler.fastForward();
      expect(adapter.lastSeek, const Duration(seconds: 10));
      await handler.stop();
      expect(handler.mediaItem.value, isNull);
      expect(
        handler.playbackState.value.processingState,
        AudioProcessingState.idle,
      );
    },
  );

  test('a user pause during interruption prevents automatic resume', () async {
    await handler.playEpisode(_podcast(1), title: 'Episode');
    focus.interruptionEvents.add(
      AudioInterruptionEvent(true, AudioInterruptionType.pause),
    );
    await Future<void>.delayed(Duration.zero);
    expect(handler.playbackState.value.playing, isFalse);

    await handler.pause();
    focus.interruptionEvents.add(
      AudioInterruptionEvent(false, AudioInterruptionType.pause),
    );
    await Future<void>.delayed(Duration.zero);
    expect(handler.playbackState.value.playing, isFalse);
    expect(adapter.plays, 1);
  });

  test(
    'refuses offline playback when the saved file is no longer eligible',
    () async {
      await handler.playEpisode(
        _podcast(1),
        title: 'Episode',
        preferDownload: true,
      );

      expect(adapter.downloadedPaths, isEmpty);
      expect(handler.currentError, contains('Offline access'));
      expect(
        handler.playbackState.value.processingState,
        AudioProcessingState.error,
      );
    },
  );

  test(
    'stop invalidates an episode that is still checking online access',
    () async {
      final check = Completer<bool>();
      access.onlineCheck = check;
      final opening = handler.playEpisode(_podcast(1), title: 'Episode');

      await handler.stop();
      check.complete(true);
      await opening;

      expect(handler.mediaItem.value, isNull);
      expect(adapter.onlineUris, isEmpty);
      expect(
        handler.playbackState.value.processingState,
        AudioProcessingState.idle,
      );
    },
  );

  test(
    'play command retries an interrupted audio source through the handler',
    () async {
      final episode = _podcast(1);
      await handler.playEpisode(episode, title: 'Episode');
      adapter.emitError('The stream was interrupted.');
      await Future<void>.delayed(Duration.zero);
      expect(
        handler.playbackState.value.processingState,
        AudioProcessingState.error,
      );

      await handler.play();

      expect(adapter.onlineUris, hasLength(2));
      expect(handler.playbackState.value.playing, isTrue);
    },
  );
}

StudyPodcast _podcast(int noteId) => StudyPodcast(
  id: noteId,
  noteId: noteId,
  generatedAt: DateTime.utc(2026, 10, 1),
  duration: const Duration(minutes: 2),
  audioUrl: 'https://cdn.example.test/$noteId.mp3',
  script: 'Host: Welcome.',
);

class _FakeAdapter implements PodcastPlaybackAdapter {
  final _snapshots = StreamController<PodcastPlaybackSnapshot>.broadcast();
  final _errors = StreamController<String>.broadcast();
  final List<Uri> onlineUris = [];
  final List<String> downloadedPaths = [];
  int plays = 0;
  int pauses = 0;
  int stops = 0;
  Duration? lastSeek;
  double speed = 1;

  @override
  Stream<PodcastPlaybackSnapshot> get snapshots => _snapshots.stream;
  @override
  Stream<String> get errors => _errors.stream;
  @override
  Future<void> initialize() async {}
  @override
  Future<void> openOnline(Uri uri, {Duration startAt = Duration.zero}) async {
    onlineUris.add(uri);
    _snapshots.add((
      position: startAt,
      duration: const Duration(minutes: 2),
      buffered: Duration.zero,
      playing: false,
      buffering: false,
      completed: false,
      speed: 1,
    ));
  }

  @override
  Future<void> openDownloaded(
    String path, {
    Duration startAt = Duration.zero,
  }) async {
    downloadedPaths.add(path);
  }

  @override
  Future<void> play() async {
    plays++;
    _snapshots.add((
      position: lastSeek ?? Duration.zero,
      duration: const Duration(minutes: 2),
      buffered: Duration.zero,
      playing: true,
      buffering: false,
      completed: false,
      speed: 1,
    ));
  }

  @override
  Future<void> pause() async {
    pauses++;
    _snapshots.add((
      position: Duration.zero,
      duration: const Duration(minutes: 2),
      buffered: Duration.zero,
      playing: false,
      buffering: false,
      completed: false,
      speed: 1,
    ));
  }

  @override
  Future<void> stop() async {
    stops++;
  }

  @override
  Future<void> seek(Duration position) async {
    lastSeek = position;
  }

  @override
  Future<void> setSpeed(double speed) async {
    this.speed = speed;
  }

  @override
  Future<void> dispose() async {}

  void emitError(String message) => _errors.add(message);

  Future<void> close() async {
    await _snapshots.close();
    await _errors.close();
  }
}

class _FakeAccess implements PodcastPlaybackAccessPolicy {
  Completer<bool>? onlineCheck;
  @override
  Future<bool> canListenOnline(StudyPodcast podcast) =>
      onlineCheck?.future ?? Future.value(true);
  @override
  Future<String?> eligibleDownloadPath(StudyPodcast podcast) async => null;
}

class _FakePositions implements PodcastPlaybackPositionStore {
  double speed = 1;
  @override
  Future<void> clear(StudyPodcast podcast) async {}
  @override
  Future<({Duration position, double speed})> read(
    StudyPodcast podcast,
  ) async => (position: Duration.zero, speed: speed);
  @override
  Future<void> write(
    StudyPodcast podcast,
    Duration position,
    double speed,
  ) async {}
}

class _FakeFocus implements PodcastAudioFocus {
  final interruptionEvents =
      StreamController<AudioInterruptionEvent>.broadcast();
  final noisy = StreamController<void>.broadcast();
  @override
  Stream<AudioInterruptionEvent> get interruptions => interruptionEvents.stream;
  @override
  Stream<void> get becomingNoisy => noisy.stream;
  @override
  Future<void> initialize() async {}
  @override
  Future<bool> activate() async => true;
  Future<void> close() async {
    await interruptionEvents.close();
    await noisy.close();
  }
}

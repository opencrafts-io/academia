import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/services/podcast_local_store.dart';
import '../../domain/entities/study_entities.dart';
import '../audio/podcast_audio_handler.dart';

part 'podcast_cubit.freezed.dart';

enum PodcastAccessIssue { none, subscriptionRequired, verificationUnavailable }

@freezed
abstract class PodcastCubitState with _$PodcastCubitState {
  const factory PodcastCubitState({
    @Default(<PodcastDownloadedEpisode>[])
    List<PodcastDownloadedEpisode> downloads,
    @Default(false) bool isLoadingDownloads,
    @Default(false) bool isDownloading,
    int? receivedBytes,
    int? totalBytes,
    MediaItem? currentMediaItem,
    PlaybackState? playbackState,
    String? error,
    @Default(PodcastAccessIssue.none) PodcastAccessIssue accessIssue,
  }) = _PodcastCubitState;
}

class PodcastCubit extends Cubit<PodcastCubitState> {
  PodcastCubit(this.store, this.audioHandler)
    : super(const PodcastCubitState()) {
    _playbackSubscription = audioHandler.playbackState.listen((value) {
      if (!isClosed) emit(state.copyWith(playbackState: value));
    });
    _mediaSubscription = audioHandler.mediaItem.listen((value) {
      if (!isClosed) emit(state.copyWith(currentMediaItem: value));
    });
    _errorSubscription = audioHandler.errors.listen((value) {
      if (value != null && !isClosed) emit(state.copyWith(error: value));
    });
  }

  final PodcastLocalStore store;
  final PodcastAudioHandler audioHandler;
  late final StreamSubscription<PlaybackState> _playbackSubscription;
  late final StreamSubscription<MediaItem?> _mediaSubscription;
  late final StreamSubscription<String?> _errorSubscription;

  Future<void> loadDownloads() async {
    emit(state.copyWith(isLoadingDownloads: true, error: null));
    try {
      final downloads = await store.downloads();
      if (!isClosed) {
        emit(state.copyWith(downloads: downloads, isLoadingDownloads: false));
      }
    } on Object {
      if (!isClosed) {
        emit(
          state.copyWith(
            isLoadingDownloads: false,
            error: 'Saved episodes could not be loaded. Try again.',
          ),
        );
      }
    }
  }

  Future<void> play({
    required StudyPodcast podcast,
    required String title,
    String? courseLabel,
    bool offline = false,
  }) => audioHandler.playEpisode(
    podcast,
    title: title,
    courseLabel: courseLabel,
    preferDownload: offline,
  );

  Future<void> download({
    required StudyPodcast podcast,
    required String title,
    required String courseLabel,
  }) async {
    if (state.isDownloading) return;
    emit(
      state.copyWith(
        isDownloading: true,
        receivedBytes: 0,
        totalBytes: null,
        error: null,
        accessIssue: PodcastAccessIssue.none,
      ),
    );
    try {
      await store.download(
        podcast: podcast,
        title: title,
        courseLabel: courseLabel,
        onProgress: (received, total) {
          if (!isClosed) {
            emit(state.copyWith(receivedBytes: received, totalBytes: total));
          }
        },
      );
      await loadDownloads();
      if (!isClosed) emit(state.copyWith(isDownloading: false));
    } on PodcastSubscriptionException catch (error) {
      if (!isClosed) {
        emit(
          state.copyWith(
            isDownloading: false,
            error: error.message,
            accessIssue: error.verificationUnavailable
                ? PodcastAccessIssue.verificationUnavailable
                : error.upgradeRequired
                ? PodcastAccessIssue.subscriptionRequired
                : PodcastAccessIssue.none,
          ),
        );
      }
    } on Object {
      if (!isClosed) {
        emit(
          state.copyWith(
            isDownloading: false,
            error: 'The episode could not be saved. Check your connection and retry.',
          ),
        );
      }
    }
  }

  Future<void> cancelDownload(StudyPodcast podcast) async {
    await store.cancelDownload(podcast);
    if (!isClosed) {
      emit(
        state.copyWith(
          isDownloading: false,
          receivedBytes: null,
          totalBytes: null,
        ),
      );
    }
  }

  Future<void> removeDownload(PodcastDownloadedEpisode episode) async {
    final media = audioHandler.mediaItem.value;
    final matchesActive =
        media?.extras?['noteId'] == episode.noteId &&
        media?.id.endsWith(':${episode.episodeKey}') == true;
    if (matchesActive) await audioHandler.stop();
    await store.removeDownload(episode);
    await loadDownloads();
  }

  void dismissError() {
    emit(state.copyWith(error: null, accessIssue: PodcastAccessIssue.none));
  }

  @override
  Future<void> close() async {
    await _playbackSubscription.cancel();
    await _mediaSubscription.cancel();
    await _errorSubscription.cancel();
    return super.close();
  }
}

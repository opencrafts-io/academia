import 'dart:async';

import 'package:core/core.dart';
import 'package:analytics/analytics.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/study_entities.dart';
import '../../domain/repositories/study_tools_repository.dart';
import '../../data/services/podcast_local_store.dart';
import '../audio/podcast_audio_handler.dart';

part 'study_tools_cubit.freezed.dart';

enum StudyLoadStatus { initial, loading, loaded, failure }

@freezed
abstract class StudyToolsState with _$StudyToolsState {
  const factory StudyToolsState({
    @Default(StudyLoadStatus.initial) StudyLoadStatus status,
    @Default(<StudyMaterial>[]) List<StudyMaterial> materials,
    StudyMaterial? selectedMaterial,
    StudyPodcast? podcast,
    @Default(false) bool isLoadingPodcast,
    @Default(false) bool isGeneratingPodcast,
    @Default(<QuestionFormat, List<QuestionSet>>{})
    Map<QuestionFormat, List<QuestionSet>> questionSets,
    QuestionFormat? loadingFormat,
    @Default(<int, int>{}) Map<int, int> jobs,
    @Default(<int, List<String>>{}) Map<int, List<String>> jobOutputs,
    String? error,
    String? errorCode,
    @Default(false) bool isUploading,
    @Default(false) bool generationBlocked,
  }) = _StudyToolsState;
}

class StudyToolsCubit extends SafeCubit<StudyToolsState>
    with WidgetsBindingObserver {
  StudyToolsCubit(
    this.repository, {
    this.podcastStore,
    this.audioHandler,
    this.analyticsTracker,
  }) : super(const StudyToolsState()) {
    WidgetsBinding.instance.addObserver(this);
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      if (results.any((result) => result != ConnectivityResult.none)) {
        unawaited(recoverSavedJobs());
      } else {
        _pausePolling();
      }
    });
  }
  final StudyToolsRepository repository;
  final PodcastLocalStore? podcastStore;
  final PodcastAudioHandler? audioHandler;
  final AnalyticsTracker? analyticsTracker;
  final Map<int, Timer> _timers = {};
  final Set<int> _polling = {};
  late final StreamSubscription<List<ConnectivityResult>>
  _connectivitySubscription;
  bool _hasLoadedMaterials = false;

  void _track(AnalyticsFeatureAction action) {
    final tracker = analyticsTracker;
    if (tracker != null) {
      unawaited(
        tracker.track(
          AnalyticsEvent.featureAction(
            featurePackage: AnalyticsFeaturePackage.studyTools,
            action: action,
          ),
        ),
      );
    }
  }

  Future<void> loadMaterials({bool force = false}) async {
    if (_hasLoadedMaterials && !force) {
      unawaited(recoverSavedJobs());
      return;
    }
    emit(
      state.copyWith(
        status: StudyLoadStatus.loading,
        error: null,
        errorCode: null,
      ),
    );
    final result = await repository.allMaterials();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: StudyLoadStatus.failure,
          error: _readFailureMessage(failure),
          errorCode: _readFailureCode(failure),
        ),
      ),
      (items) {
        _hasLoadedMaterials = true;
        emit(
          state.copyWith(
            status: StudyLoadStatus.loaded,
            materials: items,
            generationBlocked: false,
          ),
        );
        unawaited(recoverSavedJobs());
      },
    );
  }

  Future<void> loadMaterial(int id, {bool loadPodcastMetadata = true}) async {
    emit(
      state.copyWith(
        status: StudyLoadStatus.loading,
        error: null,
        errorCode: null,
        generationBlocked: false,
      ),
    );
    final result = await repository.material(id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: StudyLoadStatus.failure,
          error: _readFailureMessage(failure),
          errorCode: _readFailureCode(failure),
        ),
      ),
      (material) {
        _track(AnalyticsFeatureAction.materialOpened);
        emit(
          state.copyWith(
            status: StudyLoadStatus.loaded,
            selectedMaterial: material,
            podcast: null,
          ),
        );
        if (loadPodcastMetadata) unawaited(loadPodcast());
        unawaited(recoverSavedJobs());
      },
    );
  }

  Future<void> upload({
    required PlatformFile file,
    String? courseId,
    String? courseLabel,
  }) async {
    if (state.isUploading) return;
    emit(state.copyWith(isUploading: true, error: null, errorCode: null));
    final result = await repository.upload(
      file: file,
      courseId: courseId,
      courseLabel: courseLabel,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          isUploading: false,
          error: failure.message,
          errorCode: _failureCode(failure),
        ),
      ),
      (material) {
        _track(AnalyticsFeatureAction.materialUploaded);
        emit(
          state.copyWith(
            isUploading: false,
            selectedMaterial: material,
            error: null,
            errorCode: null,
          ),
        );
      },
    );
  }

  Future<void> generate(QuestionFormat format) async {
    final material = state.selectedMaterial;
    if (material == null ||
        state.loadingFormat != null ||
        state.isGeneratingPodcast ||
        state.generationBlocked) {
      return;
    }
    emit(state.copyWith(loadingFormat: format, error: null, errorCode: null));
    final result = await repository.generate(material.id, format);
    await result.fold<Future<void>>(
      (failure) async {
        final code = _failureCode(failure);
        final jobs = code == 'job_already_running'
            ? await repository.savedJobs()
            : state.jobs;
        final savedJobId = jobs[material.id];
        if (savedJobId != null) {
          _startPolling(material.id, savedJobId);
        }
        if (isClosed) return;
        emit(
          state.copyWith(
            jobs: jobs,
            loadingFormat: null,
            generationBlocked: code == 'job_already_running',
            error: code == 'job_already_running'
                ? 'Generation is already in progress. Refresh the materials to check for new questions.'
                : failure.message,
            errorCode: code,
          ),
        );
      },
      (jobId) async {
        _track(AnalyticsFeatureAction.questionGenerationStarted);
        await repository.saveJob(
          material.id,
          jobId,
          outputs: const ['questions'],
          questionFormat: format,
        );
        final jobs = await repository.savedJobs();
        emit(
          state.copyWith(
            jobs: jobs,
            jobOutputs: {
              ...state.jobOutputs,
              material.id: const ['questions'],
            },
            error: null,
            errorCode: null,
          ),
        );
        _startPolling(material.id, jobId);
      },
    );
  }

  Future<void> loadPodcast() async {
    final noteId = state.selectedMaterial?.id;
    if (noteId == null || state.isLoadingPodcast) return;
    emit(state.copyWith(isLoadingPodcast: true, error: null, errorCode: null));
    final result = await repository.podcast(noteId);
    result.fold(
      (failure) {
        final code = _failureCode(failure);
        emit(
          state.copyWith(
            isLoadingPodcast: false,
            error: code == 'not_found' ? null : _readFailureMessage(failure),
            errorCode: code == 'not_found' ? null : _readFailureCode(failure),
          ),
        );
      },
      (podcast) => emit(
        state.copyWith(
          podcast: podcast,
          isLoadingPodcast: false,
          error: null,
          errorCode: null,
        ),
      ),
    );
  }

  Future<void> loadPodcastVersion(String episodeKey) async {
    final noteId = state.selectedMaterial?.id;
    if (noteId == null) return;
    final result = await repository.podcastVersion(noteId, episodeKey);
    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (podcast) =>
          emit(state.copyWith(podcast: podcast, error: null, errorCode: null)),
    );
  }

  Future<void> generatePodcast() async {
    final material = state.selectedMaterial;
    if (material == null ||
        state.isGeneratingPodcast ||
        state.loadingFormat != null ||
        state.jobs.containsKey(material.id) ||
        state.generationBlocked) {
      return;
    }
    emit(
      state.copyWith(isGeneratingPodcast: true, error: null, errorCode: null),
    );
    final result = await repository.generatePodcast(material.id);
    await result.fold(
      (failure) async {
        final code = _failureCode(failure);
        final jobs = await repository.savedJobs();
        if (code == 'job_already_running' && jobs.containsKey(material.id)) {
          _startPolling(material.id, jobs[material.id]!);
        } else if (code == 'job_already_running') {
          await loadMaterial(material.id);
          await loadPodcast();
        }
        if (isClosed) return;
        emit(
          state.copyWith(
            isGeneratingPodcast: false,
            jobs: jobs,
            generationBlocked: code == 'job_already_running',
            error: code == 'job_already_running'
                ? 'Generation is already running for this material. Refresh the podcast after it finishes.'
                : failure.message,
            errorCode: code,
          ),
        );
      },
      (jobId) async {
        _track(AnalyticsFeatureAction.podcastGenerationStarted);
        await repository.saveJob(
          material.id,
          jobId,
          outputs: const ['podcast'],
        );
        final jobs = await repository.savedJobs();
        if (isClosed) return;
        emit(
          state.copyWith(
            jobs: jobs,
            jobOutputs: {
              ...state.jobOutputs,
              material.id: const ['podcast'],
            },
            isGeneratingPodcast: true,
            error: null,
            errorCode: null,
          ),
        );
        _startPolling(material.id, jobId);
      },
    );
  }

  Future<void> loadQuestions(QuestionFormat format) async {
    if (isClosed) return;
    final noteId = state.selectedMaterial?.id;
    if (noteId == null) return;
    emit(state.copyWith(loadingFormat: format, error: null, errorCode: null));
    final result = await repository.questionSets(noteId, format);
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          loadingFormat: null,
          error: failure.message,
          errorCode: _failureCode(failure),
        ),
      ),
      (sets) {
        _track(AnalyticsFeatureAction.practiceOpened);
        final newestFirst = [...sets]
          ..sort((a, b) => b.generatedAt.compareTo(a.generatedAt));
        emit(
          state.copyWith(
            questionSets: {...state.questionSets, format: newestFirst},
            loadingFormat: null,
            error: null,
            errorCode: null,
          ),
        );
      },
    );
  }

  Future<bool> deleteMaterial(int id) async {
    final result = await repository.delete(id);
    return await result.fold<Future<bool>>(
      (failure) async {
        emit(
          state.copyWith(
            error: failure.message,
            errorCode: _failureCode(failure),
          ),
        );
        return false;
      },
      (_) async {
        _track(AnalyticsFeatureAction.materialDeleted);
        _timers.remove(id)?.cancel();
        String? cleanupFailure;
        try {
          await audioHandler?.discardIfNote(id);
          await podcastStore?.removeMaterialFiles(id);
        } on Object {
          cleanupFailure = 'The material was deleted, but its saved audio could not be fully removed from this device.';
        }
        emit(
          state.copyWith(
            materials: state.materials.where((m) => m.id != id).toList(),
            selectedMaterial: null,
            error: cleanupFailure,
            errorCode: cleanupFailure == null ? null : 'local_cleanup_failed',
          ),
        );
        return true;
      },
    );
  }

  Future<void> recoverSavedJobs() async {
    final jobs = await repository.savedJobs();
    if (isClosed) return;
    emit(state.copyWith(jobs: jobs));
    for (final entry in jobs.entries) {
      if (state.selectedMaterial == null ||
          state.selectedMaterial!.id == entry.key ||
          state.materials.any((m) => m.id == entry.key)) {
        _startPolling(entry.key, entry.value);
      }
    }
  }

  void _startPolling(int noteId, int jobId) {
    if (_timers.containsKey(noteId) || isClosed) return;
    _timers[noteId] = Timer.periodic(
      const Duration(seconds: 3),
      (_) => unawaited(_poll(noteId, jobId)),
    );
    unawaited(_poll(noteId, jobId));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(recoverSavedJobs());
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _pausePolling();
    }
  }

  void _pausePolling() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
  }

  Future<void> _poll(int noteId, int jobId) async {
    if (_polling.contains(noteId) || isClosed) return;
    _polling.add(noteId);
    try {
      final result = await repository.job(jobId);
      await result.fold(
        (_) async {
          // A transient network problem leaves the saved job recoverable.
          _timers.remove(noteId)?.cancel();
        },
        (job) async {
          if (job.outputs.isNotEmpty && !isClosed) {
            emit(
              state.copyWith(
                jobOutputs: {...state.jobOutputs, noteId: job.outputs},
              ),
            );
          }
          if (job.noteId != noteId) {
            _timers.remove(noteId)?.cancel();
            if (!isClosed) {
              emit(
                state.copyWith(
                  error: 'Generation status could not be matched to this material. Refresh it later.',
                ),
              );
            }
            return;
          }
          if (job.status == 'done' || job.status == 'failed') {
            _timers.remove(noteId)?.cancel();
            final jobs = await repository.savedJobs();
            jobs.remove(noteId);
            await repository.removeJob(noteId);
            if (isClosed) return;
            final jobOutputs = {...state.jobOutputs}..remove(noteId);
            emit(
              state.copyWith(
                jobs: jobs,
                jobOutputs: jobOutputs,
                loadingFormat: null,
                isGeneratingPodcast: false,
                generationBlocked: false,
                error: job.status == 'failed'
                    ? (job.failureMessage ?? _jobFailure(job.failureCode))
                    : null,
                errorCode: job.status == 'failed' ? job.failureCode : null,
              ),
            );
            if (job.status == 'done' && state.selectedMaterial?.id == noteId) {
              await loadMaterial(noteId);
              if (job.outputs.contains('questions')) {
                await loadQuestionsForOutputs(job.outputs);
              }
              if (job.outputs.contains('podcast')) {
                await loadPodcast();
              }
            }
          }
        },
      );
    } finally {
      _polling.remove(noteId);
    }
  }

  Future<void> loadQuestionsForOutputs(List<String> outputs) async {
    if (!outputs.contains('questions')) return;
    for (final format in QuestionFormat.values) {
      await loadQuestions(format);
    }
  }

  @override
  Future<void> close() async {
    _pausePolling();
    WidgetsBinding.instance.removeObserver(this);
    await _connectivitySubscription.cancel();
    return super.close();
  }

  String? _failureCode(Failure failure) =>
      failure.maybeMap(server: (e) => e.code, orElse: () => null);

  String _readFailureMessage(Failure failure) =>
      _failureCode(failure) == 'entitlement_required'
      ? 'Professor currently requires an active subscription to open study materials. Existing podcast listening for non-subscribers needs an update to Professor access rules.'
      : failure.message;

  String? _readFailureCode(Failure failure) =>
      _failureCode(failure) == 'entitlement_required'
      ? 'podcast_read_access_unavailable'
      : failure is NetworkFailure
      ? 'network_unavailable'
      : _failureCode(failure);
  String _jobFailure(String? code) => switch (code) {
    'unsupported_file_type' =>
      'This file type could not be processed. Try another supported document.',
    'file_too_large' => 'This document is too large to process.',
    'provider_failed' || 'llm_provider_error' =>
      'The AI service is temporarily unavailable. Please try again later.',
    'output_failed' || 'llm_invalid_output' =>
      'The generated study content could not be prepared. Please retry.',
    'tts_provider_error' =>
      'Audio generation is temporarily unavailable. Please retry the podcast.',
    'conversion_failed' =>
      'The podcast audio could not be converted. Please retry generation.',
    'file_unreadable' => 'This document could not be read to create a podcast.',
    'entitlement_required' =>
      'A subscription is required to generate study content.',
    'entitlement_unavailable' =>
      'Subscription access could not be verified. Try again.',
    _ => 'Study content generation failed. Please retry.',
  };
}

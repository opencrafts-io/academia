import 'dart:async';

import 'package:core/core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/study_entities.dart';
import '../../domain/repositories/study_tools_repository.dart';

part 'study_tools_cubit.freezed.dart';

enum StudyLoadStatus { initial, loading, loaded, failure }

@freezed
abstract class StudyToolsState with _$StudyToolsState {
  const factory StudyToolsState({
    @Default(StudyLoadStatus.initial) StudyLoadStatus status,
    @Default(<StudyMaterial>[]) List<StudyMaterial> materials,
    StudyMaterial? selectedMaterial,
    @Default(<QuestionFormat, List<QuestionSet>>{})
    Map<QuestionFormat, List<QuestionSet>> questionSets,
    QuestionFormat? loadingFormat,
    @Default(<int, int>{}) Map<int, int> jobs,
    String? error,
    String? errorCode,
    @Default(false) bool isUploading,
    @Default(false) bool generationBlocked,
  }) = _StudyToolsState;
}

class StudyToolsCubit extends Cubit<StudyToolsState>
    with WidgetsBindingObserver {
  StudyToolsCubit(this.repository) : super(const StudyToolsState()) {
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
  final Map<int, Timer> _timers = {};
  final Set<int> _polling = {};
  late final StreamSubscription<List<ConnectivityResult>>
  _connectivitySubscription;
  bool _hasLoadedMaterials = false;

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
          error: failure.message,
          errorCode: _failureCode(failure),
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

  Future<void> loadMaterial(int id) async {
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
          error: failure.message,
          errorCode: _failureCode(failure),
        ),
      ),
      (material) {
        emit(
          state.copyWith(
            status: StudyLoadStatus.loaded,
            selectedMaterial: material,
          ),
        );
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
      (material) => emit(
        state.copyWith(
          isUploading: false,
          selectedMaterial: material,
          error: null,
          errorCode: null,
        ),
      ),
    );
  }

  Future<void> generate(QuestionFormat format) async {
    final material = state.selectedMaterial;
    if (material == null ||
        state.loadingFormat != null ||
        state.generationBlocked) {
      return;
    }
    emit(state.copyWith(loadingFormat: format, error: null, errorCode: null));
    final result = await repository.generate(material.id, format);
    result.fold(
      (failure) {
        final code = _failureCode(failure);
        emit(
          state.copyWith(
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
        await repository.saveJob(material.id, jobId);
        final jobs = await repository.savedJobs();
        emit(state.copyWith(jobs: jobs, error: null, errorCode: null));
        _startPolling(material.id, jobId);
      },
    );
  }

  Future<void> loadQuestions(QuestionFormat format) async {
    final noteId = state.selectedMaterial?.id;
    if (noteId == null) return;
    emit(state.copyWith(loadingFormat: format, error: null, errorCode: null));
    final result = await repository.questionSets(noteId, format);
    result.fold(
      (failure) => emit(
        state.copyWith(
          loadingFormat: null,
          error: failure.message,
          errorCode: _failureCode(failure),
        ),
      ),
      (sets) {
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
    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            error: failure.message,
            errorCode: _failureCode(failure),
          ),
        );
        return false;
      },
      (_) {
        _timers.remove(id)?.cancel();
        emit(
          state.copyWith(
            materials: state.materials.where((m) => m.id != id).toList(),
            selectedMaterial: null,
            error: null,
            errorCode: null,
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
            emit(
              state.copyWith(
                jobs: jobs,
                error: job.status == 'failed'
                    ? (job.failureMessage ?? _jobFailure(job.failureCode))
                    : null,
                errorCode: job.status == 'failed' ? job.failureCode : null,
              ),
            );
            if (job.status == 'done' && state.selectedMaterial?.id == noteId) {
              await loadMaterial(noteId);
              await loadQuestionsForOutputs(job.outputs);
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
  String _jobFailure(String? code) => switch (code) {
    'unsupported_file_type' =>
      'This file type could not be processed. Try another supported document.',
    'file_too_large' => 'This document is too large to process.',
    'conversion_failed' =>
      'The document could not be converted. Try uploading it again.',
    'provider_failed' =>
      'Question generation is temporarily unavailable. Try again later.',
    'output_failed' =>
      'Questions could not be prepared. Please retry generation.',
    _ => 'Question generation failed. Please retry.',
  };
}

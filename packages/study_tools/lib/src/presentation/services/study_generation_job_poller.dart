import 'dart:async';

import '../../domain/entities/study_entities.dart';
import '../../domain/repositories/study_tools_repository.dart';

typedef StudyJobOutputsCallback = void Function(
  int noteId,
  List<String> outputs,
);
typedef StudyJobMismatchCallback = void Function(int noteId);
typedef StudyJobCompletedCallback = Future<void> Function(
  int noteId,
  GenerationJob job,
  Map<int, int> jobs,
);

/// Owns the timer and overlap protection for background study generation jobs.
class StudyGenerationJobPoller {
  StudyGenerationJobPoller({
    required StudyToolsRepository repository,
    required StudyJobOutputsCallback onOutputs,
    required StudyJobMismatchCallback onMismatch,
    required StudyJobCompletedCallback onCompleted,
  }) : _repository = repository,
       _onOutputs = onOutputs,
       _onMismatch = onMismatch,
       _onCompleted = onCompleted;

  final StudyToolsRepository _repository;
  final StudyJobOutputsCallback _onOutputs;
  final StudyJobMismatchCallback _onMismatch;
  final StudyJobCompletedCallback _onCompleted;
  final Map<int, Timer> _timers = {};
  final Set<int> _polling = {};
  bool _disposed = false;

  void start(int noteId, int jobId) {
    if (_disposed || _timers.containsKey(noteId)) return;
    _timers[noteId] = Timer.periodic(
      const Duration(seconds: 3),
      (_) => unawaited(_poll(noteId, jobId)),
    );
    unawaited(_poll(noteId, jobId));
  }

  void cancel(int noteId) {
    _timers.remove(noteId)?.cancel();
  }

  void pause() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
  }

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    pause();
  }

  Future<void> _poll(int noteId, int jobId) async {
    if (_disposed || _polling.contains(noteId)) return;
    _polling.add(noteId);
    try {
      final result = await _repository.job(jobId);
      await result.fold(
        (_) async {
          // A transient network problem leaves the saved job recoverable.
          cancel(noteId);
        },
        (job) async {
          if (job.outputs.isNotEmpty) {
            _onOutputs(noteId, job.outputs);
          }
          if (job.noteId != noteId) {
            cancel(noteId);
            _onMismatch(noteId);
            return;
          }
          if (job.status != GenerationJobStatus.done &&
              job.status != GenerationJobStatus.failed) {
            return;
          }

          cancel(noteId);
          final jobs = await _repository.savedJobs();
          jobs.remove(noteId);
          await _repository.removeJob(noteId);
          await _onCompleted(noteId, job, jobs);
        },
      );
    } finally {
      _polling.remove(noteId);
    }
  }
}

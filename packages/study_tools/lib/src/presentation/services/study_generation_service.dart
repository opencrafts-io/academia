import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/study_entities.dart';
import '../../domain/repositories/study_tools_repository.dart';

class StudyGenerationService {
  StudyGenerationService(this.repository);

  final StudyToolsRepository repository;

  Future<Either<Failure, int>> startQuestions(
    int noteId,
    QuestionFormat format,
  ) async {
    final result = await repository.generate(noteId, format);
    return result.fold((failure) => Left(failure), (jobId) async {
      await repository.saveJob(
        noteId,
        jobId,
        outputs: const ['questions'],
        questionFormat: format,
      );
      return Right(jobId);
    });
  }

  Future<Either<Failure, int>> startPodcast(int noteId) async {
    final result = await repository.generatePodcast(noteId);
    return result.fold((failure) => Left(failure), (jobId) async {
      await repository.saveJob(noteId, jobId, outputs: const ['podcast']);
      return Right(jobId);
    });
  }
}

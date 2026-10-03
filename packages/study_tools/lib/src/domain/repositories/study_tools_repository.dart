import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';

import '../entities/study_entities.dart';

abstract interface class StudyToolsRepository {
  Future<Either<Failure, List<StudyMaterial>>> allMaterials();
  Future<Either<Failure, StudyMaterial>> material(int noteId);
  Future<Either<Failure, StudyMaterial>> upload({
    required PlatformFile file,
    String? courseId,
    String? courseLabel,
  });
  Future<Either<Failure, int>> generate(int noteId, QuestionFormat format);
  Future<Either<Failure, GenerationJob>> job(int jobId);
  Future<Either<Failure, List<QuestionSet>>> questionSets(
    int noteId,
    QuestionFormat format,
  );
  Future<Either<Failure, Unit>> delete(int noteId);
  Future<Map<int, int>> savedJobs();
  Future<void> saveJob(int noteId, int jobId);
  Future<void> removeJob(int noteId);
}

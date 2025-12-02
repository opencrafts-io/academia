import 'package:academia/core/error/failures.dart';
import 'package:academia/features/exam_timetable/domain/repository/exam_timetable_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteExamByCourseCodeUseCase {
  final ExamTimetableRepository repository;

  DeleteExamByCourseCodeUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String courseCode,
    required String institutionId,
  }) {
    return repository.deleteExamByCourseCode(
      courseCode: courseCode,
      // institutionId: institutionId,
    );
  }
}


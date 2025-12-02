import 'package:academia/core/error/failures.dart';
import 'package:academia/features/exam_timetable/domain/domain.dart';
import 'package:dartz/dartz.dart';

class RefreshExamTimetableUseCase {
  final ExamTimetableRepository repository;

  RefreshExamTimetableUseCase(this.repository);

  Future<Either<Failure, List<ExamTimetable>>> call({
    required String institutionId,
    List<String>? courseCodes,
  }) {
    return repository.refreshExamTimetable(
      institutionId: institutionId,
      courseCodes: courseCodes,
    );
  }
}

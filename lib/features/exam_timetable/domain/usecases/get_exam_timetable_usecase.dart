import 'package:academia/core/error/failures.dart';
import 'package:academia/features/exam_timetable/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetExamTimetableUseCase {
  final ExamTimetableRepository repository;

  GetExamTimetableUseCase(this.repository);

  Future<Either<Failure, List<ExamTimetable>>> call({
    required String institutionId,
    required List<String> courseCodes,
  }) {
    return repository.getExamTimetable(
      institutionId: institutionId,
      courseCodes: courseCodes,
    );
  }
}

import 'package:academia/core/error/failures.dart';
import 'package:academia/features/exam_timetable/domain/domain.dart';
import 'package:dartz/dartz.dart';

class CacheExamsUseCase {
  final ExamTimetableRepository repository;

  CacheExamsUseCase(this.repository);

  Future<Either<Failure, void>> call(List<ExamTimetable> exams) {
    return repository.saveExamsToTimetable(exams);
  }
}
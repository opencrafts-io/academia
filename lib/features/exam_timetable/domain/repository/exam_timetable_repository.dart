import 'package:academia/core/error/failures.dart';
import 'package:academia/features/exam_timetable/domain/entity/exam_timetable.dart';
import 'package:dartz/dartz.dart';

abstract class ExamTimetableRepository {
  Future<Either<Failure, List<ExamTimetable>>> getCachedExams({
    required int institutionId,
    List<String>? courseCodes,
  });

  Future<Either<Failure, List<ExamTimetable>>> getExamTimetable({
    required int institutionId,
    required List<String> courseCodes,
  });

  Future<Either<Failure, void>> saveExamsToTimetable(List<ExamTimetable> exams);

  Future<Either<Failure, List<ExamTimetable>>> refreshExamTimetable({
    required int institutionId,
    List<String>? courseCodes,
  });

  Future<Either<Failure, void>> deleteExamByCourseCode({
    required String courseCode,
    required int institutionId,
  });
}

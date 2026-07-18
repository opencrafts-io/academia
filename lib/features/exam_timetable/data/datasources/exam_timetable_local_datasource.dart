import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class ExamTimetableLocalDataSource {
  final AppDataBase localDB;

  ExamTimetableLocalDataSource({required this.localDB});

  Future<Either<Failure, List<ExamTimetable>>> getCachedExams({
    required int institutionId,
    List<String>? courseCodes,
  }) async {
    try {
      final query = localDB.select(localDB.examTimetables)
        ..where((t) => t.institutionId.equals(institutionId));

      if (courseCodes != null && courseCodes.isNotEmpty) {
        query.where((t) => t.courseCode.isIn(courseCodes));
      }

      query.orderBy([
        (exam) =>
            OrderingTerm(expression: exam.datetimeStr, mode: OrderingMode.asc),
        (exam) =>
            OrderingTerm(expression: exam.startTime, mode: OrderingMode.asc),
      ]);

      final results = await query.get();
      return right(results);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message: "Failed to retrieve cached exam timetable",
        ),
      );
    }
  }

  Future<Either<Failure, ExamTimetable>> createOrUpdateExam(
    ExamTimetable exam,
  ) async {
    try {
      final created = await localDB
          .into(localDB.examTimetables)
          .insertReturning(exam, onConflict: DoUpdate((e) => exam));
      return right(created);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message: "Failed to save exam to local database",
        ),
      );
    }
  }

  Future<Either<Failure, void>> createOrUpdateExamBatch(
    List<ExamTimetable> exams,
  ) async {
    try {
      await localDB.batch((batch) {
        batch.insertAll(
          localDB.examTimetables,
          exams,
          mode: InsertMode.insertOrReplace,
        );
      });
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message: "Failed to save exam timetable batch",
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteExamByCourseCode({
    required String courseCode,
    required int institutionId,
  }) async {
    try {
      await (localDB.delete(localDB.examTimetables)..where(
            (t) =>
                t.courseCode.equals(courseCode) &
                t.institutionId.equals(institutionId),
          ))
          .go();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message: "Failed to delete exam from local database",
        ),
      );
    }
  }
}

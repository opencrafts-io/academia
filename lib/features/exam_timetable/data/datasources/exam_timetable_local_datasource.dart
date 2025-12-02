import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class ExamTimetableLocalDataSource {
  final AppDataBase localDB;

  ExamTimetableLocalDataSource({required this.localDB});

  Future<Either<Failure, List<ExamTimetableData>>> getCachedExams({
    required String institutionId,
    List<String>? courseCodes,
  }) async {
    try {
      final query = localDB.select(localDB.examTimetable)
        ..where((t) => t.institutionId.equals(institutionId));

      if (courseCodes != null && courseCodes.isNotEmpty) {
        query.where((t) => t.courseCode.isIn(courseCodes));
      }

      query.orderBy([
        (exam) => OrderingTerm(expression: exam.day, mode: OrderingMode.asc),
        (exam) => OrderingTerm(expression: exam.time, mode: OrderingMode.asc),
      ]);

      final results = await query.get();
      return right(results);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "School's Out" - Alice Cooper
              "School's out! We couldn't retrieve your exam timetable from the local database. The halls are eerily silent!",
        ),
      );
    }
  }

  Future<Either<Failure, ExamTimetableData>> createOrUpdateExam(
    ExamTimetableData exam,
  ) async {
    try {
      final created = await localDB
          .into(localDB.examTimetable)
          .insertReturning(exam, onConflict: DoUpdate((e) => exam));
      return right(created);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Back to School" - Deftones
              "Back to school malfunction! We couldn't save your exam locally. The database is skipping class!",
        ),
      );
    }
  }

  Future<Either<Failure, void>> createOrUpdateExamBatch(
    List<ExamTimetableData> exams,
  ) async {
    try {
      await localDB.batch((batch) {
        batch.insertAll(
          localDB.examTimetable,
          exams,
          mode: InsertMode.insertOrReplace,
        );
      });
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "We're Not Gonna Take It" - Twisted Sister
              "We're not gonna take it! The batch save failed. The database is in rebellion!",
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteExamByCourseCode({
    required String courseCode,
    required String institutionId,
  }) async {
    try {
      await (localDB.delete(localDB.examTimetable)..where(
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
          message:
              // "Don't Stand So Close to Me" - The Police
              "Don't stand so close to me! That exam won't budge from the database. It's clinging on tight!",
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteExamsByCourseCodes({
    required List<String> courseCodes,
    required String institutionId,
  }) async {
    try {
      await (localDB.delete(localDB.examTimetable)..where(
            (t) =>
                t.courseCode.isIn(courseCodes) &
                t.institutionId.equals(institutionId),
          ))
          .go();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Wipe Out" - The Surfaris
              "Wipe out! We couldn't clear the exam timetable. The database is hanging ten!",
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteAllExamsByInstitution(
    String institutionId,
  ) async {
    try {
      await (localDB.delete(
        localDB.examTimetable,
      )..where((t) => t.institutionId.equals(institutionId))).go();
      return right(null);
    } catch (e) {
      return left(
        CacheFailure(
          error: e,
          message:
              // "Wipe Out" - The Surfaris
              "Wipe out! We couldn't clear the exam timetable. The database is hanging ten!",
        ),
      );
    }
  }
}

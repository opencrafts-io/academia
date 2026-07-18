import 'package:academia/core/error/failures.dart';
import 'package:academia/features/exam_timetable/data/data.dart';
import 'package:academia/features/exam_timetable/domain/domain.dart';
import 'package:dartz/dartz.dart';

class ExamTimetableRepositoryImpl implements ExamTimetableRepository {
  final ExamTimetableLocalDataSource localDataSource;
  final ExamTimetableRemoteDatasource remoteDataSource;
  final ExamNotificationService examNotificationService;

  ExamTimetableRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.examNotificationService,
  });

  @override
  Future<Either<Failure, List<ExamTimetable>>> getCachedExams({
    required int institutionId,
    List<String>? courseCodes,
  }) async {
    final result = await localDataSource.getCachedExams(
      institutionId: institutionId,
      courseCodes: courseCodes,
    );
    return result.map(
      (dataList) => dataList.map((data) => data.toDomainEntity()).toList(),
    );
  }

  @override
  Future<Either<Failure, List<ExamTimetable>>> getExamTimetable({
    required int institutionId,
    required List<String> courseCodes,
  }) async {
    final result = await remoteDataSource.getExamTimetable(
      institutionId: institutionId,
      courseCodes: courseCodes,
    );

    return result.fold((failure) => left(failure), (examList) {
      return right(examList.map((data) => data.toDomainEntity()).toList());
    });
  }

  @override
  Future<Either<Failure, void>> saveExamsToTimetable(
    List<ExamTimetable> exams,
  ) async {
    final dataModels = exams.map((e) => e.toModel()).toList();

    final result = await localDataSource.createOrUpdateExamBatch(dataModels);

    result.fold((_) {}, (_) {
      for (final exam in exams) {
        examNotificationService.scheduleReminder(exam);
      }
    });

    return result;
  }

  @override
  Future<Either<Failure, List<ExamTimetable>>> refreshExamTimetable({
    required int institutionId,
    List<String>? courseCodes,
  }) async {
    final result = await remoteDataSource.refreshExamTimetable(
      institutionId: institutionId,
      courseCodes: courseCodes,
    );

    return result.fold((failure) => left(failure), (examList) async {
      final domainExams = examList
          .map((data) => data.toDomainEntity())
          .toList();

      if (examList.isNotEmpty) {
        final saveResult = await localDataSource.createOrUpdateExamBatch(
          examList,
        );
        saveResult.fold((_) {}, (_) {
          for (final exam in domainExams) {
            examNotificationService.scheduleReminder(exam);
          }
        });
      }

      return right(domainExams);
    });
  }

  @override
  Future<Either<Failure, void>> deleteExamByCourseCode({
    required String courseCode,
    required int institutionId,
  }) async {
    final result = await localDataSource.deleteExamByCourseCode(
      courseCode: courseCode,
      institutionId: institutionId,
    );

    result.fold((_) {}, (_) {
      examNotificationService.cancelReminder(
        institutionId: institutionId,
        courseCode: courseCode,
      );
    });

    return result;
  }
}

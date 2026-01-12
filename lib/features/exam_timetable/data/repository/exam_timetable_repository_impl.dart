import 'package:academia/core/error/failures.dart';
import 'package:academia/features/exam_timetable/data/data.dart';
import 'package:academia/features/exam_timetable/domain/domain.dart';
import 'package:dartz/dartz.dart';

class ExamTimetableRepositoryImpl implements ExamTimetableRepository {
  final ExamTimetableLocalDataSource localDataSource;
  final ExamTimetableRemoteDatasource remoteDataSource;

  ExamTimetableRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<ExamTimetable>>> getCachedExams({
    // required String institutionId,
    List<String>? courseCodes,
  }) async {
    final result = await localDataSource.getCachedExams(
      // institutionId: institutionId,
      courseCodes: courseCodes,
    );
    return result.map(
      (dataList) => dataList.map((data) => data.toDomainEntity()).toList(),
    );
  }

  @override
  Future<Either<Failure, List<ExamTimetable>>> getExamTimetable({
    required String institutionId,
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

    return localDataSource.createOrUpdateExamBatch(dataModels);
  }

  @override
  Future<Either<Failure, List<ExamTimetable>>> refreshExamTimetable({
    required String institutionId,
    List<String>? courseCodes,
  }) async {
    final result = await remoteDataSource.refreshExamTimetable(
      institutionId: institutionId,
      courseCodes: courseCodes,
    );

    return result.fold((failure) => left(failure), (examList) async {
      if (examList.isNotEmpty) {
        await localDataSource.createOrUpdateExamBatch(examList);
      }

      return right(examList.map((data) => data.toDomainEntity()).toList());
    });
  }

  @override
  Future<Either<Failure, void>> deleteExamByCourseCode({
    required String courseCode,
    // required String institutionId,
  }) async {
    return localDataSource.deleteExamByCourseCode(
      courseCode: courseCode,
    );
  }

}

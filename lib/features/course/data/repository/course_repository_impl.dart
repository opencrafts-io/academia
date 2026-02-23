import 'package:academia/core/error/failures.dart';
import 'package:academia/features/course/course.dart';
import 'package:dartz/dartz.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseLocalDatasource localDatasource;

  CourseRepositoryImpl({required this.localDatasource});

  @override
  Stream<Either<Failure, List<CourseEntity>>> watchAllCourses() {
    return localDatasource.watchAllCourses().map((result) {
      return result.fold(
        (failure) => Left(failure),
        (dataList) => Right(dataList.map((data) => data.toEntity()).toList()),
      );
    });
  }

  @override
  Future<Either<Failure, Unit>> saveCourse(CourseEntity course) async {
    return await localDatasource.createOrUpdateCourse(
      course: course.toCompanion(),
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteCourse(String id) async {
    return await localDatasource.deleteCourseById(course: id);
  }

  @override
  Future<Either<Failure, CourseEntity>> getCourse(String id) async {
    final result = await localDatasource.getCourseById(id: id);
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data.toEntity()),
    );
  }

  @override
  Stream<Either<Failure, List<CourseEntity>>> watchCoursesByInstitution(
    int institutionId,
  ) {
    return localDatasource
        .watchCoursesByInstitutionId(institutionId: institutionId)
        .map((result) {
          return result.fold(
            (failure) => Left(failure),
            (dataList) =>
                Right(dataList.map((data) => data.toEntity()).toList()),
          );
        });
  }
}

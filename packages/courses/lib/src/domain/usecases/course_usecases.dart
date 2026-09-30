import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../entities/entities.dart';
import '../repositories/course_repository.dart';

part 'course_usecases.freezed.dart';

@freezed
abstract class CreateCourseParams with _$CreateCourseParams {
  const factory CreateCourseParams({
    required int institutionId,
    required String title,
    String? code,
    String? termLabel,
    String? academicYear,
    DateTime? termStartDate,
    DateTime? termEndDate,
    String? previousCourseId,
  }) = _CreateCourseParams;
}

@freezed
abstract class AddLecturerParams with _$AddLecturerParams {
  const factory AddLecturerParams({
    required String courseId,
    required String name,
    String? email,
    String? phone,
    String? office,
  }) = _AddLecturerParams;
}

@injectable
class CreateCourse implements UseCase<CourseEntity, CreateCourseParams> {
  CreateCourse(this._repository);
  final CourseRepository _repository;

  @override
  Future<Either<Failure, CourseEntity>> call(CreateCourseParams params) {
    return _repository.createCourse(
      institutionId: params.institutionId,
      title: params.title,
      code: params.code,
      termLabel: params.termLabel,
      academicYear: params.academicYear,
      termStartDate: params.termStartDate,
      termEndDate: params.termEndDate,
      previousCourseId: params.previousCourseId,
    );
  }
}

@injectable
class ListActiveCourses
    implements UseCase<List<CourseEntity>, NoUseCaseParams> {
  ListActiveCourses(this._repository);
  final CourseRepository _repository;

  @override
  Future<Either<Failure, List<CourseEntity>>> call(NoUseCaseParams params) =>
      _repository.listActiveCourses();
}

@injectable
class ListArchivedCourses
    implements UseCase<List<CourseEntity>, NoUseCaseParams> {
  ListArchivedCourses(this._repository);
  final CourseRepository _repository;

  @override
  Future<Either<Failure, List<CourseEntity>>> call(NoUseCaseParams params) =>
      _repository.listArchivedCourses();
}

@injectable
class GetCourse implements UseCase<CourseEntity, String> {
  GetCourse(this._repository);
  final CourseRepository _repository;

  @override
  Future<Either<Failure, CourseEntity>> call(String id) =>
      _repository.getCourse(id);
}

@injectable
class UpdateCourse implements UseCase<CourseEntity, CourseEntity> {
  UpdateCourse(this._repository);
  final CourseRepository _repository;

  @override
  Future<Either<Failure, CourseEntity>> call(CourseEntity course) =>
      _repository.updateCourse(course);
}

@injectable
class ArchiveCourse implements UseCase<CourseEntity, String> {
  ArchiveCourse(this._repository);
  final CourseRepository _repository;

  @override
  Future<Either<Failure, CourseEntity>> call(String id) =>
      _repository.archiveCourse(id);
}

@injectable
class DeleteCourse implements UseCase<Unit, String> {
  DeleteCourse(this._repository);
  final CourseRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(String id) => _repository.deleteCourse(id);
}

@injectable
class AddLecturer implements UseCase<LecturerEntity, AddLecturerParams> {
  AddLecturer(this._repository);
  final CourseRepository _repository;

  @override
  Future<Either<Failure, LecturerEntity>> call(AddLecturerParams params) {
    return _repository.addLecturer(
      courseId: params.courseId,
      name: params.name,
      email: params.email,
      phone: params.phone,
      office: params.office,
    );
  }
}

@injectable
class UpdateLecturer implements UseCase<LecturerEntity, LecturerEntity> {
  UpdateLecturer(this._repository);
  final CourseRepository _repository;

  @override
  Future<Either<Failure, LecturerEntity>> call(LecturerEntity lecturer) =>
      _repository.updateLecturer(lecturer);
}

@injectable
class DeleteLecturer implements UseCase<Unit, LecturerEntity> {
  DeleteLecturer(this._repository);
  final CourseRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(LecturerEntity lecturer) =>
      _repository.deleteLecturer(lecturer);
}

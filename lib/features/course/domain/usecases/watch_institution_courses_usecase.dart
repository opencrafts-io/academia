import 'package:academia/core/core.dart';
import 'package:academia/features/course/domain/domain.dart';
import 'package:dartz/dartz.dart';

class WatchInstitutionCoursesUsecase
    extends StreamUseCase<Either<Failure, List<CourseEntity>>, int> {
  final CourseRepository repository;

  WatchInstitutionCoursesUsecase(this.repository);

  @override
  Stream<Either<Failure, List<CourseEntity>>> call(int institutionId) {
    return repository.watchCoursesByInstitution(institutionId);
  }
}

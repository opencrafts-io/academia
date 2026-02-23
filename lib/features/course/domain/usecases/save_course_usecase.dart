import 'package:academia/core/core.dart';
import 'package:academia/features/course/domain/domain.dart';
import 'package:dartz/dartz.dart';

class SaveCourseUsecase extends UseCase<Unit, CourseEntity> {
  final CourseRepository repository;

  SaveCourseUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(CourseEntity course) async {
    return await repository.saveCourse(course);
  }
}

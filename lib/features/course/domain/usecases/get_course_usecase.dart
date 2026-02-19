import 'package:academia/core/core.dart';
import 'package:academia/features/course/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetCourseUsecase extends UseCase<CourseEntity, String> {
  final CourseRepository repository;

  GetCourseUsecase(this.repository);

  @override
  Future<Either<Failure, CourseEntity>> call(String id) async {
    return await repository.getCourse(id);
  }
}

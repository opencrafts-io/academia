import 'package:academia/core/core.dart';
import 'package:academia/features/course/domain/domain.dart';
import 'package:dartz/dartz.dart';

class DeleteCourseUsecase extends UseCase<Unit, String> {
  final CourseRepository repository;

  DeleteCourseUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(String id) async {
    return await repository.deleteCourse(id);
  }
}

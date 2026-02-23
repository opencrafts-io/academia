import 'package:academia/core/core.dart';
import 'package:academia/features/course/domain/domain.dart';
import 'package:dartz/dartz.dart';

class WatchAllCoursesUsecase
    extends StreamUseCase<Either<Failure, List<CourseEntity>>, NoParams> {
  final CourseRepository repository;

  WatchAllCoursesUsecase(this.repository);

  @override
  Stream<Either<Failure, List<CourseEntity>>> call(NoParams params) {
    return repository.watchAllCourses();
  }
}

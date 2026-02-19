import 'package:academia/core/core.dart';
import 'package:academia/features/semester/domain/domain.dart';
import 'package:dartz/dartz.dart';

class CreateSemesterUsecase extends UseCase<Unit, SemesterEntity> {
  final SemesterRepository semesterRepository;

  CreateSemesterUsecase({required this.semesterRepository});

  @override
  Future<Either<Failure, Unit>> call(SemesterEntity semester) {
    return semesterRepository.createSemeter(semester: semester);
  }
}

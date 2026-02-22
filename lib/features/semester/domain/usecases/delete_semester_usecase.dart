import 'package:academia/core/core.dart';
import 'package:academia/features/semester/domain/domain.dart';
import 'package:dartz/dartz.dart';

class DeleteSemesterUsecase extends UseCase<Unit, int> {
  SemesterRepository semesterRepository;

  DeleteSemesterUsecase({required this.semesterRepository});

  @override
  Future<Either<Failure, Unit>> call(int semesterId) {
    return semesterRepository.deleteSemester(semesterId: semesterId);
  }
}

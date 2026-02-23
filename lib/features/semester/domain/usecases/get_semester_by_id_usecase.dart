import 'package:academia/core/core.dart';
import 'package:academia/features/semester/semester.dart';
import 'package:dartz/dartz.dart';

class GetSemesterByIdUsecase extends UseCase<SemesterEntity, int> {
  SemesterRepository semesterRepository;

  GetSemesterByIdUsecase({required this.semesterRepository});

  @override
  Future<Either<Failure, SemesterEntity>> call(int semesterId) {
    return semesterRepository.getSemesterById(semesterId: semesterId);
  }
}

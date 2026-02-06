import 'package:academia/core/core.dart';
import 'package:academia/features/semester/domain/domain.dart';
import 'package:dartz/dartz.dart';

class UpdateSemesterUsecase extends UseCase<Unit, SemesterEntity> {
  final SemesterRepository semesterRepository;

  UpdateSemesterUsecase({required this.semesterRepository});

  @override
  Future<Either<Failure, Unit>> call(SemesterEntity semester) {
    return semesterRepository.updateSemester(semester: semester);
  }
}

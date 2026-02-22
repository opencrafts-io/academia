import 'package:academia/core/core.dart';
import 'package:academia/features/semester/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetSemestersForInstituionUsecase
    extends UseCase<List<SemesterEntity>, int> {
  SemesterRepository semesterRepository;

  GetSemestersForInstituionUsecase({required this.semesterRepository});

  @override
  Future<Either<Failure, List<SemesterEntity>>> call(int institutionId) {
    return semesterRepository.getSemestersForInstitution(
      institutionId: institutionId,
    );
  }
}

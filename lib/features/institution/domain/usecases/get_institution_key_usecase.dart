import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetInstitutionKeyUsecase
    extends StreamUseCase<Either<Failure, InstitutionKey?>, int> {
  final InstitutionKeyRepository repository;

  GetInstitutionKeyUsecase({required this.repository});

  @override
  Stream<Either<Failure, InstitutionKey?>> call(int institutionID) {
    return repository.getKeyByInstitutionID(institutionID: institutionID);
  }
}

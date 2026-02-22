import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:magnet/magnet.dart';

class GetInstitutionScrappingCommandUsecase
    extends StreamUseCase<Either<Failure, ScrappingCommand?>, int> {
  final InstitutionCommandRepository repository;

  GetInstitutionScrappingCommandUsecase({required this.repository});

  @override
  Stream<Either<Failure, ScrappingCommand?>> call(int institutionID) {
    return repository.getInstitutionScrappingCommandByInstitutionID(
      institutionID: institutionID,
    );
  }
}

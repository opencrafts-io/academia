import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:magnet/magnet.dart';

/// One-shot check for whether an institution has a scrapping command
/// configured — use this (not [GetInstitutionScrappingCommandUsecase]'s
/// reactive stream) when the caller needs a single definitive answer, such
/// as gating navigation on "does this institution support the feature".
/// Answers instantly from cache when possible; only waits on the network
/// the first time a given institution is checked.
class FetchInstitutionScrappingCommandUsecase
    extends UseCase<ScrappingCommand?, int> {
  final InstitutionCommandRepository repository;

  FetchInstitutionScrappingCommandUsecase({required this.repository});

  @override
  Future<Either<Failure, ScrappingCommand?>> call(int institutionID) {
    return repository.fetchInstitutionScrappingCommand(
      institutionID: institutionID,
    );
  }
}

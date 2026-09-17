import 'package:academia/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:magnet/magnet.dart';

abstract class InstitutionCommandRepository {
  Stream<Either<Failure, ScrappingCommand?>>
  getInstitutionScrappingCommandByInstitutionID({required int institutionID});

  /// One-shot check for whether an institution has a scrapping command
  /// configured, without racing [getInstitutionScrappingCommandByInstitutionID]'s
  /// reactive stream.
  ///
  /// Answers instantly from the local cache when a row already exists
  /// (kicking off a background refresh to keep it warm), and only falls
  /// back to waiting on the network the first time a given institution is
  /// checked, when there's nothing cached yet to answer with.
  Future<Either<Failure, ScrappingCommand?>> fetchInstitutionScrappingCommand({
    required int institutionID,
  });
}

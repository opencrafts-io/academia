import 'package:academia/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:magnet/magnet.dart';

abstract class InstitutionCommandRepository {
  Stream<Either<Failure, ScrappingCommand?>>
  getInstitutionScrappingCommandByInstitutionID({required int institutionID});
}

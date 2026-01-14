import 'package:academia/core/error/failures.dart';
import 'package:academia/features/institution/data/models/institution_scrapping_command_model_helper.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:dartz/dartz.dart';
import 'package:magnet/magnet.dart';

class InstitutionScrappingCommandRepositoryImpl
    extends InstitutionCommandRepository {
  final InstitutionCommandRemoteDatasource institutionCommandRemoteDatasource;
  final InstitutionCommandLocalDatasource institutionCommandLocalDatasource;

  InstitutionScrappingCommandRepositoryImpl({
    required this.institutionCommandLocalDatasource,
    required this.institutionCommandRemoteDatasource,
  });

  @override
  Stream<Either<Failure, ScrappingCommand?>>
  getInstitutionScrappingCommandByInstitutionID({
    required int institutionID,
  }) async* {
    final result = await institutionCommandRemoteDatasource
        .fetchInstitutionScrappingCommandByInstitution(
          institutionID: institutionID,
        );

    result.fold((error) {}, (command) async {
      await institutionCommandLocalDatasource.saveInstitutionCommand(
        institutionCommand: command,
      );
    });
    yield* institutionCommandLocalDatasource
        .watchInstitutionCommandByInstitution(institutionID: institutionID)
        .map<Either<Failure, ScrappingCommand?>>(
          (data) => data.fold(
            (error) => left(error),
            (command) => right(command?.toEntity()),
          ),
        );
  }
}

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
  Future<Either<Failure, ScrappingCommand?>> fetchInstitutionScrappingCommand({
    required int institutionID,
  }) async {
    final cachedResult = await institutionCommandLocalDatasource
        .getCachedInstitutionCommand(institutionID: institutionID);

    final cached = cachedResult.fold((_) => null, (data) => data);
    if (cached != null) {
      // Answer instantly from cache and let the network catch up in the
      // background - don't make navigation wait on it, and don't let it
      // change the answer we just gave for this call.
      _refreshInstitutionScrappingCommandInBackground(institutionID);
      return right(cached.toEntity());
    }

    // Nothing cached yet (e.g. the first time this institution is ever
    // checked) - there's nothing to answer instantly with, so this one
    // time we do have to wait on the network.
    final result = await institutionCommandRemoteDatasource
        .fetchInstitutionScrappingCommandByInstitution(
          institutionID: institutionID,
        );

    return result.fold((failure) => left(failure), (dto) {
      institutionCommandLocalDatasource.saveInstitutionCommand(
        institutionCommand: dto.toData(),
      );
      return right(dto.toEntity());
    });
  }

  void _refreshInstitutionScrappingCommandInBackground(int institutionID) {
    institutionCommandRemoteDatasource
        .fetchInstitutionScrappingCommandByInstitution(
          institutionID: institutionID,
        )
        .then((result) {
          result.fold(
            (_) {},
            (dto) => institutionCommandLocalDatasource.saveInstitutionCommand(
              institutionCommand: dto.toData(),
            ),
          );
        });
  }

  @override
  Stream<Either<Failure, ScrappingCommand?>>
  getInstitutionScrappingCommandByInstitutionID({
    required int institutionID,
  }) async* {
    institutionCommandRemoteDatasource
        .fetchInstitutionScrappingCommandByInstitution(
          institutionID: institutionID,
        )
        .then((result) {
          result.fold(
            (error) {},
            (dto) => institutionCommandLocalDatasource.saveInstitutionCommand(
              institutionCommand: dto.toData(),
            ),
          );
        });

    yield* institutionCommandLocalDatasource
        .watchInstitutionCommandByInstitution(institutionID: institutionID)
        .map<Either<Failure, ScrappingCommand?>>(
          (data) => data.fold(
            (error) {
              return left(error);
            },
            (command) {
              return right(command?.toEntity());
            },
          ),
        );
  }
}

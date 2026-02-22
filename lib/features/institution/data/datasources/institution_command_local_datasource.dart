import 'package:academia/core/error/failures.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class InstitutionCommandLocalDatasource {
  final AppDataBase appDataBase;

  InstitutionCommandLocalDatasource({required this.appDataBase});

  Stream<Either<Failure, InstitutionScrappingCommandData?>>
  watchInstitutionCommandByInstitution({required int institutionID}) {
    return (appDataBase.select(appDataBase.institutionScrappingCommand)
          ..where((ins) => ins.institution.equals(institutionID))
          ..orderBy([(ins) => OrderingTerm.desc(ins.createdAt)])
          ..limit(1))
        .watchSingleOrNull()
        .map<Either<Failure, InstitutionScrappingCommandData?>>((data) {
          return Right(data);
        })
        .handleError(
          (err) => Left(
            CacheFailure(
              message: "Couldn't load configs for the specified institution",
              error: err,
            ),
          ),
        );
  }

  Future<Either<Failure, void>> saveInstitutionCommand({
    required InstitutionScrappingCommandData institutionCommand,
  }) async {
    try {
      await appDataBase
          .into(appDataBase.institutionScrappingCommand)
          .insertOnConflictUpdate(institutionCommand);

      return right(null);
    } catch (e) {
      return left(
        CacheFailure(message: "Failed to save institution configs", error: e),
      );
    }
  }
}

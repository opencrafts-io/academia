import 'package:academia/core/error/failures.dart';
import 'package:academia/features/timetable/domain/domain.dart';
import 'package:academia/features/timetable/data/data.dart';
import 'package:dartz/dartz.dart';

class TimetableRepositoryImpl implements TimetableRepository {
  final TimetableLocalDatasource localDatasource;

  TimetableRepositoryImpl({required this.localDatasource});

  @override
  Stream<Either<Failure, List<TimetableEntity>>> watchAllTimetables() {
    return localDatasource.watchAllTimetables().map((result) {
      return result.fold(
        (failure) => Left(failure),
        (dataList) => Right(dataList.map((data) => data.toEntity()).toList()),
      );
    });
  }

  @override
  Stream<Either<Failure, List<TimetableEntity>>> watchTimetablesByUserId({
    required String userId,
  }) {
    return localDatasource.watchTimetablesByUserId(userId: userId).map((
      result,
    ) {
      return result.fold(
        (failure) => Left(failure),
        (dataList) => Right(dataList.map((data) => data.toEntity()).toList()),
      );
    });
  }

  @override
  Stream<Either<Failure, List<TimetableEntity>>>
  watchTimetablesByInstitutionId({required int institutionId}) {
    return localDatasource
        .watchTimetablesByInstitutionId(institutionId: institutionId)
        .map((result) {
          return result.fold(
            (failure) => Left(failure),
            (dataList) =>
                Right(dataList.map((data) => data.toEntity()).toList()),
          );
        });
  }

  @override
  Future<Either<Failure, TimetableEntity>> createOrUpdateTimetable({
    required TimetableEntity timetable,
  }) async {
    final result = await localDatasource.createOrUpdateTimetable(
      timetable: timetable.toCompanion(),
    );

    return result.fold((failure) => Left(failure), (_) => Right(timetable));
  }

  @override
  Future<Either<Failure, Unit>> deleteTimetable({required String id}) async {
    return await localDatasource.deleteTimetableById(id: id);
  }

  @override
  Future<Either<Failure, TimetableEntity>> getTimetableById({
    required String id,
  }) async {
    final result = await localDatasource.getTimetableById(id: id);
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Unit>> syncTimetables() async {
    // TODO: Implement when remote datasource is available
    return const Right(unit);
  }

  @override
  Future<Either<Failure, List<TimetableEntity>>>
  fetchTimetablesFromRemote() async {
    // TODO: Implement when remote datasource is available
    return const Right([]);
  }
}

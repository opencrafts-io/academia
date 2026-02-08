import 'package:academia/core/error/failures.dart';
import 'package:academia/features/timetable/data/data.dart';
import 'package:academia/features/timetable/domain/domain.dart';
import 'package:dartz/dartz.dart';

class TimetableEntryRepositoryImpl implements TimetableEntryRepository {
  final TimetableEntryLocalDatasource localDatasource;

  TimetableEntryRepositoryImpl({required this.localDatasource});

  @override
  Stream<Either<Failure, List<TimetableEntryEntity>>>
  watchAllTimetableEntries() {
    return localDatasource.watchAllTimetableEntries().map((result) {
      return result.fold(
        (failure) => Left(failure),
        (dataList) => Right(dataList.map((data) => data.toEntity()).toList()),
      );
    });
  }

  @override
  Stream<Either<Failure, List<TimetableEntryEntity>>>
  watchTimetableEntriesByTimetableId({required String timetableId}) {
    return localDatasource
        .watchTimetableEntriesByTimetableId(timetableId: timetableId)
        .map((result) {
          return result.fold(
            (failure) => Left(failure),
            (dataList) =>
                Right(dataList.map((data) => data.toEntity()).toList()),
          );
        });
  }

  @override
  Stream<Either<Failure, List<TimetableEntryEntity>>>
  watchTimetableEntriesByCourseId({required String courseId}) {
    return localDatasource
        .watchTimetableEntriesByCourseId(courseId: courseId)
        .map((result) {
          return result.fold(
            (failure) => Left(failure),
            (dataList) =>
                Right(dataList.map((data) => data.toEntity()).toList()),
          );
        });
  }

  @override
  Stream<Either<Failure, List<TimetableEntryEntity>>>
  watchTimetableEntriesByUserId({required String userId}) {
    return localDatasource.watchTimetableEntriesByUserId(userId: userId).map((
      result,
    ) {
      return result.fold(
        (failure) => Left(failure),
        (dataList) => Right(dataList.map((data) => data.toEntity()).toList()),
      );
    });
  }

  @override
  Stream<Either<Failure, List<TimetableEntryEntity>>>
  watchTimetableEntriesByInstitutionId({required int institutionId}) {
    return localDatasource
        .watchTimetableEntriesByInstitutionId(institutionId: institutionId)
        .map((result) {
          return result.fold(
            (failure) => Left(failure),
            (dataList) =>
                Right(dataList.map((data) => data.toEntity()).toList()),
          );
        });
  }

  @override
  Future<Either<Failure, TimetableEntryEntity>> createOrUpdateTimetableEntry({
    required TimetableEntryEntity entry,
  }) async {
    final result = await localDatasource.createOrUpdateTimetableEntry(
      entry: entry.toCompanion(),
    );

    return result.fold((failure) => Left(failure), (_) => Right(entry));
  }

  @override
  Future<Either<Failure, List<TimetableEntryEntity>>>
  createOrUpdateTimetableEntries({
    required List<TimetableEntryEntity> entries,
  }) async {
    final companions = entries.map((e) => e.toCompanion()).toList();

    final result = await localDatasource.createOrUpdateTimetableEntries(
      entries: companions,
    );

    return result.fold((failure) => Left(failure), (_) => Right(entries));
  }

  @override
  Future<Either<Failure, Unit>> deleteTimetableEntry({
    required String id,
  }) async {
    return await localDatasource.deleteTimetableEntryById(id: id);
  }

  @override
  Future<Either<Failure, Unit>> deleteTimetableEntries({
    required List<String> ids,
  }) async {
    for (final id in ids) {
      final result = await localDatasource.deleteTimetableEntryById(id: id);
      if (result.isLeft()) {
        return result;
      }
    }
    return const Right(unit);
  }

  @override
  Future<Either<Failure, TimetableEntryEntity>> getTimetableEntryById({
    required String id,
  }) async {
    final result = await localDatasource.getTimetableEntryById(id: id);
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data.toEntity()),
    );
  }

  @override
  Future<Either<Failure, Unit>> syncTimetableEntries() async {
    // TODO: Implement when remote datasource is available
    return const Right(unit);
  }

  @override
  Future<Either<Failure, List<TimetableEntryEntity>>>
  fetchTimetableEntriesFromRemote({String? timetableId}) async {
    // TODO: Implement when remote datasource is available
    return const Right([]);
  }
}

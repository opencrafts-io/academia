import 'package:academia/core/error/failures.dart';
import 'package:academia/features/semester/data/data.dart';
import 'package:academia/features/semester/domain/domain.dart';
import 'package:dartz/dartz.dart';

class SemesterRepositoryImpl implements SemesterRepository {
  final SemesterLocalDatasource semesterLocalDatasource;

  SemesterRepositoryImpl({required this.semesterLocalDatasource});
  @override
  Stream<Either<Failure, List<SemesterEntity>>> watchAllSemsters() {
    return semesterLocalDatasource.watchAllSemesters().map((semesters) {
      return semesters.fold(
        (error) => left(error),
        (sems) => right(sems.map((elem) => elem.toEntity()).toList()),
      );
    });
  }

  @override
  Future<Either<Failure, Unit>> createSemeter({
    required SemesterEntity semester,
  }) {
    return semesterLocalDatasource.createOrUpdateSemester(
      semester: semester.toData(),
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteSemester({required int semesterId}) {
    return semesterLocalDatasource.deleteSemesterByID(semesterId: semesterId);
  }

  @override
  Future<Either<Failure, Unit>> updateSemester({
    required SemesterEntity semester,
  }) {
    return semesterLocalDatasource.createOrUpdateSemester(
      semester: semester.toData(),
    );
  }

  @override
  Future<Either<Failure, List<SemesterEntity>>> getSemestersForInstitution({
    required int institutionId,
  }) async {
    final result = await semesterLocalDatasource.getSemstersByInstitutionID(
      institutionId: institutionId,
    );

    return result.fold(
      (error) => left(error),
      (semesters) => right(semesters.map((sem) => sem.toEntity()).toList()),
    );
  }
}

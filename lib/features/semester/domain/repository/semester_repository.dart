import 'package:academia/core/core.dart';
import 'package:academia/features/semester/domain/domain.dart';
import 'package:dartz/dartz.dart';

/// SemesterRepository
///
/// A repository class that manages semester crud functionality
abstract class SemesterRepository {
  /// Should create [semester]
  Future<Either<Failure, Unit>> createSemeter({
    required SemesterEntity semester,
  });

  /// Should update [semester] with its new values
  Future<Either<Failure, Unit>> updateSemester({
    required SemesterEntity semester,
  });

  /// Should delete a semester whose semester id is equivalent to
  /// [semesterId]
  Future<Either<Failure, Unit>> deleteSemester({required int semesterId});

  /// Should expose a stream that is listenable for semester changes
  Stream<Either<Failure, List<SemesterEntity>>> watchAllSemsters();

  /// Should return a list of semesters which are linked to institution specified
  /// by [institutionId] 
  Future<Either<Failure, List<SemesterEntity>>>
  getSemestersForInstitution({required int institutionId});
}

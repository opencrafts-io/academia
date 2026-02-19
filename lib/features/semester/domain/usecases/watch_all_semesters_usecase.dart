import 'package:academia/core/core.dart';
import 'package:academia/features/semester/domain/domain.dart';
import 'package:dartz/dartz.dart';

class WatchAllSemestersUsecase
    extends StreamUseCase<Either<Failure, List<SemesterEntity>>, NoParams> {
  SemesterRepository semesterRepository;

  WatchAllSemestersUsecase({required this.semesterRepository});

  @override
  Stream<Either<Failure, List<SemesterEntity>>> call(NoParams params) {
    return semesterRepository.watchAllSemsters();
  }
}

import 'package:academia/core/core.dart';
import 'package:academia/features/admob/admob.dart';
import 'package:dartz/dartz.dart';

class GetLoadedAdsUsecase implements UseCase<List<AdEntity>, NoParams> {
  final AdRepository repository;

  GetLoadedAdsUsecase(this.repository);

  @override
  Future<Either<Failure, List<AdEntity>>> call(NoParams params) async {
    return await repository.getLoadedAds();
  }
}

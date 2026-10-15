import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/account.dart';
import '../repositories/rewards_repository.dart';

class GetRewardAccount {
  const GetRewardAccount(this._repository);

  final RewardsRepository _repository;

  Future<Either<Failure, RewardAccount>> call() => _repository.getAccount();
}

import '../repository/auth_repository.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/auth/domain/entities/user_profile.dart';
import 'package:dartz/dartz.dart';

class GetLoggedInUser implements UseCase<UserProfile, NoParams> {
  final AuthRepository repository;

  GetLoggedInUser(this.repository);

  @override
  Future<Either<Failure, UserProfile>> call(NoParams params) async {
    return await repository.getLoggedInUser();
  }
}

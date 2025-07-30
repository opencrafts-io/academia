import 'package:academia/core/core.dart';
import 'package:academia/features/profile/domain/entities/user_profile.dart';
import 'package:dartz/dartz.dart';

abstract class UserSearchRepository {
  Future<Either<Failure, List<UserProfile>>> searchUsers(String query);
}

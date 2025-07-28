import 'package:academia/core/core.dart';
import 'package:academia/features/profile/domain/entities/user_profile.dart';
import 'package:dartz/dartz.dart';
import '../repositories/user_search_repository.dart';

class SearchUsersUseCase implements UseCase<List<UserProfile>, String> {
  final UserSearchRepository repository;

  SearchUsersUseCase(this.repository);

  @override
  Future<Either<Failure, List<UserProfile>>> call(String query) async {
    if (query.trim().isEmpty) {
      return const Right([]);
    }

    return await repository.searchUsers(query.trim());
  }
}

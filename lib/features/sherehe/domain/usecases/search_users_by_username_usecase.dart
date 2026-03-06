import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';

class SearchUsersByUsernameUsecase {
  final ShereheRepository repository;

  SearchUsersByUsernameUsecase(this.repository);

  Future<Either<Failure, List<ShereheUser>>> call({required String query}) {
    return repository.searchUsersByUsername(query: query);
  }
}

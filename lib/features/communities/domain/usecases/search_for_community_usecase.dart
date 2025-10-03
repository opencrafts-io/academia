import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';

final class SearchForCommunityUsecaseParams {
  final int page;
  final int pageSize;
  final String searchTerm;

  SearchForCommunityUsecaseParams({
    this.page = 1,
    this.pageSize = 100,
    required this.searchTerm,
  });
}

class SearchForCommunityUsecase
    extends UseCase<PaginatedCommunity, SearchForCommunityUsecaseParams> {
  final CommunityRepository communityRepository;

  SearchForCommunityUsecase({required this.communityRepository});

  @override
  Future<Either<Failure, PaginatedCommunity>> call(
    SearchForCommunityUsecaseParams params,
  ) async {
    return await communityRepository.searchForCommunity(
      params.searchTerm,
      pageSize: 100,
      page: 1,
    );
  }
}

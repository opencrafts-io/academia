import 'package:academia/features/chirp/communities/domain/entities/paginated_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_users_state.freezed.dart';

@freezed
sealed class CommunityUsersState with _$CommunityUsersState {
  const factory CommunityUsersState.initial() = CommunityUsersInitial;
  const factory CommunityUsersState.loading() = CommunityUsersLoading;
  const factory CommunityUsersState.loaded(
    PaginatedResponse paginatedResponse,
  ) = CommunityUsersLoaded;
  const factory CommunityUsersState.failure(String message) =
      CommunityUsersFailure;
}

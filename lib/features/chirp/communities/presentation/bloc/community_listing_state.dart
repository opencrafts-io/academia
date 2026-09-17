import 'package:academia/features/chirp/communities/domain/entities/community.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_listing_state.freezed.dart';

@freezed
sealed class CommunityListingState with _$CommunityListingState {
  const factory CommunityListingState.initial() =
      CommunityListingInitialState;
  const factory CommunityListingState.loading() =
      CommunityListingLoadingState;
  const factory CommunityListingState.error({required String message}) =
      CommunityListingErrorState;
  const factory CommunityListingState.loaded({
    required List<Community> communities,
    @Default(false) bool hasReachedMax,
    @Default(false) bool isLoadingMore,
    String? searchTerm,
  }) = CommunityListingLoadedState;
}

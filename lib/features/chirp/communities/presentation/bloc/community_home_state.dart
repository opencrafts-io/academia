import 'package:academia/features/chirp/communities/domain/entities/community.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_home_state.freezed.dart';

@freezed
sealed class CommunityHomeState with _$CommunityHomeState {
  const factory CommunityHomeState.initial() = CommunityHomeInitial;
  const factory CommunityHomeState.loading() = CommunityHomeLoading;
  const factory CommunityHomeState.loaded(Community community) =
      CommunityHomeLoaded;
  const factory CommunityHomeState.criticalActionFailure(String message) =
      CommunityCriticalActionFailure;
  const factory CommunityHomeState.deleted() = CommunityDeleted;
  const factory CommunityHomeState.failure(String message) =
      CommunityHomeFailure;
}

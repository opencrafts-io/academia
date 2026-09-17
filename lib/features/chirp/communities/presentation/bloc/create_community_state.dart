import 'package:academia/features/chirp/communities/domain/entities/community.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_community_state.freezed.dart';

@freezed
sealed class CreateCommunityState with _$CreateCommunityState {
  const factory CreateCommunityState.initial() = CreateCommunityInitial;
  const factory CreateCommunityState.loading() = CreateCommunityLoading;
  const factory CreateCommunityState.success({required Community community}) =
      CreateCommunitySuccess;
  const factory CreateCommunityState.failure({required String message}) =
      CreateCommunityFailure;
}

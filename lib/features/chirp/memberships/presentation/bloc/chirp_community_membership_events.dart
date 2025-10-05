part of 'chirp_community_membership_bloc.dart';

class ChirpCommunityMembershipEvent extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class GetCachedChirpCommunityMembershipEvent
    extends ChirpCommunityMembershipEvent {}

class GetRemotePersonalChirpCommunityMembershipEvent
    extends ChirpCommunityMembershipEvent {
  final int page;
  final int pageSize;

  GetRemotePersonalChirpCommunityMembershipEvent({
    this.page = 1,
    this.pageSize = 100,
  });
}

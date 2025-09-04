part of 'community_home_bloc.dart';

abstract class CommunityHomeEvent extends Equatable {
  const CommunityHomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchCommunityById extends CommunityHomeEvent {
  final String communityId;

  const FetchCommunityById({required this.communityId});

  @override
  List<Object?> get props => [communityId];
}

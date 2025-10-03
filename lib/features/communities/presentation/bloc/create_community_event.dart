part of 'create_community_bloc.dart';

abstract class CreateCommunityEvent extends Equatable {
  const CreateCommunityEvent();

  @override
  List<Object?> get props => [];
}

class SubmitNewCommunity extends CreateCommunityEvent {
  final Community community;
  const SubmitNewCommunity({required this.community});

  @override
  List<Object?> get props => [community];
}

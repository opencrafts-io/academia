part of 'community_users_bloc.dart';

abstract class CommunityUsersState extends Equatable {
  const CommunityUsersState();

  @override
  List<Object?> get props => [];
}

class CommunityUsersInitial extends CommunityUsersState {}

class CommunityUsersLoading extends CommunityUsersState {}

class CommunityUsersLoaded extends CommunityUsersState {
  final PaginatedResponse paginatedResponse;

  const CommunityUsersLoaded(this.paginatedResponse);

  @override
  List<Object?> get props => [paginatedResponse];
}

class CommunityUsersFailure extends CommunityUsersState {
  final String message;

  const CommunityUsersFailure(this.message);

  @override
  List<Object?> get props => [message];
}
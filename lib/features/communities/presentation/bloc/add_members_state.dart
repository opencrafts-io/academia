part of 'add_members_bloc.dart';

abstract class AddMembersState extends Equatable {
  const AddMembersState();

  @override
  List<Object?> get props => [];
}

class AddMembersInitial extends AddMembersState {}

class AddMembersLoading extends AddMembersState {}

class SearchResultsLoaded extends AddMembersState {
  final List<ChirpUser> users;

  const SearchResultsLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class MemberAddedSuccess extends AddMembersState {
  final Community community;

  const MemberAddedSuccess(this.community);

  @override
  List<Object?> get props => [community];
}

class AddMembersFailure extends AddMembersState {
  final String message;

  const AddMembersFailure(this.message);

  @override
  List<Object?> get props => [message];
}

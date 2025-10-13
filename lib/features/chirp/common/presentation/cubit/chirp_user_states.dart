part of 'chirp_user_cubit.dart';

class ChirpUserState extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}


// Represents a initial state for finding a chirp user
class ChirpUserInitialState extends ChirpUserState {}



// Represents a loading state for finding a chirp user
class ChirpUserLoadingState extends ChirpUserState {}

// Represents an error state while fetching a chirp user
class ChirpUserErrorState extends ChirpUserState {
  final String error;
  ChirpUserErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}

/// Represents a loaded user state 
class ChirpUserLoadedState extends ChirpUserState {
  final ChirpUser user;

  ChirpUserLoadedState({required this.user});
  @override
  List<Object?> get props => [user];
}

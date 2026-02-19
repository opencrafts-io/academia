part of 'semester_cubit.dart';

sealed class SemesterState extends Equatable {}

class SemesterErrorState extends SemesterState {
  final String error;
  SemesterErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}

class SemesterInitialState extends SemesterState {
  @override
  List<Object?> get props => [];
}

class SemesterLoadedState extends SemesterState {
  final List<SemesterEntity> semesters;

  SemesterLoadedState({required this.semesters});
  @override
  List<Object?> get props => [];
}

class SemesterLoadingState extends SemesterState {
  @override
  List<Object?> get props => [];
}

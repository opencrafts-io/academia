part of 'attendees_and_scanner_stats_bloc.dart';

abstract class AttendeesAndScannerStatsState extends Equatable {
  const AttendeesAndScannerStatsState();

  @override
  List<Object?> get props => [];
}

class InitialState extends AttendeesAndScannerStatsState {}

class LoadingState extends AttendeesAndScannerStatsState {}

class LoadedState extends AttendeesAndScannerStatsState {
  final DashboardStats stats;

  const LoadedState({required this.stats});

  @override
  List<Object?> get props => [stats];
}

class ErrorState extends AttendeesAndScannerStatsState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

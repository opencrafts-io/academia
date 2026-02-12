part of 'report_bloc.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object?> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportSubmitted extends ReportState {
  final String message;

  const ReportSubmitted({required this.message});

  @override
  List<Object?> get props => [message];
}

class ReportsLoaded extends ReportState {
  final List<Report> reports;

  const ReportsLoaded({required this.reports});

  @override
  List<Object?> get props => [reports];
}

class ReportError extends ReportState {
  final String message;

  const ReportError({required this.message});

  @override
  List<Object?> get props => [message];
}

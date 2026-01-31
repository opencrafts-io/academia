part of 'report_bloc.dart';
abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object?> get props => [];
}

class ReportContentEvent extends ReportEvent {
  final String reportType;
  final String? entityId;
  final String reason;

  const ReportContentEvent({
    required this.reportType,
    this.entityId,
    required this.reason,
  });

  @override
  List<Object?> get props => [reportType, entityId, reason];
}

class GetReportsEvent extends ReportEvent {
  final String? type;
  final String? status;

  const GetReportsEvent({this.type, this.status});

  @override
  List<Object?> get props => [type, status];
}

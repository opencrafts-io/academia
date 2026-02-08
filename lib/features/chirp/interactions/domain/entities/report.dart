import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final int id;
  final String reportType;
  final String reason;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Report({
    required this.id,
    required this.reportType,
    required this.reason,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    reportType,
    reason,
    status,
    createdAt,
    updatedAt,
  ];
}

import 'package:equatable/equatable.dart';

class DashboardStats extends Equatable {
  final int attendees;
  final int scanners;

  const DashboardStats({required this.attendees, required this.scanners});

  DashboardStats copyWith({int? attendees, int? scanners}) {
    return DashboardStats(
      attendees: attendees ?? this.attendees,
      scanners: scanners ?? this.scanners,
    );
  }

  @override
  List<Object?> get props => [attendees, scanners];

  @override
  bool? get stringify => true;
}

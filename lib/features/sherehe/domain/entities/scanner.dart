import 'package:equatable/equatable.dart';

class Scanner extends Equatable {
  final String id;
  final String eventId;
  final String userId;
  final String role;
  final String grantedBy;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  const Scanner({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.role,
    required this.grantedBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  Scanner copyWith({
    String? id,
    String? eventId,
    String? userId,
    String? role,
    String? grantedBy,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    return Scanner(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      grantedBy: grantedBy ?? this.grantedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    eventId,
    userId,
    role,
    grantedBy,
    createdAt,
    updatedAt,
    deletedAt,
  ];

  @override
  bool? get stringify => true;
}

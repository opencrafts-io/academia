import 'package:equatable/equatable.dart';

class Invite extends Equatable {
  final String id;
  final String? eventId;
  final String? ticketId;
  final String token;
  final String expiresAt;
  final int maxUses;
  final int usedCount;
  final String createdAt;
  final String updatedAt;

  const Invite({
    required this.id,
    this.eventId,
    this.ticketId,
    required this.token,
    required this.expiresAt,
    required this.maxUses,
    required this.usedCount,
    required this.createdAt,
    required this.updatedAt,
  });

  Invite copyWith({
    String? id,
    String? eventId,
    String? ticketId,
    String? token,
    String? expiresAt,
    int? maxUses,
    int? usedCount,
    String? createdAt,
    String? updatedAt,
  }) {
    return Invite(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      ticketId: ticketId ?? this.ticketId,
      token: token ?? this.token,
      expiresAt: expiresAt ?? this.expiresAt,
      maxUses: maxUses ?? this.maxUses,
      usedCount: usedCount ?? this.usedCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isExpired => DateTime.now().isAfter(DateTime.parse(expiresAt));

  double get usageProgress {
    if (maxUses == 0) return 0;
    return (usedCount / maxUses).clamp(0.0, 1.0);
  }

  int get remainingUses => maxUses - usedCount;

  @override
  List<Object?> get props => [
    id,
    eventId,
    ticketId,
    token,
    expiresAt,
    maxUses,
    usedCount,
    createdAt,
    updatedAt,
  ];

  @override
  bool? get stringify => true;
}

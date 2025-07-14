import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final int id;
  final String accessToken;
  final String refreshToken;
  final String provider;
  final DateTime? expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Token({
    required this.id,
    required this.refreshToken,
    required this.provider,
    required this.expiresAt,
    required this.accessToken,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken];

  @override
  bool? get stringify => true;
}

import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String provider;
  final String accessToken;
  final String refreshToken;
  final DateTime accessExpiresAt;
  final DateTime refreshExpiresAt;

  const Token({
    required this.refreshToken,
    required this.provider,
    required this.accessToken,
    required this.refreshExpiresAt,
    required this.accessExpiresAt,
  });

  @override
  List<Object?> get props => [
    provider,
    accessToken,
    refreshToken,
    accessExpiresAt,
    refreshExpiresAt,
  ];

  @override
  bool? get stringify => true;
}

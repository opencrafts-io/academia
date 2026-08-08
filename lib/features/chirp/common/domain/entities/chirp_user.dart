import 'package:freezed_annotation/freezed_annotation.dart';

part 'chirp_user.freezed.dart';

@freezed
abstract class ChirpUser with _$ChirpUser {
  const factory ChirpUser({
    required String userID,
    String? email,
    String? phone,
    String? username,
    @Default(0) int vibePoints,
    String? avatarUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChirpUser;
}

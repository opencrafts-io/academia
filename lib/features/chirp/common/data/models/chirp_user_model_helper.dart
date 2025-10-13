import 'package:academia/database/database.dart';
import 'package:academia/features/chirp/common/common.dart';

extension ChirpUserHelper on ChirpUser {
  ChirpUserData toData() => ChirpUserData(
    userID: userID,
    vibePoints: vibePoints,
    createdAt: createdAt,
    updatedAt: updatedAt,
    email: email,
    phone: phone,
    username: username,
    avatarUrl: avatarUrl,
  );
}

extension ChirpUserModelHelper on ChirpUserData {
  ChirpUser toEntity() => ChirpUser(
    userID: userID,
    vibePoints: vibePoints,
    createdAt: createdAt,
    updatedAt: updatedAt,
    email: email,
    phone: phone,
    username: username,
    avatarUrl: avatarUrl,
  );
}

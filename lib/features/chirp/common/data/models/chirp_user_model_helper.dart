import 'package:academia/database/database.dart' as db;
import 'package:academia/features/chirp/common/common.dart';

extension ChirpUserApiDtoMapper on ChirpUserApiDto {
  db.ChirpUser toData() => db.ChirpUser(
    userID: userId,
    vibePoints: vibePoints,
    createdAt: createdAt,
    updatedAt: updatedAt,
    email: email,
    phone: phone,
    username: username,
    avatarUrl: avatarUrl,
  );

  ChirpUser toEntity() => toData().toEntity();
}

extension ChirpUserHelper on ChirpUser {
  db.ChirpUser toData() => db.ChirpUser(
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

extension ChirpUserModelHelper on db.ChirpUser {
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

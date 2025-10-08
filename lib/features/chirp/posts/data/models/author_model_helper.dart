import 'package:academia/database/database.dart';
import 'package:academia/features/chirp/posts/posts.dart';

extension AuthorModelHelper on AuthorData {
  Author toEntity() => Author(
        userId: userId,
        name: name,
        email: email,
        phone: phone,
        username: username,
        avatarUrl: avatarUrl,
        vibePoints: vibePoints,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension AuthorEntityHelper on Author {
  AuthorData toData() => AuthorData(
        userId: userId,
        name: name,
        email: email,
        phone: phone,
        username: username,
        avatarUrl: avatarUrl,
        vibePoints: vibePoints,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

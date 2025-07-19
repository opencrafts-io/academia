import 'package:academia/database/database.dart';
import '../../domain/entities/user.dart';

extension UserModelHelper on UserData {
  User toEntity() => User(id: id, name: name, email: email, avatar: avatar);
}

extension UserEntityHelper on User {
  UserData toData() => UserData(
    id: id,
    name: name,
    email: email,
    avatar: avatar,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}

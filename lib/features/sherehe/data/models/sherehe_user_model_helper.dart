import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/domain/entities/sherehe_user.dart';

extension ShereheUserModelHelper on ShereheUserData {
  ShereheUser toEntity() => ShereheUser(
    id: id,
    username: username,
    email: email,
    name: name,
    phone: phone,
  );
}

extension ShereheUserEntityHelper on ShereheUser {
  ShereheUserData toModel() => ShereheUserData(
    id: id,
    username: username,
    email: email,
    name: name,
    phone: phone,
  );
}

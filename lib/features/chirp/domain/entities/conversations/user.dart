import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? avatar;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });

  @override
  List<Object?> get props => [id, name, email, avatar];
}

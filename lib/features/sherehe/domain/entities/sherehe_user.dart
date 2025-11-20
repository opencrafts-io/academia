import 'package:equatable/equatable.dart';

class ShereheUser extends Equatable {
  final String id;
  final String username;
  final String email;
  final String name;
  final String phone;

  const ShereheUser({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.phone,
  });

  ShereheUser copyWith({
    String? id,
    String? username,
    String? email,
    String? name,
    String? phone,
  }) {
    return ShereheUser(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [id, username, email, name, phone];

  @override
  bool? get stringify => true;
}

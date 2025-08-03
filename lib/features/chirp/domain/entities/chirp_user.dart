import 'package:equatable/equatable.dart';

class ChirpUser extends Equatable {
  final String id;
  final String name;
  final String email;
  final int vibepoints;
  final String? avatarUrl;

  const ChirpUser({
    required this.id,
    required this.name,
    required this.email,
    this.vibepoints = 0,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, name, email, vibepoints, avatarUrl];

  @override
  bool? get stringify => true;

  ChirpUser copyWith({
    String? id,
    String? name,
    String? email,
    int? vibepoints,
    String? avatarUrl,
  }) {
    return ChirpUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      vibepoints: vibepoints ?? this.vibepoints,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}

import 'package:equatable/equatable.dart';

class InstitutionKey extends Equatable {
  final int institutionId;
  final String commandId;
  final Map<String, dynamic> keySets;
  final DateTime createdAt;

  const InstitutionKey({
    required this.institutionId,
    required this.commandId,
    required this.keySets,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [institutionId, commandId, keySets, createdAt];
}

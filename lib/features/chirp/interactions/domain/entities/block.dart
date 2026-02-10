import 'package:equatable/equatable.dart';

class Block extends Equatable {
  final int id;
  final String blockType;
  final String? blockedId;
  final String? blockedName;
  final String? blockedImage;
  final DateTime createdAt;

  const Block({
    required this.id,
    required this.blockType,
    this.blockedId,
    this.blockedName,
    this.blockedImage,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    blockType,
    blockedId,
    blockedName,
    blockedImage,
    createdAt,
  ];
}

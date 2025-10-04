import 'package:equatable/equatable.dart';

class Attachments extends Equatable {
  final String id;
  final String postId;
  final String attachmentType;
  final String file;
  final String name;
  final double size;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Attachments({
    required this.id,
    required this.attachmentType,
    required this.file,
    required this.name,
    required this.size,
    required this.postId,
    required this.createdAt,
    this.updatedAt,
  });

  Attachments copyWith({
    String? id,
    String? postId,
    String? attachmentType,
    String? file,
    String? name,
    double? size,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Attachments(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      attachmentType: attachmentType ?? this.attachmentType,
      file: file ?? this.file,
      name: name ?? this.name,
      size: size ?? this.size,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, postId, attachmentType, file, name, size, createdAt, updatedAt];
}

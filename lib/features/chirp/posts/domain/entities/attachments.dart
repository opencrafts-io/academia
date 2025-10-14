import 'package:equatable/equatable.dart';

class Attachments extends Equatable {
  final int id;
  final int postId;
  final String attachmentType;
  final String file;
  final String name;
  final int size;
  final DateTime createdAt;

  const Attachments({
    required this.id,
    required this.postId,
    required this.attachmentType,
    required this.file,
    required this.name,
    required this.size,
    required this.createdAt,
  });

  Attachments copyWith({
    int? id,
    int? postId,
    String? attachmentType,
    String? file,
    String? name,
    int? size,
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
    );
  }

  @override
  List<Object?> get props => [
    id,
    postId,
    attachmentType,
    file,
    name,
    size,
    createdAt,
  ];
}

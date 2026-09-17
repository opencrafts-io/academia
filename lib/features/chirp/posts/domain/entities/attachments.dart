import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachments.freezed.dart';

@freezed
abstract class Attachments with _$Attachments {
  const factory Attachments({
    required int id,
    required int postId,
    required String attachmentType,
    required String file,
    required String name,
    required int size,
    required DateTime createdAt,
  }) = _Attachments;
}

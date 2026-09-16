import 'package:freezed_annotation/freezed_annotation.dart';

part 'block.freezed.dart';

@freezed
abstract class Block with _$Block {
  const factory Block({
    required int id,
    required String blockType,
    String? blockedId,
    String? blockedName,
    String? blockedImage,
    required DateTime createdAt,
  }) = _Block;
}

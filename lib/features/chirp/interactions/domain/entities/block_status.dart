import 'package:freezed_annotation/freezed_annotation.dart';

part 'block_status.freezed.dart';

@freezed
abstract class BlockStatus with _$BlockStatus {
  const factory BlockStatus({
    required bool isBlocked,
    required String entityType,
    required String entityId,
  }) = _BlockStatus;
}

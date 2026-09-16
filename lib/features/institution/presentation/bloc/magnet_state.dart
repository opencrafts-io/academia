import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magnet/magnet.dart';

part 'magnet_state.freezed.dart';

@freezed
sealed class MagnetState with _$MagnetState {
  const factory MagnetState.initial() = _Initial;
  const factory MagnetState.initializing() = _Initializing;
  const factory MagnetState.ready(Magnet magnet) = _Ready;
  const factory MagnetState.processing({
    required ScrappingCommand command,
    InstructionProgressEvent? progress,
  }) = _Processing;
  const factory MagnetState.success(ScrappingResult result) = _Success;
  const factory MagnetState.error(String message) = _Error;
}

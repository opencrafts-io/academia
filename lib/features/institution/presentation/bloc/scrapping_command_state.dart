import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magnet/magnet.dart';

part 'scrapping_command_state.freezed.dart';

@freezed
sealed class ScrappingCommandState with _$ScrappingCommandState {
  const factory ScrappingCommandState.initial() = _Initial;
  const factory ScrappingCommandState.loading() = _Loading;
  const factory ScrappingCommandState.loaded(ScrappingCommand? command) =
      _Loaded;
  const factory ScrappingCommandState.error({
    required String message,
    ScrappingCommand? command,
  }) = _Error;
}

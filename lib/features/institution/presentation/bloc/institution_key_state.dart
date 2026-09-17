import 'package:academia/features/institution/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'institution_key_state.freezed.dart';

@freezed
sealed class InstitutionKeyState with _$InstitutionKeyState {
  const factory InstitutionKeyState.initial() = _Initial;
  const factory InstitutionKeyState.loading() = _Loading;
  const factory InstitutionKeyState.loaded(InstitutionKey? key) = _Loaded;
  const factory InstitutionKeyState.error({
    required String message,
    InstitutionKey? key,
  }) = _Error;
}

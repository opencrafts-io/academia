import 'package:academia/features/institution/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'institution_state.freezed.dart';

@freezed
sealed class InstitutionState with _$InstitutionState {
  const factory InstitutionState.initial() = _Initial;
  const factory InstitutionState.loading() = _Loading;
  const factory InstitutionState.linked() = _Linked;
  const factory InstitutionState.error(String error) = _Error;
  const factory InstitutionState.loaded(List<Institution> institutions) =
      _Loaded;
}

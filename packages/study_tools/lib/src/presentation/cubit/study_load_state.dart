import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_load_state.freezed.dart';

@freezed
sealed class StudyLoadState with _$StudyLoadState {
  const factory StudyLoadState.initial() = StudyLoadInitial;

  const factory StudyLoadState.loading() = StudyLoadLoading;

  const factory StudyLoadState.loaded() = StudyLoadLoaded;

  const factory StudyLoadState.failure({
    required String message,
    String? code,
  }) = StudyLoadFailure;
}

import 'package:academia/core/core.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_profile_state.freezed.dart';

@freezed
sealed class StudentProfileState with _$StudentProfileState {
  const factory StudentProfileState.initial() = _Initial;
  const factory StudentProfileState.loading() = _Loading;
  const factory StudentProfileState.success({
    InstitutionProfile? profile,
    @Default([]) List<InstitutionProfile> profiles,
  }) = _Success;
  const factory StudentProfileState.error({
    required String message,
    required Failure failure,
  }) = _Error;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academia/features/course/domain/entities/course_entity.dart';

part 'course_state.freezed.dart';

@freezed
class CourseState with _$CourseState {
  const factory CourseState.initial() = _Initial;
  const factory CourseState.loading() = _Loading;
  const factory CourseState.success(List<CourseEntity> courses) = _Success;
  const factory CourseState.error(String message) = _Error;
}

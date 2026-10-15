import 'package:courses/src/domain/entities/course_entity.dart';
import 'package:courses/src/domain/entities/schedule_entry_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_state.freezed.dart';

@freezed
abstract class CourseState with _$CourseState {
  const factory CourseState({
    @Default([]) List<CourseEntity> courses,
    CourseEntity? selectedCourse,
    @Default(false) bool isLoading,
    String? error,
    @Default([]) List<ScheduleEntryEntity> weeklySchedule,
    @Default(false) bool isScheduleLoading,
  }) = _CourseState;
}

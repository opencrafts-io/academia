import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_entry_dto.freezed.dart';
part 'schedule_entry_dto.g.dart';

@freezed
abstract class ScheduleEntryDto with _$ScheduleEntryDto {
  const factory ScheduleEntryDto({
    @Default('') String id,
    @JsonKey(name: 'day_of_week') required String dayOfWeek,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
    String? venue,
    String? campus,
    String? section,
    String? label,
    String? color,
    @JsonKey(name: 'is_recurring') @Default(true) bool isRecurring,
    @JsonKey(name: 'specific_date') DateTime? specificDate,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    ScheduleCourseDto? course,
  }) = _ScheduleEntryDto;

  factory ScheduleEntryDto.fromJson(Map<String, dynamic> json) =>
      _$ScheduleEntryDtoFromJson(json);
}

@freezed
abstract class ScheduleCourseDto with _$ScheduleCourseDto {
  const factory ScheduleCourseDto({
    required String id,
    required String title,
    String? code,
    String? color,
  }) = _ScheduleCourseDto;

  factory ScheduleCourseDto.fromJson(Map<String, dynamic> json) =>
      _$ScheduleCourseDtoFromJson(json);
}

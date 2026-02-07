import 'package:flutter/widgets.dart'; // For the Color class
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_entity.freezed.dart';

@freezed
abstract class CourseEntity with _$CourseEntity {
  const factory CourseEntity({
    /// Local UUID for offline-first identification
    String? id,

    /// Unique ID from the remote database
    int? serverId,

    /// Reference to the Institution ID
    int? institutionId,

    /// Reference to the Semester ID
    int? semesterId,

    required String courseCode,

    required String courseName,

    required String instructor,

    /// UI color for the course, defaults to a specific dark hex if null
    @Default(Color(0x1E1E2EFF)) Color? color,

    @Default(false) bool isSynced,

    @Default(false) bool isDeleted,

    DateTime? createdAt,

    DateTime? updatedAt,
  }) = _CourseEntity;
}

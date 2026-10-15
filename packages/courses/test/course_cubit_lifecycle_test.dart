import 'dart:async';

import 'package:core/core.dart';
import 'package:courses/src/domain/domain.dart';
import 'package:courses/src/domain/usecases/course_usecases.dart';
import 'package:courses/src/presentation/bloc/course_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'does not emit when lecturer refresh completes after the sheet closes',
    () async {
      final repository = _DeferredCourseRepository();
      final cubit = CourseCubit(
        CreateCourse(repository),
        ListActiveCourses(repository),
        ListArchivedCourses(repository),
        GetCourse(repository),
        UpdateCourse(repository),
        ArchiveCourse(repository),
        DeleteCourse(repository),
        AddLecturer(repository),
        UpdateLecturer(repository),
        DeleteLecturer(repository),
        _InstitutionLookup(),
        ListStudentSchedule(repository),
        CreateScheduleEntry(repository),
        UpdateScheduleEntry(repository),
        DeleteScheduleEntry(repository),
        WatchSyncStatusUpdates(repository),
        _CourseReminderRefresher(),
      );

      await cubit.addLecturer(
        const AddLecturerParams(courseId: 'course-1', name: 'Lecturer'),
      );
      await cubit.close();
      repository.courseResult.complete(right(_course()));
      await Future<void>.delayed(Duration.zero);
    },
  );
}

CourseEntity _course() => CourseEntity(
  id: 'course-1',
  institutionId: 1,
  title: 'Course',
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

class _DeferredCourseRepository implements CourseRepository {
  final courseResult = Completer<Either<Failure, CourseEntity>>();

  @override
  Stream<SyncStatusUpdate> get syncStatusUpdates => const Stream.empty();

  @override
  Future<Either<Failure, LecturerEntity>> addLecturer({
    required String courseId,
    required String name,
    String? email,
    String? phone,
    String? office,
  }) async =>
      right(LecturerEntity(id: 'lecturer-1', courseId: courseId, name: name));

  @override
  Future<Either<Failure, CourseEntity>> getCourse(String id) =>
      courseResult.future;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _InstitutionLookup implements InstitutionLookup {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _CourseReminderRefresher implements CourseReminderRefresher {
  @override
  Future<void> refresh() async {}

  @override
  void updatePreferences({
    required bool enabled,
    required List<int?> reminderMinutes,
  }) {}
}

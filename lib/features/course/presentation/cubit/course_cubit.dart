import 'dart:async';
import 'package:academia/core/core.dart';
import 'package:academia/features/course/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  final WatchAllCoursesUsecase _watchAllCourses;
  final SaveCourseUsecase _saveCourse;
  final DeleteCourseUsecase _deleteCourse;
  final WatchInstitutionCoursesUsecase _watchInstitutionCourses;
  final GetCourseUsecase _getCourse;

  // Track the active stream subscription
  StreamSubscription? _coursesSubscription;

  CourseCubit({
    required WatchAllCoursesUsecase watchAllCourses,
    required WatchInstitutionCoursesUsecase watchInstitutionCourses,
    required SaveCourseUsecase saveCourse,
    required DeleteCourseUsecase deleteCourse,
    required GetCourseUsecase getCourse,
  }) : _watchAllCourses = watchAllCourses,
       _saveCourse = saveCourse,
       _deleteCourse = deleteCourse,
       _watchInstitutionCourses = watchInstitutionCourses,
       _getCourse = getCourse,
       super(const CourseState.initial());

  /// Fetches a specific course by ID.
  /// Usually used for navigating to a detail page or initializing an edit form.
  Future<void> fetchCourse(String id) async {
    emit(const CourseState.loading());

    // We cancel any active stream because we are moving to a "Single Item" view state
    _coursesSubscription?.cancel();

    final result = await _getCourse(id);

    result.fold(
      (failure) => emit(CourseState.error(failure.message)),
      (course) => emit(CourseState.success([course])),
    );
  }

  /// Starts watching all courses.
  /// Automatically updates the state whenever the database changes.
  void watchCourses() {
    _subscribeToStream(() => _watchAllCourses(NoParams()));
  }

  /// Watches courses specifically for one institution.
  void watchByInstitution(int institutionId) {
    _subscribeToStream(() => _watchInstitutionCourses(institutionId));
  }

  void _subscribeToStream(
    Stream<Either<Failure, List<CourseEntity>>> Function() streamProvider,
  ) {
    emit(const CourseState.loading());

    // Cleanup old subscription before starting a new one
    _coursesSubscription?.cancel();

    _coursesSubscription = streamProvider().listen(
      (result) {
        result.fold(
          (failure) => emit(CourseState.error(failure.message)),
          (courses) => emit(CourseState.success(courses)),
        );
      },
      onError: (error) {
        emit(CourseState.error("Stream connection failed: $error"));
      },
    );
  }

  /// Saves or updates a course.
  /// Because the UI is watching the stream, we don't need to manually
  /// update the state on success; the stream will fire automatically.
  Future<void> addOrUpdateCourse(CourseEntity course) async {
    final result = await _saveCourse(course);
    result.fold(
      (failure) => emit(CourseState.error(failure.message)),
      (_) => null, // Success handled by the stream
    );
  }

  /// Deletes a course by ID.
  Future<void> removeCourse(String id) async {
    final result = await _deleteCourse(id);
    result.fold(
      (failure) => emit(CourseState.error(failure.message)),
      (_) => null, // Success handled by the stream
    );
  }

  /// Crucial for memory management: Close the stream when the Cubit is disposed.
  @override
  Future<void> close() {
    _coursesSubscription?.cancel();
    return super.close();
  }
}

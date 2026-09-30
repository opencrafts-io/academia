import 'package:core/core.dart';
import 'package:courses/src/domain/domain.dart';
import 'package:courses/src/domain/usecases/course_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'course_state.dart';

@injectable
class CourseCubit extends Cubit<CourseState> {
  CourseCubit(
    this._createCourse,
    this._listActiveCourses,
    this._listArchivedCourses,
    this._getCourse,
    this._updateCourse,
    this._archiveCourse,
    this._deleteCourse,
    this._addLecturer,
    this._updateLecturer,
    this._deleteLecturer,
    this._institutionLookup,
  ) : super(const CourseState());

  final CreateCourse _createCourse;
  final ListActiveCourses _listActiveCourses;
  final ListArchivedCourses _listArchivedCourses;
  final GetCourse _getCourse;
  final UpdateCourse _updateCourse;
  final ArchiveCourse _archiveCourse;
  final DeleteCourse _deleteCourse;
  final AddLecturer _addLecturer;
  final UpdateLecturer _updateLecturer;
  final DeleteLecturer _deleteLecturer;
  final InstitutionLookup _institutionLookup;

  Future<void> loadActive() =>
      _load(_listActiveCourses(const NoUseCaseParams()));

  Future<void> loadArchived() =>
      _load(_listArchivedCourses(const NoUseCaseParams()));

  Future<void> loadActiveForInstitution(int institutionId) async {
    await _load(_listActiveCourses(const NoUseCaseParams()));
    emit(
      state.copyWith(
        courses: state.courses
            .where((course) => course.institutionId == institutionId)
            .toList(),
      ),
    );
  }

  Future<void> loadCourse(String id) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _getCourse(id);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (course) => emit(
        state.copyWith(
          isLoading: false,
          selectedCourse: course,
          courses: [course],
        ),
      ),
    );
  }

  Future<void> create(CreateCourseParams params) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _createCourse(params);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (course) => emit(
        state.copyWith(
          isLoading: false,
          selectedCourse: course,
          courses: [...state.courses, course],
        ),
      ),
    );
  }

  Future<void> update(CourseEntity course) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _updateCourse(course);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      _replaceSelected,
    );
  }

  Future<void> archive(String id) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _archiveCourse(id);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (course) => emit(
        state.copyWith(
          isLoading: false,
          selectedCourse: course,
          courses: state.courses.where((item) => item.id != course.id).toList(),
        ),
      ),
    );
  }

  Future<void> delete(String id) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _deleteCourse(id);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => emit(
        state.copyWith(
          isLoading: false,
          selectedCourse: state.selectedCourse?.id == id
              ? null
              : state.selectedCourse,
          courses: state.courses.where((course) => course.id != id).toList(),
        ),
      ),
    );
  }

  Future<void> addLecturer(AddLecturerParams params) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _addLecturer(params);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => loadCourse(params.courseId),
    );
  }

  Future<void> updateLecturer(LecturerEntity lecturer) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _updateLecturer(lecturer);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => loadCourse(lecturer.courseId),
    );
  }

  Future<void> deleteLecturer(LecturerEntity lecturer) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _deleteLecturer(lecturer);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => loadCourse(lecturer.courseId),
    );
  }

  Future<List<InstitutionSummary>> searchInstitutions(String query) {
    return _institutionLookup.search(query);
  }

  Future<void> _load(Future<dynamic> request) async {
    emit(state.copyWith(isLoading: true, error: null, selectedCourse: null));
    final result = await request;
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (courses) => emit(state.copyWith(isLoading: false, courses: courses)),
    );
  }

  void _replaceSelected(CourseEntity course) {
    emit(
      state.copyWith(
        isLoading: false,
        selectedCourse: course,
        courses: [
          for (final existing in state.courses)
            if (existing.id == course.id) course else existing,
        ],
      ),
    );
  }
}

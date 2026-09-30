import 'dart:async';

import 'package:core/core.dart';
import 'package:courses/src/domain/domain.dart';
import 'package:injectable/injectable.dart';

import 'course_state.dart';

@injectable
class CourseCubit extends SafeCubit<CourseState> {
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
    this._listStudentSchedule,
    this._createScheduleEntry,
    this._updateScheduleEntry,
    this._deleteScheduleEntry,
    this._watchSyncStatusUpdates,
    this._courseReminderRefresher,
  ) : super(const CourseState()) {
    _syncSubscription = _watchSyncStatusUpdates().listen(_applySyncUpdate);
  }

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
  final ListStudentSchedule _listStudentSchedule;
  final CreateScheduleEntry _createScheduleEntry;
  final UpdateScheduleEntry _updateScheduleEntry;
  final DeleteScheduleEntry _deleteScheduleEntry;
  final WatchSyncStatusUpdates _watchSyncStatusUpdates;
  final CourseReminderRefresher _courseReminderRefresher;
  StreamSubscription<SyncStatusUpdate>? _syncSubscription;

  @override
  Future<void> close() async {
    await _syncSubscription?.cancel();
    await super.close();
  }

  Future<void> loadActive() async {
    await _load(_listActiveCourses(const NoUseCaseParams()));
    await _courseReminderRefresher.refresh();
  }

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
    await _courseReminderRefresher.refresh();
  }

  Future<void> loadRetakeChoices() async {
    emit(state.copyWith(isLoading: true, error: null));
    final results = await Future.wait([
      _listActiveCourses(const NoUseCaseParams()),
      _listArchivedCourses(const NoUseCaseParams()),
    ]);
    final courses = <String, CourseEntity>{};
    String? error;
    for (final result in results) {
      result.fold(
        (failure) => error ??= failure.message,
        (items) => courses.addEntries(
          items.map((course) => MapEntry(course.id, course)),
        ),
      );
    }
    emit(
      state.copyWith(
        isLoading: false,
        error: courses.isEmpty ? error : null,
        courses: courses.values.toList(),
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
    await _courseReminderRefresher.refresh();
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
    if (result.isRight()) await _courseReminderRefresher.refresh();
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
    if (result.isRight()) await _courseReminderRefresher.refresh();
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
    if (result.isRight()) await _courseReminderRefresher.refresh();
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

  Future<void> loadWeeklySchedule() async {
    emit(state.copyWith(isScheduleLoading: true, error: null));
    final result = await _listStudentSchedule(const NoUseCaseParams());
    result.fold(
      (failure) => emit(
        state.copyWith(isScheduleLoading: false, error: failure.message),
      ),
      (entries) => emit(
        state.copyWith(isScheduleLoading: false, weeklySchedule: entries),
      ),
    );
    await _courseReminderRefresher.refresh();
  }

  Future<void> createScheduleEntry(ScheduleEntryEntity entry) async {
    emit(state.copyWith(isScheduleLoading: true, error: null));
    final result = await _createScheduleEntry(entry);
    result.fold(
      (failure) => emit(
        state.copyWith(isScheduleLoading: false, error: failure.message),
      ),
      (created) => _replaceScheduleEntry(created, addIfMissing: true),
    );
    if (result.isRight()) await _courseReminderRefresher.refresh();
  }

  Future<void> updateScheduleEntry(ScheduleEntryEntity entry) async {
    emit(state.copyWith(isScheduleLoading: true, error: null));
    final result = await _updateScheduleEntry(entry);
    result.fold(
      (failure) => emit(
        state.copyWith(isScheduleLoading: false, error: failure.message),
      ),
      (updated) => _replaceScheduleEntry(updated),
    );
    if (result.isRight()) await _courseReminderRefresher.refresh();
  }

  Future<void> deleteScheduleEntry(String id) async {
    emit(state.copyWith(isScheduleLoading: true, error: null));
    final result = await _deleteScheduleEntry(id);
    result.fold(
      (failure) => emit(
        state.copyWith(isScheduleLoading: false, error: failure.message),
      ),
      (_) {
        final weekly = state.weeklySchedule
            .where((entry) => entry.id != id)
            .toList();
        final selected = state.selectedCourse;
        final selectedEntries = selected?.scheduleEntries
            .where((entry) => entry.id != id)
            .toList();
        emit(
          state.copyWith(
            isScheduleLoading: false,
            weeklySchedule: weekly,
            selectedCourse: selected == null
                ? null
                : selected.copyWith(scheduleEntries: selectedEntries!),
          ),
        );
      },
    );
    if (result.isRight()) await _courseReminderRefresher.refresh();
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

  void _replaceScheduleEntry(
    ScheduleEntryEntity entry, {
    bool addIfMissing = false,
  }) {
    List<ScheduleEntryEntity> replace(List<ScheduleEntryEntity> entries) {
      final exists = entries.any((item) => item.id == entry.id);
      if (!exists && !addIfMissing) return entries;
      final next = [
        for (final item in entries)
          if (item.id == entry.id) entry else item,
        if (!exists && addIfMissing) entry,
      ];
      next.sort((a, b) {
        final day = _weekdays
            .indexOf(a.dayOfWeek)
            .compareTo(_weekdays.indexOf(b.dayOfWeek));
        return day == 0 ? a.startTime.compareTo(b.startTime) : day;
      });
      return next;
    }

    final weekly = replace(state.weeklySchedule);
    final selected = state.selectedCourse;
    final updatedSelected =
        selected == null || selected.id != entry.studentCourseId
        ? selected
        : selected.copyWith(scheduleEntries: replace(selected.scheduleEntries));
    emit(
      state.copyWith(
        isScheduleLoading: false,
        weeklySchedule: weekly,
        selectedCourse: updatedSelected,
      ),
    );
  }

  void _applySyncUpdate(SyncStatusUpdate update) {
    if (update.isScheduleEntry) {
      ScheduleEntryEntity apply(ScheduleEntryEntity entry) =>
          entry.id == update.id
          ? entry.copyWith(
              serverId: update.serverId ?? entry.serverId,
              syncStatus: update.status,
              lastSyncError: update.error,
            )
          : entry;
      final weekly = state.weeklySchedule.map(apply).toList();
      final selected = state.selectedCourse;
      emit(
        state.copyWith(
          weeklySchedule: weekly,
          selectedCourse: selected?.copyWith(
            scheduleEntries: selected.scheduleEntries.map(apply).toList(),
          ),
        ),
      );
      return;
    }

    CourseEntity apply(CourseEntity course) => course.id == update.id
        ? course.copyWith(
            serverId: update.serverId ?? course.serverId,
            syncStatus: update.status,
            lastSyncError: update.error,
          )
        : course;
    emit(
      state.copyWith(
        courses: state.courses.map(apply).toList(),
        selectedCourse: state.selectedCourse == null
            ? null
            : apply(state.selectedCourse!),
      ),
    );
  }

  static const _weekdays = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];
}

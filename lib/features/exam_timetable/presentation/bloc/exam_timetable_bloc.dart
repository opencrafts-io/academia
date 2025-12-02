import 'package:academia/features/exam_timetable/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'exam_timetable_event.dart';
part 'exam_timetable_state.dart';

class ExamTimetableBloc extends Bloc<ExamTimetableEvent, ExamTimetableState> {
  final GetCachedExamsUseCase getCachedExamsUseCase;
  final GetExamTimetableUseCase getExamTimetableUseCase;
  final CacheExamsUseCase cacheExamsUseCase;
  final RefreshExamTimetableUseCase refreshExamTimetableUseCase;
  final DeleteExamByCourseCodeUseCase deleteExamByCourseCodeUseCase;

  ExamTimetableBloc({
    required this.getCachedExamsUseCase,
    required this.getExamTimetableUseCase,
    required this.cacheExamsUseCase,
    required this.refreshExamTimetableUseCase,
    required this.deleteExamByCourseCodeUseCase,
  }) : super(ExamTimetableInitial()) {
    on<LoadCachedExams>(_onLoadCachedExams);
    on<SearchExamTimetable>(_onSearchExamTimetable);
    on<AddExamsToTimetable>(_onAddExamsToTimetable);
    on<RefreshExamTimetable>(_onRefreshExamTimetable);
    on<DeleteExamByCourseCode>(_onDeleteExamByCourseCode);
  }

  Future<void> _onLoadCachedExams(
    LoadCachedExams event,
    Emitter<ExamTimetableState> emit,
  ) async {
    emit(ExamTimetableLoading());

    final result = await getCachedExamsUseCase(
      institutionId: event.institutionId,
      courseCodes: event.courseCodes,
    );

    result.fold(
      (failure) => emit(ExamTimetableError(message: failure.message)),
      (exams) {
        if (exams.isEmpty) {
          emit(
            ExamTimetableEmpty(
              message:
                  event.courseCodes != null && event.courseCodes!.isNotEmpty
                  ? "No cached exams found for the selected courses"
                  : "No cached exams found for this institution",
            ),
          );
        } else {
          emit(ExamTimetableLoaded(exams: exams));
        }
      },
    );
  }

  Future<void> _onSearchExamTimetable(
    SearchExamTimetable event,
    Emitter<ExamTimetableState> emit,
  ) async {
    emit(ExamTimetableLoading());

    final result = await getExamTimetableUseCase(
      institutionId: event.institutionId,
      courseCodes: event.courseCodes,
    );

    result.fold(
      (failure) => emit(ExamTimetableError(message: failure.message)),
      (exams) {
        if (exams.isEmpty) {
          emit(
            ExamTimetableEmpty(
              message: "No exams found for the specified course codes",
            ),
          );
        } else {
          emit(ExamTimetableLoaded(exams: exams));
        }
      },
    );
  }

  Future<void> _onAddExamsToTimetable(
    AddExamsToTimetable event,
    Emitter<ExamTimetableState> emit,
  ) async {
    final result = await cacheExamsUseCase(event.exams);

    result.fold((failure) => emit(ExamTimetableError(message: failure.message)), (
      _,
    ) {
      if (event.exams.isNotEmpty) {
        add(LoadCachedExams(institutionId: event.exams.first.institutionId));
      }
    });
  }

  Future<void> _onRefreshExamTimetable(
    RefreshExamTimetable event,
    Emitter<ExamTimetableState> emit,
  ) async {
    emit(
      ExamTimetableRefreshing(
        previousExams: state is ExamTimetableLoaded
            ? (state as ExamTimetableLoaded).exams
            : [],
      ),
    );

    final result = await refreshExamTimetableUseCase(
      institutionId: event.institutionId,
      courseCodes: event.courseCodes,
    );

    result.fold(
      (failure) => emit(ExamTimetableError(message: failure.message)),
      (exams) {
        if (exams.isEmpty) {
          emit(
            ExamTimetableEmpty(
              message:
                  event.courseCodes != null && event.courseCodes!.isNotEmpty
                  ? "No exams found for the specified course codes"
                  : "No exams found for this institution",
            ),
          );
        } else {
          emit(ExamTimetableLoaded(exams: exams));
        }
      },
    );
  }

  Future<void> _onDeleteExamByCourseCode(
    DeleteExamByCourseCode event,
    Emitter<ExamTimetableState> emit,
  ) async {
    final result = await deleteExamByCourseCodeUseCase(
      courseCode: event.courseCode,
      institutionId: event.institutionId,
    );

    result.fold(
      (failure) => emit(ExamTimetableError(message: failure.message)),
      (_) {
        // Reload cached exams
        add(LoadCachedExams(institutionId: event.institutionId));
      },
    );
  }

}

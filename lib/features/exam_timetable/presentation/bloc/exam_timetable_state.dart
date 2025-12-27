part of 'exam_timetable_bloc.dart';

abstract class ExamTimetableState extends Equatable {
  const ExamTimetableState();

  @override
  List<Object?> get props => [];
}

class ExamTimetableInitial extends ExamTimetableState {}

class ExamTimetableLoading extends ExamTimetableState {}

class ExamTimetableRefreshing extends ExamTimetableState {
  final List<ExamTimetable> previousExams;

  const ExamTimetableRefreshing({required this.previousExams});

  @override
  List<Object> get props => [previousExams];
}

class ExamTimetableLoaded extends ExamTimetableState {
  final List<ExamTimetable> exams;

  const ExamTimetableLoaded({required this.exams});

  @override
  List<Object> get props => [exams];
}

class ExamTimetableEmpty extends ExamTimetableState {
  final String message;

  const ExamTimetableEmpty({required this.message});

  @override
  List<Object> get props => [message];
}

class ExamTimetableError extends ExamTimetableState {
  final String message;

  const ExamTimetableError({required this.message});

  @override
  List<Object> get props => [message];
}

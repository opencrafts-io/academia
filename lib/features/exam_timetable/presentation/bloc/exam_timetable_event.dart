part of 'exam_timetable_bloc.dart';

abstract class ExamTimetableEvent extends Equatable {
  const ExamTimetableEvent();

  @override
  List<Object?> get props => [];
}

class LoadCachedExams extends ExamTimetableEvent {
  final String institutionId;
  final List<String>? courseCodes;

  const LoadCachedExams({required this.institutionId, this.courseCodes});

  @override
  List<Object?> get props => [institutionId, courseCodes];
}

class SearchExamTimetable extends ExamTimetableEvent {
  final String institutionId;
  final List<String> courseCodes;

  const SearchExamTimetable({
    required this.institutionId,
    required this.courseCodes,
  });

  @override
  List<Object?> get props => [institutionId, courseCodes];
}

class AddExamsToTimetable extends ExamTimetableEvent {
  final List<ExamTimetable> exams;

  const AddExamsToTimetable({required this.exams});

  @override
  List<Object?> get props => [exams];
}

class RefreshExamTimetable extends ExamTimetableEvent {
  final String institutionId;
  final List<String>? courseCodes;

  const RefreshExamTimetable({required this.institutionId, this.courseCodes});

  @override
  List<Object?> get props => [institutionId, courseCodes];
}

class DeleteExamByCourseCode extends ExamTimetableEvent {
  final String courseCode;
  final String institutionId;

  const DeleteExamByCourseCode({
    required this.courseCode,
    required this.institutionId,
  });

  @override
  List<Object> get props => [courseCode, institutionId];
}


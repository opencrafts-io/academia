import 'dart:async';
import 'package:academia/features/course/course.dart';
import 'package:academia/features/exam_timetable/domain/entity/exam_timetable.dart';
import 'package:academia/features/exam_timetable/presentation/bloc/exam_timetable_bloc.dart';
import 'package:academia/features/exam_timetable/presentation/screens/exam_timetable_search_screen.dart';
import 'package:academia/features/exam_timetable/presentation/widgets/exam_timetable_app_bar.dart';
import 'package:academia/features/exam_timetable/presentation/widgets/exam_timetable_list.dart';
import 'package:academia/features/exam_timetable/presentation/widgets/exams_empty_state.dart';
import 'package:academia/features/exam_timetable/presentation/widgets/institution_switcher_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamTimetableHomeScreen extends StatefulWidget {
  final int institutionId;

  const ExamTimetableHomeScreen({super.key, required this.institutionId});

  @override
  State<ExamTimetableHomeScreen> createState() =>
      _ExamTimetableHomeScreenState();
}

class _ExamTimetableHomeScreenState extends State<ExamTimetableHomeScreen> {
  Timer? _timer;
  bool _hasAttemptedAutoImport = false;
  bool _autoImportDispatched = false;
  bool _autoImportResultPending = false;
  late int _institutionId;

  @override
  void initState() {
    super.initState();
    _institutionId = widget.institutionId;
    _loadCachedExams();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _loadCachedExams() {
    context.read<ExamTimetableBloc>().add(
      LoadCachedExams(institutionId: _institutionId),
    );
  }

  void _loadCoursesFromLocal() {
    context.read<CourseCubit>().watchByInstitution(_institutionId);
  }

  void _navigateToSearch() {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: context.read<ExamTimetableBloc>(),
              child: ExamTimetableSearchScreen(institutionId: _institutionId),
            ),
          ),
        )
        .then((_) {
          _loadCachedExams();
        });
  }

  Future<void> _refreshExams() async {
    final currentState = context.read<ExamTimetableBloc>().state;

    List<String> currentCourseCodes = [];
    if (currentState is ExamTimetableLoaded) {
      currentCourseCodes = currentState.exams.map((e) => e.courseCode).toList();
    }

    if (currentCourseCodes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No courses to refresh. Add exams first."),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    context.read<ExamTimetableBloc>().add(
      RefreshExamTimetable(
        institutionId: _institutionId,
        courseCodes: currentCourseCodes,
      ),
    );
  }

  void _switchInstitution(int institutionId) {
    if (institutionId == _institutionId) return;
    setState(() {
      _institutionId = institutionId;
      _hasAttemptedAutoImport = false;
      _autoImportDispatched = false;
    });
    _loadCachedExams();
  }

  void _showSwipeInfo() {
    final colorScheme = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.swipe_left_rounded, color: colorScheme.onPrimary),
            const SizedBox(width: 12),
            const Expanded(
              child: Text("Swipe an exam card to the left to delete it."),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.primary,
        showCloseIcon: true,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: ExamTimetableAppBar(
        onSearchTap: _navigateToSearch,
        onHelpTap: _showSwipeInfo,
      ),
      body: Column(
        children: [
          InstitutionSwitcherChip(
            currentInstitutionId: _institutionId,
            onSwitch: _switchInstitution,
          ),
          Expanded(
            child: BlocListener<CourseCubit, CourseState>(
              listener: (context, courseState) {
                // Only active during the one-time auto-import flow (timetable was empty on open).
                if (!_hasAttemptedAutoImport || _autoImportDispatched) return;
                courseState.whenOrNull(
                  success: (courses) {
                    if (courses.isNotEmpty && mounted) {
                      _autoImportDispatched = true;
                      _autoImportResultPending = true;
                      final courseCodes = courses
                          .map((e) => e.courseCode)
                          .toList();
                      context.read<ExamTimetableBloc>().add(
                        RefreshExamTimetable(
                          institutionId: _institutionId,
                          courseCodes: courseCodes,
                        ),
                      );
                    }
                  },
                );
              },
              child: BlocConsumer<ExamTimetableBloc, ExamTimetableState>(
                listener: (context, state) {
                  if (state is ExamTimetableError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(state.message),
                        backgroundColor: colorScheme.error,
                      ),
                    );
                  }

                  // Only auto-import once, and only when the timetable is truly empty.
                  if (state is ExamTimetableEmpty && !_hasAttemptedAutoImport) {
                    _hasAttemptedAutoImport = true;
                    _loadCoursesFromLocal();
                  }

                  // Auto-import silently adds exams from every enrolled course
                  // (see the CourseCubit listener above) — tell the user once
                  // it lands, since that's otherwise indistinguishable from a
                  // manual add and now also schedules reminders.
                  if (_autoImportResultPending &&
                      (state is ExamTimetableLoaded ||
                          state is ExamTimetableEmpty ||
                          state is ExamTimetableError)) {
                    _autoImportResultPending = false;
                    if (state is ExamTimetableLoaded) {
                      final count = state.exams.length;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            'Added $count exam${count == 1 ? '' : 's'} from '
                            'your enrolled courses — reminders are on',
                          ),
                          backgroundColor: colorScheme.primary,
                        ),
                      );
                    }
                  }
                },
                builder: (context, state) {
                  if (state is ExamTimetableLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                      ),
                    );
                  }

                  List<ExamTimetable>? displayExams;
                  bool isRefreshing = false;

                  if (state is ExamTimetableLoaded) {
                    displayExams = state.exams;
                  } else if (state is ExamTimetableRefreshing) {
                    displayExams = state.previousExams;
                    isRefreshing = true;
                  }

                  if (state is ExamTimetableEmpty ||
                      (displayExams != null && displayExams.isEmpty)) {
                    return const EmptyState();
                  }

                  if (displayExams != null) {
                    return ExamTimetableList(
                      exams: displayExams,
                      isRefreshing: isRefreshing,
                      institutionId: _institutionId,
                      onRefresh: _refreshExams,
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

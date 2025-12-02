import 'dart:async';
import 'package:academia/config/router/routes.dart';
import 'package:academia/features/exam_timetable/presentation/widgets/countdown_timer.dart';
import 'package:academia/features/exam_timetable/presentation/widgets/exam_card.dart';
import 'package:academia/features/exam_timetable/presentation/widgets/exams_empty_state.dart';
import 'package:academia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:academia/features/profile/presentation/widgets/user_avatar.dart';
import 'package:academia/features/magnet/presentation/bloc/magnet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/exam_timetable/presentation/bloc/exam_timetable_bloc.dart';
import 'package:academia/features/exam_timetable/domain/entity/exam_timetable.dart';
import 'package:academia/features/exam_timetable/presentation/screens/exam_timetable_search_screen.dart';

class ExamTimetableHomeScreen extends StatefulWidget {
  final String institutionId;

  const ExamTimetableHomeScreen({super.key, required this.institutionId});

  @override
  State<ExamTimetableHomeScreen> createState() =>
      _ExamTimetableHomeScreenState();
}

class _ExamTimetableHomeScreenState extends State<ExamTimetableHomeScreen> {
  Timer? _timer;
  bool _hasAttemptedAutoImport = false;

  @override
  void initState() {
    super.initState();
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
    context.read<ExamTimetableBloc>().add(LoadCachedExams());
  }

  void _importCoursesFromMagnet() {
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadedState) {
      try {
        final institutionIdInt = int.parse(widget.institutionId);
        context.read<MagnetBloc>().add(
          GetCachedMagnetStudentTimetableEvent(
            institutionID: institutionIdInt,
            userID: profileState.profile.id,
          ),
        );
      } on Exception catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid institution ID format")),
        );
      }
    }
  }

  void _navigateToSearch() {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: context.read<ExamTimetableBloc>(),
              child: ExamTimetableSearchScreen(
                institutionId: widget.institutionId,
              ),
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
        institutionId: widget.institutionId,
        courseCodes: currentCourseCodes,
      ),
    );
  }

  ExamTimetable? _getNextExam(List<ExamTimetable> exams) {
    // final now = DateTime.now();
    final upcomingExams = exams.where((exam) => exam.isUpcoming).toList()
      ..sort((a, b) => a.datetimeStr.compareTo(b.datetimeStr));

    return upcomingExams.isNotEmpty ? upcomingExams.first : null;
  }

  List<ExamTimetable> _getUpcomingExams(List<ExamTimetable> exams) {
    return exams.where((exam) => exam.isUpcoming).toList()
      ..sort((a, b) => a.datetimeStr.compareTo(b.datetimeStr));
  }

  List<ExamTimetable> _getPastExams(List<ExamTimetable> exams) {
    return exams.where((exam) => exam.isPast).toList()..sort(
      (a, b) => b.datetimeStr.compareTo(a.datetimeStr),
    ); // Most recent first
  }

  void _showSwipeInfo() {
    final colorScheme = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.swipe_left, color: colorScheme.onPrimary),
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: InkWell(
          onTap: _navigateToSearch,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: 44,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(50),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              'Search by course code',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        actions: [
          IconButton(
            tooltip: "Help",
            onPressed: _showSwipeInfo,
            icon: Icon(
              Icons.info_outline_rounded,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          IconButton(
            onPressed: () {
              ProfileRoute().push(context);
            },
            icon: UserAvatar(scallopDepth: 4, numberOfScallops: 12),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ExamTimetableBloc, ExamTimetableState>(
            listener: (context, state) {
              if (state is ExamTimetableError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: colorScheme.error,
                  ),
                );
              }

              if (state is ExamTimetableEmpty) {
                if (!_hasAttemptedAutoImport) {
                  _hasAttemptedAutoImport = true;
                  _importCoursesFromMagnet();
                }
              }
            },
          ),
          BlocListener<MagnetBloc, MagnetState>(
            listener: (context, state) {
              if (state is MagnetTimeTableLoadedState) {
                final courseCodes = state.timetable
                    .map((e) {
                      final cleanCode = e.courseCode.replaceAll('-', '');

                      if (e.courseType != null) {
                        if (e.courseType!.contains('-')) {
                          final suffix = e.courseType!.split('-').first;
                          return '$cleanCode$suffix';
                        }
                      }
                      return cleanCode;
                    })
                    .toSet()
                    .take(6)
                    .toList();

                if (courseCodes.isNotEmpty) {
                  context.read<ExamTimetableBloc>().add(
                    RefreshExamTimetable(
                      institutionId: widget.institutionId,
                      courseCodes: courseCodes,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "No courses found in your class timetable.",
                      ),
                    ),
                  );
                }
              }

              if (state is MagnetErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Failed to load class timetable: ${state.error}",
                    ),
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<ExamTimetableBloc, ExamTimetableState>(
          builder: (context, state) {
            if (state is ExamTimetableLoading) {
              return Center(
                child: CircularProgressIndicator(color: colorScheme.primary),
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
              return EmptyState();
            }

            if (displayExams != null) {
              final upcomingExams = _getUpcomingExams(displayExams);
              final pastExams = _getPastExams(displayExams);
              final nextExam = _getNextExam(displayExams);

              return RefreshIndicator(
                onRefresh: _refreshExams,
                color: colorScheme.primary,
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 16),
                  children: [
                    if (isRefreshing)
                      LinearProgressIndicator(
                        color: colorScheme.primary,
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        minHeight: 2,
                      ),
                    if (nextExam != null)
                      CountdownTimer(targetDateTime: nextExam.datetimeStr),
                    // Upcoming
                    if (upcomingExams.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                        child: Row(
                          children: [
                            Text(
                              'Upcoming Exams',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.tertiaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${upcomingExams.length}',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: upcomingExams.asMap().entries.map((entry) {
                            return ExamCard(
                              exam: entry.value,
                              index: entry.key,
                              institutionId: widget.institutionId,
                            );
                          }).toList(),
                        ),
                      ),
                    ],

                    // Past
                    if (pastExams.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                        child: Row(
                          children: [
                            Text(
                              'Past Exams',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${pastExams.length}',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: pastExams.asMap().entries.map((entry) {
                            return ExamCard(
                              exam: entry.value,
                              index: entry.key,
                              institutionId: widget.institutionId,
                              // isPast: true,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

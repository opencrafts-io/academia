import 'package:academia/features/exam_timetable/domain/entity/exam_timetable.dart';
import 'package:academia/features/exam_timetable/presentation/widgets/countdown_timer.dart';
import 'package:academia/features/exam_timetable/presentation/widgets/exam_card.dart';
import 'package:academia/features/exam_timetable/presentation/widgets/exam_section_header.dart';
import 'package:flutter/material.dart';

/// Renders the scrollable, pull-to-refresh exam list: a countdown to the
/// next exam, then the upcoming and past exams grouped under section
/// headers. Assumes [exams] is non-empty — callers show an empty state
/// themselves.
class ExamTimetableList extends StatelessWidget {
  final List<ExamTimetable> exams;
  final bool isRefreshing;
  final int institutionId;
  final Future<void> Function() onRefresh;

  const ExamTimetableList({
    super.key,
    required this.exams,
    required this.isRefreshing,
    required this.institutionId,
    required this.onRefresh,
  });

  List<ExamTimetable> _upcomingExams() {
    return exams.where((exam) => exam.isUpcoming).toList()
      ..sort((a, b) => a.datetimeStr.compareTo(b.datetimeStr));
  }

  List<ExamTimetable> _pastExams() {
    return exams.where((exam) => exam.isPast).toList()..sort(
      (a, b) => b.datetimeStr.compareTo(a.datetimeStr),
    ); // Most recent first
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final upcomingExams = _upcomingExams();
    final pastExams = _pastExams();
    final nextExam = upcomingExams.isNotEmpty ? upcomingExams.first : null;

    return RefreshIndicator(
      onRefresh: onRefresh,
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

          if (upcomingExams.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: ExamSectionHeader(
                title: 'Upcoming Exams',
                count: upcomingExams.length,
                titleColor: colorScheme.onSurface,
                badgeColor: colorScheme.tertiaryContainer,
                badgeTextColor: colorScheme.onTertiaryContainer,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: upcomingExams.asMap().entries.map((entry) {
                  return ExamCard(
                    exam: entry.value,
                    index: entry.key,
                    institutionId: institutionId,
                  );
                }).toList(),
              ),
            ),
          ],

          if (pastExams.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: ExamSectionHeader(
                title: 'Past Exams',
                count: pastExams.length,
                titleColor: colorScheme.onSurfaceVariant,
                badgeColor: colorScheme.surfaceContainerHighest,
                badgeTextColor: colorScheme.onSurfaceVariant,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: pastExams.asMap().entries.map((entry) {
                  return ExamCard(
                    exam: entry.value,
                    index: entry.key,
                    institutionId: institutionId,
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

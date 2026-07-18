import 'package:academia/features/exam_timetable/domain/entity/exam_timetable.dart';
import 'package:academia/features/exam_timetable/presentation/bloc/exam_timetable_bloc.dart';
import 'package:academia/features/exam_timetable/presentation/widgets/exam_info_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExamCard extends StatelessWidget {
  final ExamTimetable exam;
  final int index;
  final int institutionId;
  final bool isPast;

  const ExamCard({
    super.key,
    required this.exam,
    required this.index,
    required this.institutionId,
    this.isPast = false,
  });

  void _showDeleteDialog(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Remove Exam'),
        content: Text('Remove ${exam.courseCode} from your timetable?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<ExamTimetableBloc>().add(
                DeleteExamByCourseCode(
                  courseCode: exam.courseCode,
                  institutionId: institutionId,
                ),
              );
              Navigator.of(dialogContext).pop();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${exam.courseCode} removed from timetable'),
                  backgroundColor: colorScheme.primary,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text('Remove', style: TextStyle(color: colorScheme.error)),
          ),
        ],
      ),
    );
  }

  String _formatTime(String isoTime) {
    try {
      final dt = DateTime.parse(isoTime).toLocal();
      return DateFormat('h:mm a').format(dt);
    } catch (_) {
      return isoTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final cardColor = isPast
        ? colorScheme.secondaryContainer
        : colorScheme.tertiaryContainer;

    final textColor = isPast
        ? colorScheme.onSecondaryContainer
        : colorScheme.onTertiaryContainer;

    // Build right-column optional info list
    final rawData = exam.rawData;
    final campus = rawData?.campus ?? '';
    final invigilator = rawData?.invigilator ?? '';
    final courseName = rawData?.courseName ?? '';
    final group = rawData?.group ?? '';
    final hasRightColumn =
        campus.isNotEmpty ||
        exam.coordinator.isNotEmpty ||
        invigilator.isNotEmpty ||
        courseName.isNotEmpty ||
        group.isNotEmpty;

    return Dismissible(
      key: Key(exam.courseCode),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: colorScheme.error,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: Icon(Icons.delete_rounded, color: colorScheme.onError, size: 28),
      ),
      confirmDismiss: (direction) async {
        _showDeleteDialog(context);
        return false;
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course code, duration, and PAST badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      exam.courseCode.replaceAll('\n', ' · '),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      if (exam.hrs.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isPast
                                ? colorScheme.surfaceContainer
                                : textColor.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${exam.hrs}h',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: isPast
                                  ? colorScheme.onSurfaceVariant
                                  : textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      if (isPast) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'PAST',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExamInfoRow(
                          icon: Icons.calendar_today_rounded,
                          text: exam.displayDay,
                          textColor: textColor,
                        ),
                        const SizedBox(height: 6),
                        ExamInfoRow(
                          icon: Icons.access_time_rounded,
                          text:
                              '${_formatTime(exam.startTime)} – ${_formatTime(exam.endTime)}',
                          textColor: textColor,
                        ),
                        const SizedBox(height: 6),
                        ExamInfoRow(
                          icon: Icons.location_on_rounded,
                          text: exam.venue,
                          textColor: textColor,
                        ),
                      ],
                    ),
                  ),

                  // Right column (optional extra info)
                  if (hasRightColumn)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (campus.isNotEmpty)
                            ExamInfoRow(
                              icon: Icons.business_rounded,
                              text: campus,
                              textColor: textColor,
                            ),
                          if (campus.isNotEmpty &&
                              (exam.coordinator.isNotEmpty ||
                                  invigilator.isNotEmpty))
                            const SizedBox(height: 6),
                          if (exam.coordinator.isNotEmpty)
                            ExamInfoRow(
                              icon: Icons.person_rounded,
                              text: exam.coordinator,
                              textColor: textColor,
                            ),
                          if (exam.coordinator.isNotEmpty &&
                              invigilator.isNotEmpty)
                            const SizedBox(height: 6),
                          if (invigilator.isNotEmpty)
                            ExamInfoRow(
                              icon: Icons.supervisor_account_rounded,
                              text: invigilator,
                              textColor: textColor,
                            ),
                          if ((campus.isNotEmpty ||
                                  exam.coordinator.isNotEmpty ||
                                  invigilator.isNotEmpty) &&
                              (courseName.isNotEmpty || group.isNotEmpty))
                            const SizedBox(height: 6),
                          if (courseName.isNotEmpty)
                            ExamInfoRow(
                              icon: Icons.book_rounded,
                              text: courseName,
                              textColor: textColor,
                            ),
                          if (group.isNotEmpty) ...[
                            if (courseName.isNotEmpty)
                              const SizedBox(height: 6),
                            ExamInfoRow(
                              icon: Icons.group_rounded,
                              text: group,
                              textColor: textColor,
                            ),
                          ],
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

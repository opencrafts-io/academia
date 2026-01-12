import 'package:academia/features/exam_timetable/domain/entity/exam_timetable.dart';
import 'package:academia/features/exam_timetable/presentation/bloc/exam_timetable_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamCard extends StatelessWidget {
  final ExamTimetable exam;
  final int index;
  final String institutionId;
  final bool isPast;

  const ExamCard({
    super.key,
    required this.exam,
    required this.index,
    required this.institutionId,
    this.isPast = false,
  });

  // Color _getExamColor(BuildContext context, int index) {
  //   final colorScheme = Theme.of(context).colorScheme;
  //   final colors = [
  //     colorScheme.primaryContainer,
  //     colorScheme.secondaryContainer,
  //     colorScheme.tertiaryContainer,
  //     colorScheme.primary.withValues(alpha: 0.15),
  //     colorScheme.secondary.withValues(alpha: 0.15),
  //     colorScheme.tertiary.withValues(alpha: 0.15),
  //   ];
  //   return colors[index % colors.length];
  // }

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final cardColor = isPast
        ? colorScheme.secondaryContainer
        : colorScheme.tertiaryContainer;

    final textColor = isPast
        ? colorScheme.onSurfaceVariant
        : colorScheme.onSurface;

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
        child: Icon(Icons.delete_outline, color: colorScheme.onError, size: 28),
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
                      exam.courseCode,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isPast
                              ? colorScheme.surfaceContainer
                              : Colors.black.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${exam.hrs}h',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: textColor,
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
                        _CompactInfoRow(
                          icon: Icons.calendar_today,
                          text: exam.day,
                          textColor: textColor,
                          theme: theme,
                        ),
                        const SizedBox(height: 6),
                        _CompactInfoRow(
                          icon: Icons.access_time,
                          text: "${exam.startTime} - ${exam.endTime}",
                          textColor: textColor,
                          theme: theme,
                        ),
                        const SizedBox(height: 6),
                        _CompactInfoRow(
                          icon: Icons.location_on_outlined,
                          text: exam.venue,
                          textColor: textColor,
                          theme: theme,
                        ),
                      ],
                    ),
                  ),

                  // Right column (extra info)
                  if (exam.campus.isNotEmpty ||
                      exam.coordinator.isNotEmpty ||
                      exam.invigilator.isNotEmpty)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (exam.campus.isNotEmpty)
                            _CompactInfoRow(
                              icon: Icons.business_outlined,
                              text: exam.campus,
                              textColor: textColor,
                              theme: theme,
                            ),
                          if (exam.campus.isNotEmpty &&
                              (exam.coordinator.isNotEmpty ||
                                  exam.invigilator.isNotEmpty))
                            const SizedBox(height: 6),
                          if (exam.coordinator.isNotEmpty)
                            _CompactInfoRow(
                              icon: Icons.person_outline,
                              text: exam.coordinator,
                              textColor: textColor,
                              theme: theme,
                            ),
                          if (exam.coordinator.isNotEmpty &&
                              exam.invigilator.isNotEmpty)
                            const SizedBox(height: 6),
                          if (exam.invigilator.isNotEmpty)
                            _CompactInfoRow(
                              icon: Icons.supervisor_account_outlined,
                              text: exam.invigilator,
                              textColor: textColor,
                              theme: theme,
                            ),
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

class _CompactInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor;
  final ThemeData theme;

  const _CompactInfoRow({
    required this.icon,
    required this.text,
    required this.textColor,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: textColor.withValues(alpha: 0.7)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: textColor,
              fontSize: 12,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

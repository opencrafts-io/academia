import 'package:academia/features/exam_timetable/domain/entity/exam_timetable.dart';
import 'package:academia/features/exam_timetable/presentation/widgets/exam_info_row.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExamSearchResultCard extends StatelessWidget {
  final ExamTimetable exam;
  final bool isSelected;
  final VoidCallback onTap;

  const ExamSearchResultCard({
    super.key,
    required this.exam,
    required this.isSelected,
    required this.onTap,
  });

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
    final infoColor = colorScheme.onSurfaceVariant;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected
            ? Color.alphaBlend(
                colorScheme.primary.withValues(alpha: 0.08),
                colorScheme.surface,
              )
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.outline.withValues(alpha: 0.3),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exam.courseCode.replaceAll('\n', ' · '),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ExamInfoRow(
                      icon: Icons.calendar_today_rounded,
                      text: exam.displayDay,
                      textColor: infoColor,
                    ),
                    const SizedBox(height: 4),
                    ExamInfoRow(
                      icon: Icons.access_time_rounded,
                      text:
                          '${_formatTime(exam.startTime)} – ${_formatTime(exam.endTime)}',
                      textColor: infoColor,
                    ),
                    const SizedBox(height: 4),
                    ExamInfoRow(
                      icon: Icons.location_on_rounded,
                      text: exam.venue,
                      textColor: infoColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? colorScheme.primary : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: 0.4),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check_rounded,
                        size: 16,
                        color: colorScheme.onPrimary,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

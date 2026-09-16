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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      exam.courseCode.replaceAll('\n', ' · '),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (exam.hrs.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${exam.hrs}h',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? colorScheme.primary
                          : Colors.transparent,
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
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left column - core logistics
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExamInfoRow(
                          icon: Icons.calendar_today_rounded,
                          text: exam.displayDay,
                          textColor: infoColor,
                        ),
                        const SizedBox(height: 6),
                        ExamInfoRow(
                          icon: Icons.access_time_rounded,
                          text:
                              '${_formatTime(exam.startTime)} – ${_formatTime(exam.endTime)}',
                          textColor: infoColor,
                        ),
                        const SizedBox(height: 6),
                        ExamInfoRow(
                          icon: Icons.location_on_rounded,
                          text: exam.venue,
                          textColor: infoColor,
                        ),
                      ],
                    ),
                  ),

                  // Right column - optional extra info
                  if (hasRightColumn)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (campus.isNotEmpty)
                            ExamInfoRow(
                              icon: Icons.business_rounded,
                              text: campus,
                              textColor: infoColor,
                            ),
                          if (campus.isNotEmpty &&
                              (exam.coordinator.isNotEmpty ||
                                  invigilator.isNotEmpty))
                            const SizedBox(height: 6),
                          if (exam.coordinator.isNotEmpty)
                            ExamInfoRow(
                              icon: Icons.person_rounded,
                              text: exam.coordinator,
                              textColor: infoColor,
                            ),
                          if (exam.coordinator.isNotEmpty &&
                              invigilator.isNotEmpty)
                            const SizedBox(height: 6),
                          if (invigilator.isNotEmpty)
                            ExamInfoRow(
                              icon: Icons.supervisor_account_rounded,
                              text: invigilator,
                              textColor: infoColor,
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
                              textColor: infoColor,
                            ),
                          if (group.isNotEmpty) ...[
                            if (courseName.isNotEmpty)
                              const SizedBox(height: 6),
                            ExamInfoRow(
                              icon: Icons.group_rounded,
                              text: group,
                              textColor: infoColor,
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

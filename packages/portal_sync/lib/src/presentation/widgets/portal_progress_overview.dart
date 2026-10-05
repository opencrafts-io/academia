import 'package:flutter/material.dart';

/// Shows only the two kinds of academic information supported by this release.
class PortalProgressOverview extends StatelessWidget {
  const PortalProgressOverview({
    required this.coursesCount,
    required this.meetingsCount,
    this.fromCache = false,
    super.key,
  });

  final int coursesCount;
  final int meetingsCount;
  final bool fromCache;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final hasCourses = coursesCount > 0;
    final hasMeetings = meetingsCount > 0;

    return Card(
      color: colors.surfaceContainerLow,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'What we’ve found',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (fromCache)
                  Tooltip(
                    message: 'This page pattern is recognized, so no new AI request was needed.',
                    child: Chip(
                      avatar: const Icon(
                        Icons.check_circle_outline_rounded,
                        size: 18,
                      ),
                      label: const Text('Known page'),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            _ProgressRow(
              icon: Icons.menu_book_rounded,
              title: 'Courses',
              detail: hasCourses
                  ? '$coursesCount ${coursesCount == 1 ? 'course' : 'courses'} found'
                  : 'Open your course list to find your classes',
              complete: hasCourses,
            ),
            const SizedBox(height: 12),
            _ProgressRow(
              icon: Icons.calendar_month_rounded,
              title: 'Class times',
              detail: hasMeetings
                  ? '$meetingsCount ${meetingsCount == 1 ? 'class time' : 'class times'} found'
                  : 'Open your timetable to find meeting times',
              complete: hasMeetings,
            ),
            const SizedBox(height: 12),
            Text(
              'You can save what’s ready and come back for anything missing.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow({
    required this.icon,
    required this.title,
    required this.detail,
    required this.complete,
  });

  final IconData icon;
  final String title;
  final String detail;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Semantics(
      container: true,
      label: '$title. $detail.',
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: complete
                  ? colors.secondaryContainer
                  : colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              icon,
              color: complete
                  ? colors.onSecondaryContainer
                  : colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  detail,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            complete ? Icons.check_circle_rounded : Icons.more_horiz_rounded,
            color: complete ? colors.primary : colors.outline,
            semanticLabel: complete ? 'Found' : 'Not found yet',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../domain/entities/portal_draft.dart';

/// Human readable preview shown before any captured information is saved.
class PortalImportReview extends StatelessWidget {
  const PortalImportReview({
    required this.draft,
    required this.onSave,
    required this.onDiscard,
    this.isBusy = false,
    super.key,
  });

  final PortalDraft draft;
  final VoidCallback onSave;
  final VoidCallback onDiscard;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Card(
      color: colors.surfaceContainerLow,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Review before saving',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Check the course names and class times. You can discard this preview at any time.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            if (draft.meetings.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'This preview uses weekly days and the clock times listed by your school portal. Special dates and other recurrence patterns are skipped, and times are not converted between time zones. Check each day and time before saving.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 16),
            if (draft.courses.isNotEmpty) ...[
              _SectionHeading(
                icon: Icons.menu_book_rounded,
                title: 'Courses',
                count: draft.courses.length,
              ),
              const SizedBox(height: 8),
              for (final course in draft.courses)
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  leading: CircleAvatar(
                    backgroundColor: colors.primaryContainer,
                    foregroundColor: colors.onPrimaryContainer,
                    child: const Icon(Icons.bookmark_outline_rounded),
                  ),
                  title: Text(course.title),
                  subtitle: Text(
                    [
                      course.code,
                      if (course.section?.trim().isNotEmpty ?? false)
                        'Section ${course.section}',
                      if (course.term?.trim().isNotEmpty ?? false) course.term!,
                      if (course.lecturer?.trim().isNotEmpty ?? false)
                        course.lecturer!,
                    ].join(' · '),
                  ),
                  isThreeLine: (course.lecturer?.trim().isNotEmpty ?? false),
                ),
            ],
            if (draft.meetings.isNotEmpty) ...[
              const SizedBox(height: 12),
              _SectionHeading(
                icon: Icons.calendar_month_rounded,
                title: 'Class times',
                count: draft.meetings.length,
              ),
              const SizedBox(height: 8),
              for (final meeting in draft.meetings)
                _MeetingReviewTile(meeting: meeting, draft: draft),
            ],
            if (draft.meetings.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'No class times found yet. You can save these courses and add times later.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final buttons = [
                  OutlinedButton.icon(
                    onPressed: isBusy ? null : onDiscard,
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: const Text('Discard'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 52),
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: isBusy ? null : onSave,
                    icon: isBusy
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.check_rounded),
                    label: Text(
                      isBusy ? 'Saving…' : 'Save reviewed information',
                    ),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 52),
                    ),
                  ),
                ];
                if (constraints.maxWidth < 440) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buttons[1],
                      const SizedBox(height: 8),
                      buttons[0],
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: buttons[0]),
                    const SizedBox(width: 12),
                    Expanded(flex: 2, child: buttons[1]),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.icon,
    required this.title,
    required this.count,
  });
  final IconData icon;
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(child: Text(title, style: theme.textTheme.titleMedium)),
        Text(
          '$count',
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _MeetingReviewTile extends StatelessWidget {
  const _MeetingReviewTile({required this.meeting, required this.draft});
  final PortalMeetingDraft meeting;
  final PortalDraft draft;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final course = draft.courses
        .where((item) => item.sourceId == meeting.courseSourceId)
        .firstOrNull;
    final details = [
      '${meeting.day} · ${meeting.startTime}–${meeting.endTime}',
      if (meeting.venue?.trim().isNotEmpty ?? false) meeting.venue!,
    ].join(' · ');
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.tertiaryContainer,
        foregroundColor: theme.colorScheme.onTertiaryContainer,
        child: const Icon(Icons.schedule_rounded),
      ),
      title: Text(course?.title ?? 'Class time'),
      subtitle: Text(details),
    );
  }
}

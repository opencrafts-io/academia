import 'package:academia/core/core.dart';
import 'package:academia/features/course/course.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import 'package:rrule/rrule.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course, this.onTap});

  final CourseEntity course;
  final VoidCallback? onTap;

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => ConfirmDeleteDialog(
        title: 'Delete Course?',
        message:
            'This will delete "${course.courseName}" and all associated '
            'schedule entries. This action cannot be undone.',
        onConfirm: () {
          context.read<CourseCubit>().removeCourse(course.id!);
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('${course.courseName} deleted'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () => context
                      .read<CourseCubit>()
                      .addOrUpdateCourse(course.copyWith(isDeleted: false)),
                ),
              ),
            );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final avatarColor = course.color ?? colorScheme.primaryContainer;
    final onAvatarColor =
        ThemeData.estimateBrightnessForColor(avatarColor) == Brightness.dark
        ? Colors.white
        : Colors.black87;

    return Dismissible(
      key: Key(course.id ?? ''),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        _confirmDelete(context);
        return false;
      },
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colorScheme.errorContainer,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: Icon(
          Icons.delete_outline_rounded,
          color: colorScheme.onErrorContainer,
        ),
      ),
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        color: colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          onTap: onTap,
          child: ExpansionTile(
            shape: const RoundedRectangleBorder(side: BorderSide.none),
            collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
            leading: CircleAvatar(
              backgroundColor: avatarColor,
              child: Icon(Icons.book_rounded, color: onAvatarColor),
            ),
            title: Text(
              course.courseName,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              '${course.courseCode} • ${course.instructor}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            childrenPadding: const EdgeInsets.all(12),
            children: [
              BlocBuilder<TimetableEntryBloc, TimetableEntryState>(
                builder: (context, state) {
                  if (state is TimetableEntriesLoaded) {
                    final entries = state.entries
                        .where((entry) => entry.courseId == course.id)
                        .toList();

                    if (entries.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.event_busy_rounded,
                              size: 16,
                              color: colorScheme.outline,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "No scheduled sessions",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Column(
                      children: entries
                          .map((e) => _TimetableEntryCard(entry: e))
                          .toList(),
                    );
                  }

                  if (state is TimetableEntryError) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 18,
                            color: colorScheme.onErrorContainer,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              state.message,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onErrorContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: LoadingIndicatorM3E()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimetableEntryCard extends StatelessWidget {
  const _TimetableEntryCard({required this.entry});

  final TimetableEntryEntity entry;

  String _formatRecurrence(String? rruleStr) {
    if (rruleStr == null || rruleStr.isEmpty) return 'Single Session';

    try {
      // If it's just a frequency keyword (e.g., "WEEKLY"), convert it to a valid RRULE string
      String normalized = rruleStr.contains('=') ? rruleStr : 'FREQ=$rruleStr';
      final rrule = RecurrenceRule.fromString(normalized);

      if (rrule.byWeekDays.isEmpty) {
        return rrule.frequency
            .toString()
            .split('.')
            .last
            .toLowerCase()
            .capitalize();
      }

      final days = rrule.byWeekDays
          .map((day) {
            final names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
            return names[day.day - 1];
          })
          .join(', ');

      return 'Every $days';
    } catch (e) {
      return rruleStr.toLowerCase().capitalize();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displaySchedule = _formatRecurrence(entry.rrule);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(top: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                // Highlight the frequency with a Primary Container style
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.repeat_rounded,
                        size: 14,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        displaySchedule,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 12),
                // Displaying Location in the top right for balance
                _MiniTag(
                  icon: Icons.location_on_rounded,
                  text: entry.location ?? 'TBA',
                ),
                SizedBox(width: 8),
                _MiniTag(
                  icon: Icons.timer_rounded,
                  text: '${entry.durationMinutes} mins',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.apartment_rounded,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  '${entry.building} • Room ${entry.room}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.timer_rounded,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  'From ${DateFormat('jmv').format(entry.startDate)} '
                  '• To  ${DateFormat('jmv').format(entry.startDate.add(Duration(minutes: entry.durationMinutes)))}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniTag extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MiniTag({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Theme.of(context).colorScheme.outline),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ],
    );
  }
}

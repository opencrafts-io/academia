import 'package:courses/src/domain/entities/course_entity.dart';
import 'package:courses/src/domain/entities/schedule_entry_entity.dart';
import 'package:courses/src/presentation/bloc/course_cubit.dart';
import 'package:courses/src/presentation/screens/add_edit_schedule_entry_sheet.dart';
import 'package:courses/src/presentation/screens/course_color_picker.dart';
import 'package:courses/src/presentation/screens/sync_status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseScheduleEntriesSection extends StatelessWidget {
  const CourseScheduleEntriesSection({
    super.key,
    required this.course,
    required this.entries,
  });

  final CourseEntity course;
  final List<ScheduleEntryEntity> entries;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CourseCubit>().state;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Schedule entries',
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: () => _edit(context),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Add'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (state.isScheduleLoading && entries.isEmpty)
                const LinearProgressIndicator(),
              if (state.error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    state.error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              if (entries.isEmpty && !state.isScheduleLoading)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'No schedule entries yet.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              for (final entry in entries) _entryTile(context, entry),
            ],
          ),
        ),
      ),
    );
  }

  Widget _entryTile(BuildContext context, ScheduleEntryEntity entry) {
    final theme = Theme.of(context);
    final accent = colorFromHex(
      entry.color ?? course.color,
      theme.colorScheme.primary,
    );
    final title = entry.label?.trim().isNotEmpty == true
        ? entry.label!
        : 'Class';
    final location = [
      entry.venue,
      entry.campus,
      entry.section,
    ].whereType<String>().where((value) => value.isNotEmpty).join(' · ');
    return Card(
      margin: const EdgeInsets.only(top: 8),
      child: ListTile(
        onTap: () => _edit(context, entry),
        leading: Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        title: Text('$title · ${_title(entry.dayOfWeek)}'),
        subtitle: Text(
          [
            '${entry.startTime.substring(0, 5)}–${entry.endTime.substring(0, 5)}',
            if (location.isNotEmpty) location,
            if (!entry.isRecurring && entry.specificDate != null)
              'One time · ${MaterialLocalizations.of(context).formatMediumDate(entry.specificDate!)}',
          ].join(' · '),
          style: theme.textTheme.bodyMedium,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SyncStatusIndicator(
              status: entry.syncStatus,
              recordLabel: 'Schedule entry',
              error: entry.lastSyncError,
              onEdit: () => _edit(context, entry),
            ),
            PopupMenuButton<String>(
              tooltip: 'Schedule entry actions',
              onSelected: (value) {
                if (value == 'edit') _edit(context, entry);
                if (value == 'delete') _delete(context, entry);
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'edit', child: Text('Edit')),
                PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _edit(BuildContext context, [ScheduleEntryEntity? entry]) async {
    await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => AddEditScheduleEntrySheet(course: course, entry: entry),
    );
  }

  Future<void> _delete(BuildContext context, ScheduleEntryEntity entry) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete schedule entry?'),
        content: const Text(
          'This removes the class from this course timetable.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await context.read<CourseCubit>().deleteScheduleEntry(entry.id);
    }
  }

  static String _title(String day) =>
      '${day[0].toUpperCase()}${day.substring(1)}';
}

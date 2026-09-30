import 'package:courses/src/domain/entities/schedule_entry_entity.dart';
import 'package:courses/src/presentation/bloc/course_cubit.dart';
import 'package:courses/src/presentation/routes/course_routes.dart';
import 'package:courses/src/presentation/screens/course_color_picker.dart';
import 'package:courses/src/presentation/screens/sync_status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeeklyTimetablePage extends StatefulWidget {
  const WeeklyTimetablePage({super.key});

  @override
  State<WeeklyTimetablePage> createState() => _WeeklyTimetablePageState();
}

class _WeeklyTimetablePageState extends State<WeeklyTimetablePage> {
  static const _days = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().loadWeeklySchedule();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CourseCubit>().state;
    final entriesByDay = <String, List<ScheduleEntryEntity>>{
      for (final day in _days) day: <ScheduleEntryEntity>[],
    };
    for (final entry in state.weeklySchedule) {
      entriesByDay.putIfAbsent(entry.dayOfWeek, () => []).add(entry);
    }
    for (final entries in entriesByDay.values) {
      entries.sort((a, b) => a.startTime.compareTo(b.startTime));
    }
    final hasEntries = entriesByDay.values.any((entries) => entries.isNotEmpty);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly timetable'),
        actions: [
          IconButton(
            tooltip: 'Refresh timetable',
            onPressed: () => context.read<CourseCubit>().loadWeeklySchedule(),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () => context.read<CourseCubit>().loadWeeklySchedule(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            if (state.isScheduleLoading && !hasEntries)
              const LinearProgressIndicator(),
            if (state.error != null)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  state.error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            if (!hasEntries && !state.isScheduleLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 80),
                child: Center(child: Text('No classes in your timetable yet.')),
              ),
            for (final day in _days) ...[
              if (entriesByDay[day]!.isNotEmpty)
                _daySection(context, day, entriesByDay[day]!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _daySection(
    BuildContext context,
    String day,
    List<ScheduleEntryEntity> entries,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 20, 4, 4),
          child: Text(
            _title(day),
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        for (final entry in entries) _entryTile(context, entry),
      ],
    );
  }

  Widget _entryTile(BuildContext context, ScheduleEntryEntity entry) {
    final theme = Theme.of(context);
    final accent = colorFromHex(
      entry.color ?? entry.courseColor,
      theme.colorScheme.primary,
    );
    final location = [
      entry.venue,
      entry.campus,
    ].whereType<String>().where((value) => value.isNotEmpty).join(' · ');
    return Card(
      margin: const EdgeInsets.only(top: 6),
      child: ListTile(
        onTap: () =>
            CourseDetailRoute(courseId: entry.studentCourseId).push(context),
        leading: Container(
          width: 4,
          height: 42,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        title: Text(
          entry.label?.trim().isNotEmpty == true
              ? entry.label!
              : entry.courseTitle ?? 'Class',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          [
            '${entry.startTime.substring(0, 5)}–${entry.endTime.substring(0, 5)}',
            if (entry.courseCode != null) entry.courseCode!,
            if (location.isNotEmpty) location,
          ].join(' · '),
        ),
        trailing: SyncStatusIndicator(
          status: entry.syncStatus,
          recordLabel: 'Schedule entry',
          error: entry.lastSyncError,
          onEdit: () =>
              CourseDetailRoute(courseId: entry.studentCourseId).push(context),
        ),
      ),
    );
  }

  static String _title(String day) =>
      '${day[0].toUpperCase()}${day.substring(1)}';
}

import 'package:academia/features/course/course.dart';
import 'package:academia/features/timetable/timetable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CourseScheduleSection extends StatelessWidget {
  final CourseEntity course;
  final VoidCallback onAddEntry;
  final ValueChanged<TimetableEntryEntity> onEditEntry;
  final ValueChanged<TimetableEntryEntity> onDeleteEntry;

  const CourseScheduleSection({
    super.key,
    required this.course,
    required this.onAddEntry,
    required this.onEditEntry,
    required this.onDeleteEntry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 20,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Class Schedule',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                FilledButton.tonalIcon(
                  onPressed: onAddEntry,
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Add'),
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<TimetableEntryBloc, TimetableEntryState>(
          builder: (context, state) {
            if (state is TimetableEntryLoading) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: LoadingIndicatorM3E(),
                  ),
                ),
              );
            }

            if (state is TimetableEntriesLoaded) {
              if (state.entries.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 64,
                          color: colorScheme.outline,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No schedule entries yet',
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: onAddEntry,
                          icon: const Icon(Icons.add_rounded),
                          label: const Text('Add First Entry'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final entry = state.entries[index];
                    return TimetableEntryCard(
                      entry: entry,
                      course: course,
                      onTap: () => onEditEntry(entry),
                      onDelete: () => onDeleteEntry(entry),
                    );
                  }, childCount: state.entries.length),
                ),
              );
            }

            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
      ],
    );
  }
}

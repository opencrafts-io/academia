import 'package:academia/config/config.dart';
import 'package:academia/features/course/course.dart';
import 'package:academia/features/features.dart';
import 'package:agenda/agenda.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:todos/todos.dart' as todos;

class AgendaDayGridWidget extends StatelessWidget {
  const AgendaDayGridWidget({
    super.key,
    required this.day,
    required this.events,
    required this.classes,
    required this.isAgendaLoading,
    required this.onCreateEvent,
  });

  final DateTime day;
  final List<AgendaEvent> events;
  final List<TimetableEntryEntity> classes;
  final bool isAgendaLoading;
  final VoidCallback onCreateEvent;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<todos.TodoItemCubit, todos.TodoItemState>(
      builder: (context, todoState) {
        final dueTodos =
            todoState.currentItems
                .where(
                  (item) =>
                      item.due != null &&
                      DateUtils.isSameDay(item.due!.toLocal(), day) &&
                      !item.hidden &&
                      !item.isPendingDeletion,
                )
                .toList()
              ..sort((a, b) => a.due!.compareTo(b.due!));

        final agendaItems = <_AgendaGridItem>[
          for (final event in events)
            if (event.startTime != null)
              _AgendaGridItem(start: event.startTime!.toLocal(), value: event),
          for (final entry in classes)
            _AgendaGridItem(
              start: DateTime(
                day.year,
                day.month,
                day.day,
                entry.startDate.hour,
                entry.startDate.minute,
              ),
              value: entry,
            ),
          for (final todo in dueTodos)
            _AgendaGridItem(start: todo.due!.toLocal(), value: todo),
        ]..sort((a, b) => a.start.compareTo(b.start));

        final todoLoading = todoState.maybeWhen(
          initial: () => true,
          loading: (_) => true,
          orElse: () => false,
        );
        final todoHasMore = todoState.maybeWhen(
          success: (_, nextUrl, _, _) => nextUrl != null,
          orElse: () => false,
        );
        final todoIsPaginating = todoState.maybeWhen(
          success: (_, _, paginating, _) => paginating,
          orElse: () => false,
        );
        final todoError = todoState.maybeWhen(
          failure: (failure, _) => failure.message,
          orElse: () => null,
        );

        if (agendaItems.isEmpty && (isAgendaLoading || todoLoading)) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 36),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (todoError != null)
              _TodoErrorBanner(
                message: todoError,
                onRetry: context.read<todos.TodoItemCubit>().loadItems,
              ),
            if (agendaItems.isEmpty)
              _EmptyDayCard(onCreateEvent: onCreateEvent)
            else
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth >= 680 ? 3 : 2;
                  final tileWidth =
                      (constraints.maxWidth - (crossAxisCount - 1) * 12) /
                      crossAxisCount;
                  final childAspectRatio = crossAxisCount == 3
                      ? 2.0
                      : tileWidth < 150
                      ? 1.35
                      : tileWidth < 165
                      ? 1.62
                      : 1.8;
                  return GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: agendaItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 8,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (context, index) =>
                        _AgendaGridCard(item: agendaItems[index]),
                  );
                },
              ),
            if (todoError != null && dueTodos.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                todoError,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ],
            if (todoHasMore) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.center,
                child: TextButton.icon(
                  onPressed: todoIsPaginating
                      ? null
                      : context.read<todos.TodoItemCubit>().loadMore,
                  icon: todoIsPaginating
                      ? const SizedBox.square(
                          dimension: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.expand_more_rounded),
                  label: Text(
                    todoIsPaginating ? 'Loading to-dos' : 'Load more to-dos',
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _AgendaGridItem {
  const _AgendaGridItem({required this.start, required this.value});

  final DateTime start;
  final Object value;
}

class _AgendaGridCard extends StatelessWidget {
  const _AgendaGridCard({required this.item});

  final _AgendaGridItem item;

  @override
  Widget build(BuildContext context) {
    return switch (item.value) {
      AgendaEvent event => _EventGridCard(event: event),
      TimetableEntryEntity entry => BlocBuilder<CourseCubit, CourseState>(
        builder: (context, state) {
          final course = state.maybeWhen(
            success: (courses) {
              for (final course in courses) {
                if (course.id == entry.courseId) return course;
              }
              return null;
            },
            orElse: () => null,
          );
          return _CourseGridCard(
            entry: entry,
            start: item.start,
            courseName: course?.courseName,
          );
        },
      ),
      todos.TodoItemEntity todo => _TodoGridCard(todo: todo),
      _ => const SizedBox.shrink(),
    };
  }
}

class _EventGridCard extends StatelessWidget {
  const _EventGridCard({required this.event});

  final AgendaEvent event;

  @override
  Widget build(BuildContext context) {
    final start = event.startTime!.toLocal();
    final end = event.endTime?.toLocal();
    final time = event.allDay || end == null
        ? (event.allDay ? 'All day' : DateFormat.jm().format(start))
        : '${DateFormat.jm().format(start)} – ${DateFormat.jm().format(end)}';
    final location = event.location?.trim();

    return _AgendaTile(
      label: 'Event',
      title: event.summary?.trim().isNotEmpty == true
          ? event.summary!
          : 'Untitled event',
      detail: location?.isNotEmpty == true ? '$time · $location' : time,
      icon: Icons.event_available_rounded,
      color: Theme.of(context).colorScheme.primaryContainer,
      foreground: Theme.of(context).colorScheme.onPrimaryContainer,
      onTap: () => AgendaItemViewRoute(id: event.id).push(context),
    );
  }
}

class _CourseGridCard extends StatelessWidget {
  const _CourseGridCard({
    required this.entry,
    required this.start,
    required this.courseName,
  });

  final TimetableEntryEntity entry;
  final DateTime start;
  final String? courseName;

  @override
  Widget build(BuildContext context) {
    final end = start.add(Duration(minutes: entry.durationMinutes));
    final location = [
      if (entry.building?.trim().isNotEmpty == true) entry.building!.trim(),
      if (entry.room?.trim().isNotEmpty == true) 'Room ${entry.room!.trim()}',
    ].join(' · ');

    return _AgendaTile(
      label: 'Course',
      title: courseName ?? 'Class session',
      detail: [
        '${DateFormat.jm().format(start)} – ${DateFormat.jm().format(end)}',
        if (location.isNotEmpty) location,
      ].join(' · '),
      icon: Symbols.menu_book_rounded,
      color: Theme.of(context).colorScheme.secondaryContainer,
      foreground: Theme.of(context).colorScheme.onSecondaryContainer,
      onTap: () => ViewCourseRoute(courseId: entry.courseId).push(context),
    );
  }
}

class _TodoGridCard extends StatelessWidget {
  const _TodoGridCard({required this.todo});

  final todos.TodoItemEntity todo;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final completed = todo.status == todos.TodoStatus.completed;

    return _AgendaTile(
      label: 'To-do',
      title: todo.title,
      detail: 'Due ${DateFormat.jm().format(todo.due!.toLocal())}',
      icon: Icons.check_circle_outline_rounded,
      color: colors.tertiaryContainer,
      foreground: colors.onTertiaryContainer,
      completed: completed,
      trailing: Checkbox.adaptive(
        value: completed,
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onChanged: (_) {
          HapticFeedback.selectionClick();
          final cubit = context.read<todos.TodoItemCubit>();
          if (completed) {
            cubit.reopenItem(todo.localId);
          } else {
            cubit.completeItem(todo.localId);
          }
        },
      ),
      onTap: () =>
          todos.UpdateTodoItemRoute(todoLocalID: todo.localId).push(context),
    );
  }
}

class _AgendaTile extends StatelessWidget {
  const _AgendaTile({
    required this.label,
    required this.title,
    required this.detail,
    required this.icon,
    required this.color,
    required this.foreground,
    required this.onTap,
    this.completed = false,
    this.trailing,
  });

  final String label;
  final String title;
  final String detail;
  final IconData icon;
  final Color color;
  final Color foreground;
  final VoidCallback onTap;
  final bool completed;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: color,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 17, color: foreground),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: foreground,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ?trailing,
                ],
              ),
              const SizedBox(height: 4),
              Text(
                title,
                maxLines: trailing == null ? 2 : 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w700,
                  decoration: completed ? TextDecoration.lineThrough : null,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                detail,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: foreground.withAlpha(210),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyDayCard extends StatelessWidget {
  const _EmptyDayCard({required this.onCreateEvent});

  final VoidCallback onCreateEvent;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    return Material(
      color: colors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              'assets/icons/calendar.png',
              package: 'agenda',
              width: 64,
              height: 64,
            ),
            const SizedBox(height: 8),
            Text(
              'A little space in your day',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Nothing scheduled yet. Add a plan when you are ready.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: onCreateEvent,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add event'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TodoErrorBanner extends StatelessWidget {
  const _TodoErrorBanner({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: colors.errorContainer,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
          child: Row(
            children: [
              Icon(Icons.cloud_off_rounded, color: colors.onErrorContainer),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: colors.onErrorContainer),
                ),
              ),
              IconButton(
                tooltip: 'Retry to-dos',
                onPressed: onRetry,
                icon: Icon(
                  Icons.refresh_rounded,
                  color: colors.onErrorContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

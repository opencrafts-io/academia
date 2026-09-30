import 'package:academia/constants/responsive_break_points.dart';
import 'package:agenda/agenda.dart';
import 'package:courses/courses.dart' as courses;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todos/todos.dart' as todos;

import 'schedule_entry_occurrence.dart';

class CalendarHomeWidget extends StatelessWidget {
  const CalendarHomeWidget({
    super.key,
    required this.selectedDay,
    this.focusedDay,
    this.calendarFormat = CalendarFormat.week,
    this.onDayChanged,
    this.onVisibleMonthChanged,
  });

  final DateTime selectedDay;
  final DateTime? focusedDay;
  final CalendarFormat calendarFormat;
  final ValueChanged<DateTime>? onDayChanged;
  final ValueChanged<DateTime>? onVisibleMonthChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final todoItems = context
        .select<todos.TodoItemCubit, List<todos.TodoItemEntity>>(
          (cubit) => cubit.state.currentItems
              .where(
                (item) =>
                    item.due != null && !item.hidden && !item.isPendingDeletion,
              )
              .toList(),
        );
    final classes = context
        .select<courses.CourseCubit, List<courses.ScheduleEntryEntity>>(
          (cubit) => cubit.state.weeklySchedule,
        );

    return BlocBuilder<AgendaCubit, AgendaState>(
      builder: (context, agendaState) {
        final events = agendaState.events;

        return Container(
          constraints: BoxConstraints(maxWidth: ResponsiveBreakPoints.mobile),
          child: TableCalendar<Object>(
            headerVisible: false,
            calendarFormat: calendarFormat,
            selectedDayPredicate: (day) =>
                DateUtils.isSameDay(day, selectedDay),
            focusedDay: focusedDay ?? selectedDay,
            firstDay: DateTime.now().subtract(const Duration(days: 365 * 2)),
            lastDay: DateTime.now().add(const Duration(days: 365 * 5)),
            onDaySelected: (day, _) {
              if (!DateUtils.isSameDay(day, selectedDay)) {
                HapticFeedback.selectionClick();
                onDayChanged?.call(day);
              }
            },
            onPageChanged: (day) => onVisibleMonthChanged?.call(day),
            eventLoader: (day) => [
              ...events.where(
                (event) =>
                    event.startTime != null &&
                    DateUtils.isSameDay(event.startTime!.toLocal(), day),
              ),
              ...classes.where((entry) => scheduleEntryOccursOnDay(entry, day)),
              ...todoItems.where(
                (item) => DateUtils.isSameDay(item.due!.toLocal(), day),
              ),
            ],
            calendarBuilders: CalendarBuilders<Object>(
              markerBuilder: (context, date, dayItems) {
                if (dayItems.isEmpty) return null;

                final hasEvents = dayItems.any((item) => item is AgendaEvent);
                final hasClasses = dayItems.any(
                  (item) => item is courses.ScheduleEntryEntity,
                );
                final hasTodos = dayItems.any(
                  (item) => item is todos.TodoItemEntity,
                );

                return Positioned(
                  bottom: 6,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (hasEvents)
                        _CalendarMarker(color: colorScheme.primary),
                      if (hasEvents && hasClasses) const SizedBox(width: 3),
                      if (hasClasses)
                        _CalendarMarker(color: colorScheme.secondary),
                      if (hasTodos && (hasEvents || hasClasses))
                        const SizedBox(width: 3),
                      if (hasTodos)
                        _CalendarMarker(color: colorScheme.tertiary),
                    ],
                  ),
                );
              },
              defaultBuilder: (context, day, _) {
                final hasItems =
                    events.any(
                      (event) =>
                          event.startTime != null &&
                          DateUtils.isSameDay(event.startTime!.toLocal(), day),
                    ) ||
                    classes.any(
                      (entry) => scheduleEntryOccursOnDay(entry, day),
                    ) ||
                    todoItems.any(
                      (item) => DateUtils.isSameDay(item.due!.toLocal(), day),
                    );
                return _CalendarDay(
                  day: day,
                  backgroundColor: hasItems
                      ? colorScheme.primaryContainer
                      : colorScheme.surface,
                  foregroundColor: hasItems
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurface,
                );
              },
              selectedBuilder: (context, day, _) => _CalendarDay(
                day: day,
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                borderColor: colorScheme.onPrimary.withAlpha(96),
              ),
              todayBuilder: (context, day, _) => _CalendarDay(
                day: day,
                backgroundColor: colorScheme.secondaryContainer,
                foregroundColor: colorScheme.onSecondaryContainer,
                borderColor: colorScheme.outlineVariant,
                emphasize: true,
              ),
              outsideBuilder: (context, day, _) => Opacity(
                opacity: 0.45,
                child: _CalendarDay(
                  day: day,
                  backgroundColor: colorScheme.surface,
                  foregroundColor: colorScheme.onSurface,
                ),
              ),
            ),
            calendarStyle: const CalendarStyle(isTodayHighlighted: false),
          ),
        );
      },
    );
  }
}

class _CalendarMarker extends StatelessWidget {
  const _CalendarMarker({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: const SizedBox.square(dimension: 5),
    );
  }
}

class _CalendarDay extends StatelessWidget {
  const _CalendarDay({
    required this.day,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
    this.emphasize = false,
  });

  final DateTime day;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    return AnimatedContainer(
      duration: reduceMotion
          ? Duration.zero
          : const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: borderColor == null ? null : Border.all(color: borderColor!),
      ),
      child: Center(
        child: Text(
          '${day.day}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: foregroundColor,
            fontWeight: emphasize ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

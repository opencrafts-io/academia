import 'dart:async';
import 'package:academia/constants/responsive_break_points.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarHomeWidget extends StatefulWidget {
  final DateTime selectedDay;
  final Function(
    DateTime selectedDay,
    List<AgendaEvent> events,
    List<TimetableEntryEntity> classes,
  )?
  onDayChanged;

  const CalendarHomeWidget({
    super.key,
    required this.selectedDay,
    this.onDayChanged,
  });

  @override
  State<CalendarHomeWidget> createState() => _CalendarHomeWidgetState();
}

class _CalendarHomeWidgetState extends State<CalendarHomeWidget> {
  final CalendarFormat _calendarFormat = CalendarFormat.week;
  List<AgendaEvent> _allEvents = [];
  List<TimetableEntryEntity> _allTimetableEntries = [];
  StreamSubscription<List<AgendaEvent>>? _eventsSubscription;

  @override
  void initState() {
    super.initState();
    // Fetch cached agenda events when widget initializes
    context.read<AgendaEventBloc>().add(FetchCachedAgendaEventsEvent());
    // Ensure we are watching timetable entries
    context.read<TimetableEntryBloc>().add(
      const WatchAllTimetableEntriesEvent(),
    );
  }

  @override
  void dispose() {
    _eventsSubscription?.cancel();
    super.dispose();
  }

  bool _occursOnDay(TimetableEntryEntity entry, DateTime day) {
    final rrule = entry.rrule?.trim() ?? '';

    // If no RRULE, it's a one-time event on its startDate
    if (rrule.isEmpty) {
      return isSameDay(entry.startDate, day);
    }

    // Map Dart weekday (1=Monday...7=Sunday) to RRULE day codes
    final weekdayMap = {
      1: 'MO',
      2: 'TU',
      3: 'WE',
      4: 'TH',
      5: 'FR',
      6: 'SA',
      7: 'SU',
    };
    final dayCode = weekdayMap[day.weekday]!;

    // Extract BYDAY value using regex to avoid false positives
    final bydayRegex = RegExp(r'BYDAY=([^;]+)');
    final match = bydayRegex.firstMatch(rrule);

    if (match == null) {
      // If it's DAILY and we're after the start date
      if (rrule.contains('FREQ=DAILY')) {
        return day.isAfter(entry.startDate) || isSameDay(entry.startDate, day);
      }
      return false;
    }

    final bydayValue = match.group(1) ?? '';
    final days = bydayValue.split(',').map((d) => d.trim()).toList();

    return days.contains(dayCode);
  }

  bool _hasEventsOnDay(DateTime day) {
    final hasAgendaEvent = _allEvents.any((event) {
      if (event.startTime == null) return false;
      return isSameDay(event.startTime!, day);
    });

    if (hasAgendaEvent) return true;

    return _allTimetableEntries.any((entry) => _occursOnDay(entry, day));
  }

  void _notifyDayChanged(DateTime day) {
    if (widget.onDayChanged != null) {
      final dayEvents = _allEvents.where((event) {
        if (event.startTime == null) return false;
        return isSameDay(event.startTime!, day);
      }).toList();

      final dayClasses = _allTimetableEntries.where((entry) {
        return _occursOnDay(entry, day);
      }).toList();

      widget.onDayChanged!(day, dayEvents, dayClasses);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MultiBlocListener(
      listeners: [
        BlocListener<AgendaEventBloc, AgendaEventState>(
          listener: (context, state) {
            if (state is AgendaEventLoadedState) {
              _eventsSubscription?.cancel();
              _eventsSubscription = state.agendaEventsStream.listen((events) {
                if (mounted) {
                  setState(() {
                    _allEvents = events;
                  });
                  _notifyDayChanged(widget.selectedDay);
                }
              });
            }
          },
        ),
        BlocListener<TimetableEntryBloc, TimetableEntryState>(
          listener: (context, state) {
            if (state is TimetableEntriesLoaded) {
              setState(() {
                _allTimetableEntries = state.entries;
              });
              _notifyDayChanged(widget.selectedDay);
            }
          },
        ),
      ],
      child: Container(
        constraints: BoxConstraints(maxWidth: ResponsiveBreakPoints.mobile),
        child: TableCalendar(
          headerVisible: false,
          onDaySelected: (selectedDay, focusedDay) {
            if (context.mounted) {
              _notifyDayChanged(selectedDay);
            }
          },
          calendarFormat: _calendarFormat,
          eventLoader: (day) {
            final dayEvents = _allEvents.where((event) {
              if (event.startTime == null) return false;
              return isSameDay(event.startTime!, day);
            }).toList();

            final dayClasses = _allTimetableEntries.where((entry) {
              return _occursOnDay(entry, day);
            }).toList();

            return [...dayEvents, ...dayClasses];
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              if (events.isEmpty) {
                return null;
              }

              // Count different types
              final eventCount = events.whereType<AgendaEvent>().length;
              final classCount = events
                  .whereType<TimetableEntryEntity>()
                  .length;

              return Positioned(
                bottom: 6,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (classCount > 0)
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange,
                        ),
                      ),
                    if (eventCount > 0)
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.primary,
                        ),
                      ),
                  ],
                ),
              );
            },
            defaultBuilder: (context, day, focusedDay) {
              final hasEvents = _hasEventsOnDay(day);
              return _buildExpressiveDay(
                context,
                day,
                backgroundColor: hasEvents
                    ? colorScheme.primaryContainer
                    : colorScheme.surfaceContainerHigh,
                textStyle: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: hasEvents ? colorScheme.onPrimaryContainer : null,
                ),
              );
            },
            selectedBuilder: (context, day, focusedDay) {
              return _buildExpressiveDay(
                context,
                day,
                backgroundColor: colorScheme.primary,
                borderColor: colorScheme.onPrimary.withAlpha(
                  (0.5 * 255).round(),
                ),
                textStyle: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onPrimary,
                ),
              );
            },
            todayBuilder: (context, day, focusedDay) {
              final hasEvents = _hasEventsOnDay(day);
              return _buildExpressiveDay(
                context,
                day,
                backgroundColor: colorScheme.secondaryContainer,
                borderColor: hasEvents ? colorScheme.secondary : null,
                textStyle: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSecondaryContainer,
                ),
                isToday: true,
              );
            },
            outsideBuilder: (context, day, focusedDay) {
              return Opacity(
                opacity: 0.5,
                child: _buildExpressiveDay(
                  context,
                  day,
                  backgroundColor: colorScheme.surface,
                  textStyle: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          calendarStyle: const CalendarStyle(isTodayHighlighted: true),
          selectedDayPredicate: (date) => isSameDay(date, widget.selectedDay),
          focusedDay: widget.selectedDay,
          firstDay: DateTime.now().subtract(const Duration(days: 365 * 2)),
          lastDay: DateTime.now().add(const Duration(days: 365 * 5)),
        ),
      ),
    );
  }

  Widget _buildExpressiveDay(
    BuildContext context,
    DateTime day, {
    required Color backgroundColor,
    Color? borderColor,
    required TextStyle? textStyle,
    bool isToday = false,
  }) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: borderColor != null
            ? Border.all(color: borderColor, width: 2)
            : null,
        boxShadow: isToday
            ? [
                BoxShadow(
                  color: backgroundColor.withAlpha((255.0 * 0.3).round()),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Center(child: Text(day.day.toString(), style: textStyle)),
    );
  }
}

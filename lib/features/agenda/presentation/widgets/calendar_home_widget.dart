import 'dart:async';
import 'package:academia/config/router/router.dart';
import 'package:academia/constants/responsive_break_points.dart';
import 'package:academia/features/agenda/agenda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class CalendarHomeWidget extends StatefulWidget {
  const CalendarHomeWidget({super.key});

  @override
  State<CalendarHomeWidget> createState() => _CalendarHomeWidgetState();
}

class _CalendarHomeWidgetState extends State<CalendarHomeWidget> {
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  List<AgendaEvent> _events = [];
  StreamSubscription<List<AgendaEvent>>? _eventsSubscription;

  @override
  void initState() {
    super.initState();
    // Fetch cached agenda events when widget initializes
    context.read<AgendaEventBloc>().add(FetchCachedAgendaEventsEvent());
  }

  @override
  void dispose() {
    _eventsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgendaEventBloc, AgendaEventState>(
      listener: (context, state) {
        if (state is AgendaEventLoadedState) {
          // Cancel previous subscription if exists
          _eventsSubscription?.cancel();

          // Listen to the stream and update events
          _eventsSubscription = state.agendaEventsStream.listen((events) {
            if (mounted) {
              setState(() {
                _events = events;
              });
            }
          });
        }
      },
      builder: (context, state) {
        return Container(
          constraints: BoxConstraints(maxWidth: ResponsiveBreakPoints.mobile),
          child: TableCalendar(
            onDaySelected: (selectedDay, focusedDay) async {
              // Provide haptic feedback for day selection
              if (await Vibration.hasVibrator()) {
                Vibration.vibrate(preset: VibrationPreset.quickSuccessAlert);
              }

              if (context.mounted) {
                setState(() {
                  _selectedDay = selectedDay;
                });
                _showDayEventsBottomSheet(context, selectedDay);
              }
            },
            availableCalendarFormats: {
              CalendarFormat.twoWeeks: '2 weeks View',
              CalendarFormat.month: 'Month View',
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            eventLoader: (day) {
              // Return list of events for this day
              return _events
                  .where((event) {
                    if (event.startTime == null) return false;

                    // Normalize dates to compare only year, month, day
                    final eventDate = DateTime(
                      event.startTime!.year,
                      event.startTime!.month,
                      event.startTime!.day,
                    );

                    final dayDate = DateTime(day.year, day.month, day.day);

                    return eventDate.isAtSameMomentAs(dayDate);
                  })
                  .map((event) => event.summary ?? 'Event')
                  .toList();
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isEmpty) {
                  return null;
                }
                return Positioned(
                  top: 0,
                  right: 10,
                  child: Badge(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(events.length.toString()),
                  ),
                );
              },
            ),

            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              todayDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              selectedDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
              ),
              outsideDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
              ),
              selectedTextStyle:
                  Theme.of(context).textTheme.bodyMedium ??
                  const TextStyle(color: Colors.white),
            ),
            selectedDayPredicate: (date) => isSameDay(date, _selectedDay),
            focusedDay: DateTime.now(),
            firstDay: DateTime.now().subtract(
              const Duration(days: 365 * 2),
            ), // 2 years ago
            lastDay: DateTime.now().add(
              const Duration(days: 365 * 5),
            ), // 5 years from now
          ),
        );
      },
    );
  }

  void _showDayEventsBottomSheet(BuildContext context, DateTime selectedDay) {
    // Get events for the selected day
    final dayEvents = _events.where((event) {
      if (event.startTime == null) return false;

      final eventDate = DateTime(
        event.startTime!.year,
        event.startTime!.month,
        event.startTime!.day,
      );
      final selectedDate = DateTime(
        selectedDay.year,
        selectedDay.month,
        selectedDay.day,
      );

      return eventDate.isAtSameMomentAs(selectedDate);
    }).toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75, // 3/4 of screen
        minHeight:
            MediaQuery.of(context).size.height * 0.5, // Minimum 1/2 of screen
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.75,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Header with date and create button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Events for',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          DateFormat.yMMMMEEEEd().format(selectedDay),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: () async {
                      // Provide haptic feedback for create button
                      if (await Vibration.hasVibrator()) {
                        Vibration.vibrate(
                          preset: VibrationPreset.gentleReminder,
                        );
                      }

                      if (!context.mounted) return;

                      Navigator.of(context).pop();
                      CreateAgendaEventRoute().push(context);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Create'),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Events list or empty state
              Expanded(
                child: dayEvents.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              "assets/lotties/painting.json",
                              height: 250,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'You have no events for the day',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tap "Create" to add an agenda event',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        controller: scrollController,
                        itemCount: dayEvents.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final event = dayEvents[index];
                          return AgendaEventCard(
                            event: event,
                            onEdit: () async {
                              // Provide haptic feedback for edit action
                              if (await Vibration.hasVibrator()) {
                                Vibration.vibrate(
                                  preset: VibrationPreset.softPulse,
                                );
                              }

                              if (!context.mounted) return;

                              Navigator.of(context).pop();
                              AgendaItemViewRoute(id: event.id).push(context);
                            },
                            onDelete: () async {
                              if (await Vibration.hasVibrator()) {
                                Vibration.vibrate(
                                  preset: VibrationPreset.emergencyAlert,
                                );
                              }

                              if (!context.mounted) return;

                              // Show delete confirmation
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Delete Event'),
                                  content: const Text(
                                    'Are you sure you want to delete this event? This action cannot be undone.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Cancel'),
                                    ),
                                    FilledButton(
                                      onPressed: () {
                                        Navigator.of(
                                          context,
                                        ).pop(); // Close bottom sheet
                                        context.read<AgendaEventBloc>().add(
                                          DeleteAgendaEventEvent(
                                            agendaEvent: event,
                                          ),
                                        );
                                      },
                                      style: FilledButton.styleFrom(
                                        backgroundColor: Theme.of(
                                          context,
                                        ).colorScheme.error,
                                      ),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:academia/config/router/router.dart';
import 'package:academia/constants/responsive_break_points.dart';
import 'package:academia/features/agenda/agenda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

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
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
              showModalBottomSheet(
                context: context,
                builder: (context) => Padding(
                  padding: EdgeInsetsGeometry.all(12),
                  child: Card(
                    elevation: 0,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: ListTile(
                      title: Text("Create an agenda item"),
                      leading: Icon(Icons.event_note),
                      subtitle: Text(
                        "Create an agenda item for the selected day",
                      ),
                      onTap: () {
                        context.pop();
                        CreateAgendaEventRoute().push(context);
                      },
                    ),
                  ),
                ),
              );
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
}

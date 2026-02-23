import 'package:academia/config/config.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/agenda/presentation/widgets/agenda_timeline_widget.dart';
import 'package:academia/features/timetable/domain/entities/timetable_entry_entity.dart';
import 'package:academia/features/todos/presensentation/widgets/create_todo_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../course/presentation/cubit/course_cubit.dart';

class AgendaHomePage extends StatefulWidget {
  const AgendaHomePage({super.key});

  @override
  State<AgendaHomePage> createState() => _AgendaHomePageState();
}

class _AgendaHomePageState extends State<AgendaHomePage> {
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().watchCourses();
    context.read<TimetableEntryBloc>().add(const WatchAllTimetableEntriesEvent());
    context.read<AgendaEventBloc>().add(FetchCachedAgendaEventsEvent());
  }

  bool _occursOnDay(TimetableEntryEntity entry, DateTime day) {
    final rrule = entry.rrule?.trim() ?? '';

    // If no RRULE, it's a one-time event on its startDate
    if (rrule.isEmpty) {
      return isSameDay(entry.startDate, day);
    }

    // Map Dart weekday (1=Monday...7=Sunday) to RRULE day codes
    final weekdayMap = {
      1: 'MO', 2: 'TU', 3: 'WE', 4: 'TH', 5: 'FR', 6: 'SA', 7: 'SU',
    };
    final dayCode = weekdayMap[day.weekday]!;

    // Extract BYDAY value using regex to avoid false positives
    final bydayRegex = RegExp(r'BYDAY=([^;]+)');
    final match = bydayRegex.firstMatch(rrule);

    if (match == null) {
      if (rrule.contains('FREQ=DAILY')) {
        return day.isAfter(entry.startDate) || isSameDay(entry.startDate, day);
      }
      return false;
    }

    final bydayValue = match.group(1) ?? '';
    final days = bydayValue.split(',').map((d) => d.trim()).toList();

    return days.contains(dayCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<AgendaEventBloc>().add(FetchAgendaEventsEvent());
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar.medium(
              title: Text(
                "Agenda",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              pinned: true,
              snap: true,
              floating: true,
              actions: [
                Visibility(
                  visible: kIsWeb,
                  child: IconButton(
                    onPressed: () {
                      context.read<AgendaEventBloc>().add(
                        FetchAgendaEventsEvent(),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ),
              ],
            ),
            
            // Calendar Section
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(
                child: CalendarHomeWidget(
                  selectedDay: _selectedDay,
                  onDayChanged: (day, _, __) {
                    setState(() {
                      _selectedDay = day;
                    });
                  },
                ),
              ),
            ),

            // Date Header Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Text(
                      isSameDay(_selectedDay, DateTime.now()) 
                        ? "Today's Schedule" 
                        : DateFormat('EEEE, MMMM d').format(_selectedDay),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    if (!isSameDay(_selectedDay, DateTime.now()))
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _selectedDay = DateTime.now();
                          });
                        },
                        icon: const Icon(Icons.today, size: 18),
                        label: const Text("Today"),
                      ),
                  ],
                ),
              ),
            ),

            // Combined Schedule (Reactive)
            BlocBuilder<TimetableEntryBloc, TimetableEntryState>(
              builder: (context, timetableState) {
                final allTimetableEntries = timetableState is TimetableEntriesLoaded 
                    ? timetableState.entries 
                    : <TimetableEntryEntity>[];

                return BlocBuilder<AgendaEventBloc, AgendaEventState>(
                  builder: (context, agendaState) {
                    if (agendaState is AgendaEventLoadedState) {
                      return StreamBuilder<List<AgendaEvent>>(
                        stream: agendaState.agendaEventsStream,
                        builder: (context, snapshot) {
                          final allEvents = snapshot.data ?? [];
                          
                          // Filter for the selected day
                          final dayEvents = allEvents.where((e) => 
                            e.startTime != null && isSameDay(e.startTime!, _selectedDay)
                          ).toList();

                          final dayClasses = allTimetableEntries.where((e) => 
                            _occursOnDay(e, _selectedDay)
                          ).toList();

                          return SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            sliver: SliverToBoxAdapter(
                              child: AgendaTimelineWidget(
                                selectedDay: _selectedDay,
                                events: dayEvents,
                                classes: dayClasses,
                              ),
                            ),
                          );
                        },
                      );
                    }
                    
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            
            // Bottom Padding for FAB
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
      floatingActionButton: ExpandingFab(
        mainIcon: Icons.add,
        actions: [
          FabAction(
            tooltip: "Manage your To-Dos",
            icon: Icons.task_alt,
            iconColor: Theme.of(context).colorScheme.onSecondaryContainer,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            onPressed: () {
              showModalBottomSheet(
                showDragHandle: true,
                isScrollControlled: true,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                context: context,
                builder: (context) => CreateTodoBottomSheet(),
              );
            },
          ),
          FabAction(
            icon: Symbols.calendar_add_on,
            iconColor: Theme.of(context).colorScheme.onSecondaryContainer,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            onPressed: () {
              CreateAgendaEventRoute().push(context);
            },
          ),
        ],
      ),
    );
  }
}

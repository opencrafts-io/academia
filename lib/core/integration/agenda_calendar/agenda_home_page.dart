import 'package:academia/core/core.dart';
import 'package:agenda/agenda.dart';
import 'package:courses/courses.dart' as courses;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todos/todos.dart' as todos;

import 'agenda_day_grid_widget.dart';
import 'calendar_home_widget.dart';
import 'schedule_entry_occurrence.dart';

enum _AgendaViewMode { day, month }

class AgendaHomePage extends StatefulWidget {
  const AgendaHomePage({super.key});

  @override
  State<AgendaHomePage> createState() => _AgendaHomePageState();
}

class _AgendaHomePageState extends State<AgendaHomePage> {
  DateTime _selectedDay = DateUtils.dateOnly(DateTime.now());
  DateTime _focusedDay = DateUtils.dateOnly(DateTime.now());
  _AgendaViewMode _viewMode = _AgendaViewMode.day;

  @override
  void initState() {
    super.initState();
    context.read<courses.CourseCubit>().loadWeeklySchedule();
    _loadAgendaMonth(_selectedDay);
  }

  void _loadAgendaMonth(DateTime day) {
    final loadedMonth = context.read<AgendaCubit>().state.startDate;
    if (loadedMonth?.year == day.year && loadedMonth?.month == day.month) {
      return;
    }
    context.read<AgendaCubit>().loadRange(
      startDate: DateTime(day.year, day.month),
      endDate: DateTime(
        day.year,
        day.month + 1,
      ).subtract(const Duration(days: 1)),
    );
  }

  Future<void> _refresh() async {
    await Future.wait([
      context.read<AgendaCubit>().reload(),
      context.read<courses.CourseCubit>().loadWeeklySchedule(),
      context.read<todos.TodoItemCubit>().loadItems(),
    ]);
  }

  void _selectDay(DateTime day) {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedDay = DateUtils.dateOnly(day);
      _focusedDay = DateUtils.dateOnly(day);
    });
    _loadAgendaMonth(day);
  }

  void _changeVisibleMonth(DateTime day) {
    setState(() => _focusedDay = DateUtils.dateOnly(day));
    _loadAgendaMonth(day);
  }

  void _showToday() {
    final today = DateUtils.dateOnly(DateTime.now());
    HapticFeedback.selectionClick();
    setState(() {
      _selectedDay = today;
      _focusedDay = today;
    });
    _loadAgendaMonth(today);
  }

  void _createEvent() {
    context.push<void>('/calendar/create', extra: _selectedDay);
  }

  void _createCourse() {
    const courses.CreateCourseRoute().push(context);
  }

  void _createTodo() {
    todos.CreateTodoItemRoute().push(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: _refresh,
        child: CustomScrollView(
          key: const PageStorageKey<String>('agenda-calendar-scroll'),
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar.medium(
              title: Text(
                'Calendar',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              pinned: true,
              snap: true,
              floating: true,
              actions: [
                if (kIsWeb)
                  IconButton(
                    tooltip: 'Refresh agenda',
                    onPressed: _refresh,
                    icon: const Icon(Icons.refresh_rounded),
                  ),
                const SizedBox(width: 8),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat.yMMMM().format(_focusedDay),
                                      style: theme.textTheme.titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.4,
                                          ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _viewMode == _AgendaViewMode.day
                                          ? (isSameDay(
                                                  _selectedDay,
                                                  DateTime.now(),
                                                )
                                                ? 'A little space for what matters today.'
                                                : 'A little space for what matters on this day.')
                                          : 'Choose a day to see what is ahead.',
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: colors.onSurfaceVariant,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              SegmentedButton<_AgendaViewMode>(
                                showSelectedIcon: false,
                                style: ButtonStyle(
                                  visualDensity: VisualDensity.compact,
                                  padding: const WidgetStatePropertyAll(
                                    EdgeInsets.symmetric(horizontal: 12),
                                  ),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                segments: const [
                                  ButtonSegment(
                                    value: _AgendaViewMode.day,
                                    label: Text('Day'),
                                  ),
                                  ButtonSegment(
                                    value: _AgendaViewMode.month,
                                    label: Text('Month'),
                                  ),
                                ],
                                selected: {_viewMode},
                                onSelectionChanged: (selection) {
                                  HapticFeedback.selectionClick();
                                  setState(() => _viewMode = selection.first);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          AnimatedSize(
                            duration: reduceMotion
                                ? Duration.zero
                                : const Duration(milliseconds: 240),
                            curve: Curves.easeOutCubic,
                            alignment: Alignment.topCenter,
                            child: CalendarHomeWidget(
                              selectedDay: _selectedDay,
                              focusedDay: _focusedDay,
                              calendarFormat: _viewMode == _AgendaViewMode.day
                                  ? CalendarFormat.week
                                  : CalendarFormat.month,
                              onDayChanged: _selectDay,
                              onVisibleMonthChanged: _changeVisibleMonth,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 16,
                            runSpacing: 8,
                            alignment: WrapAlignment.center,
                            children: [
                              _CalendarLegendItem(
                                color: colors.primary,
                                label: 'Events',
                              ),
                              _CalendarLegendItem(
                                color: colors.secondary,
                                label: 'Courses',
                              ),
                              _CalendarLegendItem(
                                color: colors.tertiary,
                                label: 'To-dos',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AnimatedSwitcher(
                              duration: reduceMotion
                                  ? Duration.zero
                                  : const Duration(milliseconds: 180),
                              switchInCurve: Curves.easeOutCubic,
                              switchOutCurve: Curves.easeInCubic,
                              transitionBuilder: (child, animation) =>
                                  FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0, 0.08),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: child,
                                    ),
                                  ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  key: ValueKey(
                                    DateUtils.dateOnly(_selectedDay),
                                  ),
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Events',
                                      style: theme.textTheme.headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.5,
                                          ),
                                    ),
                                    Text(
                                      isSameDay(_selectedDay, DateTime.now())
                                          ? 'Today · ${DateFormat('EEEE, MMM d').format(_selectedDay)}'
                                          : DateFormat('EEEE, MMMM d')
                                                .format(_selectedDay),
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: colors.onSurfaceVariant,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (!isSameDay(_selectedDay, DateTime.now()))
                            IconButton(
                              tooltip: 'Go to today',
                              onPressed: _showToday,
                              icon: const Icon(Icons.today_rounded),
                            ),
                          TextButton.icon(
                            onPressed: _createEvent,
                            icon: const Icon(Icons.add_rounded, size: 18),
                            label: const Text('Add event'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<courses.CourseCubit, courses.CourseState>(
              buildWhen: (previous, current) =>
                  !listEquals(
                    previous.weeklySchedule,
                    current.weeklySchedule,
                  ) ||
                  previous.isScheduleLoading != current.isScheduleLoading,
              builder: (context, courseState) {
                final classes = courseState.weeklySchedule
                    .where(
                      (entry) => scheduleEntryOccursOnDay(entry, _selectedDay),
                    )
                    .toList();
                return BlocBuilder<AgendaCubit, AgendaState>(
                  buildWhen: (previous, current) =>
                      !listEquals(previous.events, current.events) ||
                      previous.error != current.error ||
                      previous.isLoading != current.isLoading ||
                      previous.isLoadingPage != current.isLoadingPage ||
                      previous.page != current.page ||
                      previous.next != current.next ||
                      previous.previous != current.previous,
                  builder: (context, state) {
                    final dayEvents = state.events
                        .where(
                          (event) =>
                              event.startTime != null &&
                              isSameDay(
                                event.startTime!.toLocal(),
                                _selectedDay,
                              ),
                        )
                        .toList();

                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverToBoxAdapter(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 720),
                            child: Column(
                              children: [
                                if (state.error != null)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Material(
                                      color: colors.errorContainer,
                                      borderRadius: BorderRadius.circular(18),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          14,
                                          8,
                                          8,
                                          8,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.cloud_off_rounded,
                                              color: colors.onErrorContainer,
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                state.error!,
                                                style: TextStyle(
                                                  color:
                                                      colors.onErrorContainer,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              tooltip: 'Retry agenda',
                                              onPressed: () => context
                                                  .read<AgendaCubit>()
                                                  .reload(),
                                              icon: Icon(
                                                Icons.refresh_rounded,
                                                color: colors.onErrorContainer,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                AnimatedSwitcher(
                                  duration: reduceMotion
                                      ? Duration.zero
                                      : const Duration(milliseconds: 200),
                                  switchInCurve: Curves.easeOutCubic,
                                  switchOutCurve: Curves.easeInCubic,
                                  transitionBuilder: (child, animation) =>
                                      FadeTransition(
                                        opacity: animation,
                                        child: SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0, 0.04),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        ),
                                      ),
                                  child: AgendaDayGridWidget(
                                    key: ValueKey(
                                      DateUtils.dateOnly(_selectedDay),
                                    ),
                                    day: _selectedDay,
                                    events: dayEvents,
                                    classes: classes,
                                    isAgendaLoading: state.isLoading,
                                    isScheduleLoading:
                                        courseState.isScheduleLoading,
                                    onCreateEvent: _createEvent,
                                  ),
                                ),
                                if (state.hasPreviousPage ||
                                    state.hasNextPage) ...[
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (state.hasPreviousPage)
                                        TextButton.icon(
                                          onPressed: state.isLoadingPage
                                              ? null
                                              : context
                                                    .read<AgendaCubit>()
                                                    .loadPreviousPage,
                                          icon: const Icon(
                                            Icons.chevron_left_rounded,
                                          ),
                                          label: const Text('Previous'),
                                        ),
                                      Text('Page ${state.page}'),
                                      if (state.hasNextPage)
                                        TextButton.icon(
                                          onPressed: state.isLoadingPage
                                              ? null
                                              : context
                                                    .read<AgendaCubit>()
                                                    .loadNextPage,
                                          icon: const Icon(
                                            Icons.chevron_right_rounded,
                                          ),
                                          label: const Text('Next'),
                                          iconAlignment: IconAlignment.end,
                                        ),
                                    ],
                                  ),
                                  if (state.isLoadingPage)
                                    const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: CircularProgressIndicator(),
                                    ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 104)),
          ],
        ),
      ),
      floatingActionButton: ExpandingFab(
        mainIcon: Icons.add_rounded,
        actions: [
          FabAction(
            tooltip: 'Add a to-do',
            icon: Icons.task_alt_rounded,
            iconColor: colors.onTertiaryContainer,
            backgroundColor: colors.tertiaryContainer,
            onPressed: _createTodo,
          ),
          FabAction(
            tooltip: 'Add a course',
            icon: Symbols.menu_book_rounded,
            iconColor: colors.onSecondaryContainer,
            backgroundColor: colors.secondaryContainer,
            onPressed: _createCourse,
          ),
          FabAction(
            tooltip: 'Add an event',
            icon: Symbols.calendar_add_on_rounded,
            iconColor: colors.onPrimaryContainer,
            backgroundColor: colors.primaryContainer,
            onPressed: _createEvent,
          ),
        ],
      ),
    );
  }
}

class _CalendarLegendItem extends StatelessWidget {
  const _CalendarLegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: const SizedBox.square(dimension: 6),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

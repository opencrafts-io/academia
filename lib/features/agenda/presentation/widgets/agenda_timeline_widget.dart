import 'dart:async';
import 'package:academia/config/config.dart';
import 'package:academia/features/agenda/agenda.dart';
import 'package:academia/features/course/course.dart';
import 'package:academia/features/course/presentation/widgets/course_card.dart';
import 'package:academia/features/timetable/domain/entities/timetable_entry_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaTimelineWidget extends StatefulWidget {
  final DateTime selectedDay;
  final List<AgendaEvent> events;
  final List<TimetableEntryEntity> classes;

  const AgendaTimelineWidget({
    super.key,
    required this.selectedDay,
    required this.events,
    required this.classes,
  });

  @override
  State<AgendaTimelineWidget> createState() => _AgendaTimelineWidgetState();
}

class _AgendaTimelineWidgetState extends State<AgendaTimelineWidget> {
  late Timer _timer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted) {
        setState(() {
          _now = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Combine and sort events by time
    final allDayItems = <_TimelineItem>[];
    
    for (final event in widget.events) {
      if (event.startTime != null && event.endTime != null) {
        allDayItems.add(_TimelineItem(
          start: event.startTime!,
          end: event.endTime!,
          title: event.summary ?? 'Event',
          description: event.description,
          isEvent: true,
          originalObject: event,
        ));
      }
    }
    
    for (final entry in widget.classes) {
      final start = DateTime(
        widget.selectedDay.year,
        widget.selectedDay.month,
        widget.selectedDay.day,
        entry.startDate.hour,
        entry.startDate.minute,
      );
      final end = start.add(Duration(minutes: entry.durationMinutes));
      
      allDayItems.add(_TimelineItem(
        start: start,
        end: end,
        title: 'Class', // Will be updated by CourseCard logic if needed
        isEvent: false,
        originalObject: entry,
      ));
    }
    
    allDayItems.sort((a, b) => a.start.compareTo(b.start));

    return Column(
      children: [
        if (isSameDay(widget.selectedDay, _now)) _buildCurrentTimeIndicator(),
        const SizedBox(height: 16),
        if (allDayItems.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Text('No events scheduled for this day'),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: allDayItems.length,
            itemBuilder: (context, index) {
              final item = allDayItems[index];
              return _buildTimelineRow(context, item);
            },
          ),
      ],
    );
  }

  Widget _buildCurrentTimeIndicator() {
    final theme = Theme.of(context);
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            DateFormat.Hm().format(_now),
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Container(
            height: 2,
            color: theme.colorScheme.primary,
          ),
        ),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineRow(BuildContext context, _TimelineItem item) {
    final theme = Theme.of(context);
    final isPast = item.end.isBefore(_now) && isSameDay(widget.selectedDay, _now);
    final isCurrent = item.start.isBefore(_now) && 
                      item.end.isAfter(_now) && 
                      isSameDay(widget.selectedDay, _now);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Time Column
          SizedBox(
            width: 60,
            child: Column(
              children: [
                Text(
                  DateFormat.Hm().format(item.start),
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: isCurrent ? FontWeight.bold : null,
                    color: isPast ? theme.colorScheme.outline : null,
                  ),
                ),
                const Expanded(child: VerticalDivider(thickness: 1, width: 1)),
              ],
            ),
          ),
          
          // Content Column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 16),
              child: Opacity(
                opacity: isPast ? 0.6 : 1.0,
                child: item.isEvent 
                  ? AgendaEventCard(event: item.originalObject as AgendaEvent)
                  : BlocBuilder<CourseCubit, CourseState>(
                      builder: (context, state) {
                        final entry = item.originalObject as TimetableEntryEntity;
                        final course = state.maybeWhen(
                          success: (courses) => courses.where((c) => c.id == entry.courseId).firstOrNull,
                          orElse: () => null,
                        );
                        
                        if (course == null) return const SizedBox.shrink();

                        return CourseCard(course: course, onTap: ()=> ViewCourseRoute(courseId: course.id??'').push(context),);
                      },
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem {
  final DateTime start;
  final DateTime end;
  final String title;
  final String? description;
  final bool isEvent;
  final Object originalObject;

  _TimelineItem({
    required this.start,
    required this.end,
    required this.title,
    this.description,
    required this.isEvent,
    required this.originalObject,
  });
}

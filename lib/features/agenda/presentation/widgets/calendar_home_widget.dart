import 'package:academia/constants/responsive_break_points.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarHomeWidget extends StatefulWidget {
  const CalendarHomeWidget({super.key});

  @override
  State<CalendarHomeWidget> createState() => _CalendarHomeWidgetState();
}

class _CalendarHomeWidgetState extends State<CalendarHomeWidget> {
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: ResponsiveBreakPoints.mobile),
      child: TableCalendar(
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
          });
          // showModalBottomSheet(
          //   context: context,
          //   builder: (context) => Center(child: Text("Hi")),
          // );
        },

        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          todayDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).colorScheme.primary),
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
        firstDay: DateTime(2025),
        lastDay: DateTime(2080),
      ),
    );
  }
}

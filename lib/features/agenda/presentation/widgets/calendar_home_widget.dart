import 'package:academia/constants/responsive_break_points.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarHomeWidget extends StatefulWidget {
  const CalendarHomeWidget({super.key});

  @override
  State<CalendarHomeWidget> createState() => _CalendarHomeWidgetState();
}

class _CalendarHomeWidgetState extends State<CalendarHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: ResponsiveBreakPoints.mobile),
      child: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime(2025),
        lastDay: DateTime(2080),
      ),
    );
  }
}

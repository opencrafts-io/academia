import 'package:academia/features/sherehe/presentation/utils/sherehe_utils.dart';
import 'package:flutter/material.dart';

class TicketDateRangeWidget extends StatefulWidget {
  final DateTimeRange? selectedTicketDateRange;
  final ValueChanged<DateTimeRange?> onDateRangeChanged;
  final DateTime eventStartDateTime;
  final DateTime eventEndDateTime;

  const TicketDateRangeWidget({
    super.key,
    required this.selectedTicketDateRange,
    required this.onDateRangeChanged,
    required this.eventStartDateTime,
    required this.eventEndDateTime,
  });

  @override
  State<TicketDateRangeWidget> createState() => _TicketDateRangeWidgetState();
}

class _TicketDateRangeWidgetState extends State<TicketDateRangeWidget> {
  Future<void> _pickTicketDateRange() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: widget.eventStartDateTime,
      lastDate: widget.eventEndDateTime,
      initialDateRange: widget.selectedTicketDateRange,
    );

    if (range != null) {
      final selectedRange = DateTimeRange(
        start: DateTime(
          range.start.year,
          range.start.month,
          range.start.day,
          widget.eventStartDateTime.hour,
          widget.eventStartDateTime.minute,
          widget.eventStartDateTime.second,
        ),
        end: DateTime(
          range.end.year,
          range.end.month,
          range.end.day,
          23,
          59,
          59,
        ),
      );
      widget.onDateRangeChanged(selectedRange);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickTicketDateRange,
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Ticket Validity",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          helperText: "Select the days when the ticket is valid",
          helperStyle: Theme.of(context).textTheme.labelSmall,
        ),
        child: Text(
          widget.selectedTicketDateRange == null
              ? "Select valid days"
              : "${ShereheUtils.formatDateRange(widget.selectedTicketDateRange!.start)} → "
                    "${ShereheUtils.formatDateRange(widget.selectedTicketDateRange!.end)} (${widget.selectedTicketDateRange!.duration.inDays + 1} days)",
        ),
      ),
    );
  }
}

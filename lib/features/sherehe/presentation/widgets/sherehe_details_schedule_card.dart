import 'package:academia/features/sherehe/presentation/utils/sherehe_utils.dart';
import 'package:flutter/material.dart';

class ShereheDetailsScheduleCard extends StatelessWidget {
  final String startDate;
  final String endDate;

  const ShereheDetailsScheduleCard({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    final start = DateTime.parse(startDate).toLocal();
    final end = DateTime.parse(endDate).toLocal();

    final isSameDay =
        start.year == end.year &&
        start.month == end.month &&
        start.day == end.day;

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  "Event Schedule",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            if (isSameDay)
              _SameDayView(startDate: startDate, endDate: endDate)
            else
              _MultiDayTimeline(startDate: startDate, endDate: endDate),
          ],
        ),
      ),
    );
  }
}

class _SameDayView extends StatelessWidget {
  final String startDate;
  final String endDate;

  const _SameDayView({required this.startDate, required this.endDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ShereheUtils.formatDate(startDate),
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 6),
            Text(
              "${ShereheUtils.formatTime(startDate)} - ${ShereheUtils.formatTime(endDate)}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MultiDayTimeline extends StatelessWidget {
  final String startDate;
  final String endDate;

  const _MultiDayTimeline({required this.startDate, required this.endDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _TimelineItem(
            label: "Starts",
            date: ShereheUtils.formatDate(startDate),
            time: ShereheUtils.formatTime(startDate),
            isTop: true,
          ),
          _TimelineDivider(),
          _TimelineItem(
            label: "Ends",
            date: ShereheUtils.formatDate(endDate),
            time: ShereheUtils.formatTime(endDate),
            isTop: false,
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String label;
  final String date;
  final String time;
  final bool isTop;

  const _TimelineItem({
    required this.label,
    required this.date,
    required this.time,
    required this.isTop,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
            if (isTop)
              Container(
                width: 2,
                height: 40,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
          ],
        ),

        const SizedBox(width: 12),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                date,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                time,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimelineDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Container(
        width: 2,
        height: 12,
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
    );
  }
}

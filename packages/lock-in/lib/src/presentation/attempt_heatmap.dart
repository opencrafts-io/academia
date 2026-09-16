import 'package:flutter/material.dart';

/// Compact, local-only visualization of blocked app launches.
class AttemptHeatmap extends StatelessWidget {
  const AttemptHeatmap({
    super.key,
    required this.counts,
    this.weeks = 12,
    this.endDate,
  });

  final Map<DateTime, int> counts;
  final int weeks;
  final DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    final end = _dateOnly(endDate ?? DateTime.now());
    final start = end.subtract(Duration(days: weeks * 7 - 1));
    final maximum = counts.values.fold(
      0,
      (max, count) => count > max ? count : max,
    );
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final gap = 4.0;
        final size = ((constraints.maxWidth - (weeks - 1) * gap) / weeks).clamp(
          12.0,
          28.0,
        );
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: List.generate(weeks * 7, (index) {
            final day = start.add(Duration(days: index));
            final count = counts[_dateOnly(day)] ?? 0;
            final intensity = maximum == 0 ? 0.0 : count / maximum;
            final color = Color.lerp(
              colorScheme.surfaceContainerHighest,
              colorScheme.primary,
              intensity,
            )!;
            return Semantics(
              label: '$count blocked attempts on ${_labelFor(day)}',
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  static DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  static String _labelFor(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

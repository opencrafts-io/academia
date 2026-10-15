import 'package:contribution_heatmap/contribution_heatmap.dart';
import 'package:flutter/material.dart';

/// Contribution calendar for locally recorded blocked app launches.
class AttemptHeatmap extends StatelessWidget {
  const AttemptHeatmap({
    super.key,
    required this.counts,
    this.days = 365,
    this.endDate,
    this.onDaySelected,
  });

  final Map<DateTime, int> counts;
  final int days;
  final DateTime? endDate;
  final void Function(DateTime date, int count)? onDaySelected;

  @override
  Widget build(BuildContext context) {
    final today = _dateOnly(endDate ?? DateTime.now());
    final firstDay = today.subtract(Duration(days: days - 1));
    final List<ContributionEntry> entries = counts.entries
        .where((entry) => entry.value > 0)
        .map((entry) => ContributionEntry(_dateOnly(entry.key), entry.value))
        .toList(growable: false);
    final colors = Theme.of(context).colorScheme;
    final labelStyle = Theme.of(
      context,
    ).textTheme.labelSmall?.copyWith(color: colors.onSurfaceVariant);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 320),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: ContributionHeatmap(
        key: ValueKey(
          Object.hash(
            firstDay,
            today,
            Object.hashAll(
              entries.map((entry) => Object.hash(entry.date, entry.count)),
            ),
          ),
        ),
        entries: entries,
        minDate: firstDay,
        maxDate: today,
        startWeekday: DateTime.monday,
        weekdayLabel: WeekdayLabel.githubLike,
        showMonthLabels: true,
        showCellDate: false,
        cellSize: 10,
        cellSpacing: 3,
        cellRadius: 3,
        padding: EdgeInsets.zero,
        monthTextStyle: labelStyle,
        weekdayTextStyle: labelStyle,
        customColorScale: (count) {
          if (count == 0) {
            return colors.surfaceContainerHighest;
          }
          if (count == 1) {
            return Color.lerp(
              colors.surfaceContainerHighest,
              colors.primary,
              .28,
            )!;
          }
          if (count <= 3) {
            return Color.lerp(
              colors.surfaceContainerHighest,
              colors.primary,
              .52,
            )!;
          }
          if (count <= 6) {
            return Color.lerp(
              colors.surfaceContainerHighest,
              colors.primary,
              .76,
            )!;
          }
          return colors.primary;
        },
        onCellTap: onDaySelected,
      ),
    );
  }

  static DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);
}

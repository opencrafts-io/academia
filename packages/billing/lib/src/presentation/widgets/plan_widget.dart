import 'package:billing/src/domain/domain.dart';
import 'package:flutter/material.dart';

class PlanWidget extends StatelessWidget {
  const PlanWidget({
    super.key,
    required this.plan,
    this.onTap,
    this.isSelected = false,
  });
  final Plan plan;
  final Function(Plan)? onTap;
  final bool isSelected;

  /// Converts a raw billing interval, in days, into a clean, human-readable
  /// cadence label. Common cadences map to their familiar names; anything
  /// else falls back to "Every N days" rather than showing a raw number
  /// with no context.
  ///
  /// Ranges (rather than exact day counts) are used for month/quarter/year
  /// so that calendar-accurate variations (28–31 day months, leap years)
  /// still read naturally instead of falling through to the raw fallback.
  String formatBillingInterval(int days) {
    return switch (days) {
      7 => 'Weekly',
      14 => 'Biweekly',
      >= 28 && <= 31 => 'Monthly',
      >= 89 && <= 92 => 'Quarterly',
      >= 180 && <= 184 => 'Semiannual',
      >= 360 && <= 366 => 'Annual',
      _ => 'Every $days days',
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final foreground = isSelected
        ? theme.colorScheme.onPrimaryContainer
        : theme.colorScheme.onSurface;
    final subForeground = isSelected
        ? theme.colorScheme.onPrimaryContainer
        : theme.colorScheme.onSurfaceVariant;

    return Semantics(
      button: true,
      selected: isSelected,
      label:
          '${plan.name}, ${formatPlanPrice(plan)}, '
          '${formatBillingInterval(plan.billingIntervalDays)}',
      child: AnimatedContainer(
        curve: Curves.easeInOutCubicEmphasized,
        duration: Duration(milliseconds: 300),
        clipBehavior: .hardEdge,
        decoration: ShapeDecoration(
          color: isSelected
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surfaceContainer,
          shape: RoundedSuperellipseBorder(
            side: BorderSide(
              width: isSelected ? 2 : 1,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outlineVariant,
            ),
            borderRadius: .circular(12),
          ),
        ),
        child: Material(
          type: .transparency,
          elevation: 0,
          clipBehavior: .hardEdge,
          child: InkWell(
            onTap: () {
              onTap?.call(plan);
            },
            child: Padding(
              padding: .all(12),
              child: Row(
                crossAxisAlignment: .start,
                mainAxisAlignment: .spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          plan.name,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: .w700,
                            fontSize: 20,
                            color: foreground,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          plan.description,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: subForeground,
                          ),
                        ),

                        SizedBox(height: 4),

                        _BillingIntervalBadge(
                          label: formatBillingInterval(
                            plan.billingIntervalDays,
                          ),
                          isSelected: isSelected,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .end,
                      children: [
                        Text(
                          formatPlanPrice(plan),
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: .w700,
                            color: isSelected
                                ? theme.colorScheme.primary
                                : foreground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Formats a Swagger monetary value, which is represented in minor units.
String formatPlanPrice(Plan plan) =>
    '${plan.currency} ${(plan.price / 100).toStringAsFixed(2)}';

/// A small pill-shaped badge used to surface secondary plan info (like the
/// billing cadence) as a distinct, tappable-looking chip rather than plain
/// inline text — a more expressive treatment for secondary metadata.
class _BillingIntervalBadge extends StatelessWidget {
  const _BillingIntervalBadge({required this.label, required this.isSelected});

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primary.withValues(alpha: 0.12)
            : colorScheme.secondaryContainer,
        borderRadius: .circular(100),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelLarge?.copyWith(
          fontWeight: .w600,
          color: isSelected
              ? colorScheme.primary
              : colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }
}

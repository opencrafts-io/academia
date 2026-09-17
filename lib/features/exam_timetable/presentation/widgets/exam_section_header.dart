import 'package:flutter/material.dart';

/// A section title paired with a count badge, used above the upcoming and
/// past exam lists.
class ExamSectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final Color titleColor;
  final Color badgeColor;
  final Color badgeTextColor;

  const ExamSectionHeader({
    super.key,
    required this.title,
    required this.count,
    required this.titleColor,
    required this.badgeColor,
    required this.badgeTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: badgeColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$count',
            style: theme.textTheme.labelMedium?.copyWith(
              color: badgeTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

/// A compact icon + text row used to display exam metadata (day, time,
/// venue, coordinator, etc.) inside exam cards.
class ExamInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor;

  const ExamInfoRow({
    super.key,
    required this.icon,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 14, color: textColor.withValues(alpha: 0.7)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: textTheme.bodySmall?.copyWith(
              color: textColor,
              fontSize: 12,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

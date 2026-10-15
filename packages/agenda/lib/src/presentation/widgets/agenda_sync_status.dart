import 'package:flutter/material.dart';

class AgendaSyncStatus extends StatelessWidget {
  const AgendaSyncStatus({super.key, required this.status});

  final String? status;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final (label, icon, foreground, background) = switch (status) {
      'pending' => (
        'Syncing with Google Tasks',
        Icons.sync_rounded,
        colors.onPrimaryContainer,
        colors.primaryContainer,
      ),
      'synced' => (
        'Synced with Google Tasks',
        Icons.cloud_done_outlined,
        colors.onTertiaryContainer,
        colors.tertiaryContainer,
      ),
      'skipped' => (
        'Google Tasks not connected',
        Icons.link_off_rounded,
        colors.onSurfaceVariant,
        colors.surfaceContainerHigh,
      ),
      'failed' => (
        'Google Tasks sync failed',
        Icons.sync_problem_rounded,
        colors.onErrorContainer,
        colors.errorContainer,
      ),
      _ => (
        'Not linked to Google Tasks',
        Icons.cloud_off_outlined,
        colors.onSurfaceVariant,
        colors.surfaceContainerHigh,
      ),
    };

    return Semantics(
      label: label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: foreground),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium
                  ?.copyWith(color: foreground),
            ),
          ],
        ),
      ),
    );
  }
}

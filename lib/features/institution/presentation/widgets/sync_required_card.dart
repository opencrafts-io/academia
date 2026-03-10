import 'package:flutter/material.dart';

class SyncRequiredCard extends StatelessWidget {
  final VoidCallback onSyncPressed;
  final VoidCallback? onDismiss;

  const SyncRequiredCard({
    super.key,
    required this.onSyncPressed,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.secondaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0), // More expressive radius
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  color: colorScheme.onSecondaryContainer,
                ),
                const SizedBox(width: 12),
                Text(
                  "Keep things fresh",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "We’re showing you offline data for now. If you're online, a quick sync will bring in the latest updates from your institution.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSecondaryContainer.withAlpha(
                  (0.8 * 255.0).round(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onDismiss != null)
                  TextButton(
                    onPressed: onDismiss,
                    child: const Text("Maybe later"),
                  ),
                const SizedBox(width: 8),
                FilledButton.tonalIcon(
                  onPressed: onSyncPressed,
                  icon: const Icon(Icons.bolt_rounded),
                  label: const Text("Sync Now"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

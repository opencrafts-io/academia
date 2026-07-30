import 'package:flutter/material.dart';

/// A single row in a Material 3 Expressive action bottom sheet: a tonal
/// [CircleAvatar] icon badge next to a label, matching the "list of
/// actions" sheets used throughout chirp (attachment actions, post/community
/// overflow menus). [containerColor]/[onContainerColor] are typically a
/// `colorScheme.secondaryContainer`/`onSecondaryContainer` pair for neutral
/// actions, or `errorContainer`/`onErrorContainer` (with [textColor] set to
/// `colorScheme.error`) for destructive ones.
class SheetActionTile extends StatelessWidget {
  const SheetActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.containerColor,
    required this.onContainerColor,
    this.textColor,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color containerColor;
  final Color onContainerColor;
  final Color? textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: containerColor,
        foregroundColor: onContainerColor,
        child: Icon(icon),
      ),
      title: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(color: textColor),
      ),
      onTap: onTap,
    );
  }
}

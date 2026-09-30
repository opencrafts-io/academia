import 'package:flutter/material.dart';

class SyncStatusIndicator extends StatelessWidget {
  const SyncStatusIndicator({
    super.key,
    required this.status,
    required this.recordLabel,
    this.error,
    this.onEdit,
  });

  final String status;
  final String recordLabel;
  final String? error;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    if (status == 'synced') return const SizedBox.shrink();
    final colors = Theme.of(context).colorScheme;
    final failed = status == 'failed';
    final icon = Icon(
      failed ? Icons.error_outline_rounded : Icons.cloud_upload_outlined,
      size: 19,
      color: failed ? colors.error : colors.onSurfaceVariant,
    );
    if (!failed) {
      return Tooltip(
        message: 'Waiting to sync',
        child: Semantics(label: '$recordLabel waiting to sync', child: icon),
      );
    }
    return IconButton(
      tooltip: '$recordLabel sync failed. View details',
      visualDensity: VisualDensity.compact,
      onPressed: () => _showError(context),
      icon: icon,
    );
  }

  Future<void> _showError(BuildContext context) async {
    final edit = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.error_outline_rounded),
        title: Text('$recordLabel needs attention'),
        content: Text(error ?? 'Please review and save this item again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Close'),
          ),
          if (onEdit != null)
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Edit'),
            ),
        ],
      ),
    );
    if (edit == true) onEdit?.call();
  }
}

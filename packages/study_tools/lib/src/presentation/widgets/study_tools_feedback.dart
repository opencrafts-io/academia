import 'package:flutter/material.dart';

import '../study_tools_host.dart';

class StudyToolsEmptyState extends StatelessWidget {
  const StudyToolsEmptyState({this.courseId, super.key});
  final String? courseId;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.secondaryContainer,
                borderRadius: BorderRadius.circular(32),
              ),
              child: SizedBox.square(
                dimension: 84,
                child: Icon(
                  Icons.auto_stories_outlined,
                  size: 38,
                  color: colors.onSecondaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              courseId == null
                  ? 'Your library is ready'
                  : courseId == 'unassigned'
                  ? 'No unassigned materials yet'
                  : 'No materials for this course yet',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Text(
                'Upload a document to turn your class materials into a place to review and practise.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: colors.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudyToolsFailureView extends StatelessWidget {
  const StudyToolsFailureView({
    super.key,
    required this.message,
    required this.onRetry,
    this.onUpgrade = false,
  });
  final String message;
  final VoidCallback onRetry;
  final bool onUpgrade;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                onUpgrade ? Icons.lock_outline : Icons.cloud_off_outlined,
                size: 48,
                color: colors.primary,
              ),
              const SizedBox(height: 12),
              Text(
                onUpgrade
                    ? 'Study Tools needs an active subscription to access materials.'
                    : message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 12),
              if (onUpgrade)
                FilledButton(
                  onPressed: () => StudyToolsHost.openPaywall?.call(context),
                  child: const Text('View plans'),
                )
              else
                FilledButton.tonal(
                  onPressed: onRetry,
                  child: const Text('Try again'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudyToolsInlineError extends StatelessWidget {
  const StudyToolsInlineError({
    super.key,
    required this.message,
    this.onRetry,
    this.onUpgrade = false,
  });
  final String message;
  final VoidCallback? onRetry;
  final bool onUpgrade;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card.filled(
      color: colors.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: colors.onErrorContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: colors.onErrorContainer),
              ),
            ),
            if (onUpgrade)
              TextButton(
                onPressed: () => StudyToolsHost.openPaywall?.call(context),
                child: const Text('View plans'),
              )
            else if (onRetry != null)
              TextButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}

void showStudyToolsSnackBar(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  final colors = Theme.of(context).colorScheme;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        backgroundColor: isError ? colors.error : colors.inverseSurface,
        content: Text(message),
      ),
    );
}

String studyToolsFileSize(int bytes) => bytes >= 1024 * 1024
    ? '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB'
    : '${(bytes / 1024).ceil()} KB';

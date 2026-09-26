import 'package:flutter/material.dart';
import 'package:in_app_update/src/domain/update_campaign.dart';

class AppUpdateRequiredPage extends StatelessWidget {
  const AppUpdateRequiredPage({
    super.key,
    required this.campaign,
    required this.onUpdate,
  });

  final UpdateCampaign campaign;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Icon(
                        Icons.system_update_alt_rounded,
                        size: 42,
                        color: colorScheme.onPrimaryContainer,
                        semanticLabel: 'Update available',
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      campaign.title,
                      style: theme.textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      campaign.message,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton.icon(
                        onPressed: onUpdate,
                        icon: const Icon(Icons.download_rounded),
                        label: const Text('Get the new version'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppUpdateOptionalSheet extends StatelessWidget {
  const AppUpdateOptionalSheet({
    super.key,
    required this.campaign,
    required this.onUpdate,
  });

  final UpdateCampaign campaign;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(campaign.title, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              campaign.message,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 56,
              child: FilledButton.icon(
                onPressed: onUpdate,
                icon: const Icon(Icons.download_rounded),
                label: const Text('Get the new version'),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Maybe later'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:billing/src/domain/domain.dart';
import 'package:flutter/material.dart';

class SubscriptionStatusCard extends StatelessWidget {
  const SubscriptionStatusCard({super.key, required this.status});

  final SubscriptionStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subscription = status.subscription;
    final hasActiveSubscription = status.active && subscription != null;
    final colorScheme = theme.colorScheme;

    return Card(
      color: hasActiveSubscription
          ? colorScheme.secondaryContainer
          : colorScheme.surfaceContainer,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(
          hasActiveSubscription
              ? Icons.verified_rounded
              : Icons.info_outline_rounded,
          color: hasActiveSubscription
              ? colorScheme.onSecondaryContainer
              : colorScheme.primary,
        ),
        title: Text(
          hasActiveSubscription
              ? 'Current plan: ${subscription.planName}'
              : 'No active plan',
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: .w700),
        ),
        subtitle: Text(
          hasActiveSubscription
              ? 'Access until ${_formatDate(subscription.currentPeriodEnd)}'
              : 'Choose a plan below to unlock more of Academia.',
        ),
      ),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/${date.year}';
}

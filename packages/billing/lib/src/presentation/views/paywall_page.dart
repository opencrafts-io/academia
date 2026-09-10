import 'package:billing/src/domain/domain.dart';
import 'package:billing/src/presentation/presentation.dart';
import 'package:billing/src/presentation/widgets/plan_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material3_indicators/material3_indicators.dart';

/// Explains a blocked feature and owns the in-app plan selection flow.
///
/// The optional [onWebHandoffRequested] callback is deliberately the final
/// seam in this feature. The app can prepare an order without knowing how the
/// separate checkout web app is hosted or navigated to.
class PaywallPage extends StatelessWidget {
  const PaywallPage({
    super.key,
    this.featureName = 'this feature',
    this.accessMessage,
    this.onWebHandoffRequested,
  });

  final String featureName;
  final String? accessMessage;
  final ValueChanged<Order>? onWebHandoffRequested;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      SubscriptionManagementBloc,
      SubscriptionManagementState
    >(
      listener: (context, state) {
        final failure = state.failure;
        if (failure == null) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message), behavior: .floating),
        );
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            top: false,
            child: RefreshIndicator.noSpinner(
              onRefresh: () async {
                final bloc = context.read<SubscriptionManagementBloc>();
                bloc.add(const RefreshSubscriptionManagement());
                await bloc.stream.firstWhere(
                  (value) =>
                      value.status != SubscriptionManagementStatus.loading,
                );
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar.large(
                    pinned: true,
                    automaticallyImplyLeading: false,
                    title: const Text('Unlock more of Academia'),
                    actions: [
                      IconButton(
                        tooltip: 'Close',
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                    sliver: SliverList.list(
                      children: [
                        _PaywallIntro(
                          featureName: featureName,
                          accessMessage: accessMessage,
                        ),
                        if (state.subscriptionStatus != null) ...[
                          const SizedBox(height: 12),
                          SubscriptionStatusCard(
                            status: state.subscriptionStatus!,
                          ),
                        ],
                        const SizedBox(height: 24),
                        Text(
                          'Choose a plan',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Prices are shown in the plan currency per billing period.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(height: 12),
                        if (state.status ==
                            SubscriptionManagementStatus.loading)
                          const _LoadingPlans()
                        else if (state.plans.isEmpty)
                          const _PlansUnavailableView()
                        else
                          for (final plan in state.plans) ...[
                            PlanWidget(
                              plan: plan,
                              isSelected: state.selectedPlan?.code == plan.code,
                              onTap: (selected) => context
                                  .read<SubscriptionManagementBloc>()
                                  .add(SelectSubscriptionPlan(selected)),
                            ),
                            const SizedBox(height: 10),
                          ],
                        if (state.status ==
                                SubscriptionManagementStatus.orderReady &&
                            state.order != null) ...[
                          const SizedBox(height: 14),
                          OrderSummaryCard(
                            order: state.order!,
                            items: state.orderItems,
                            plan: state.selectedPlan,
                            onEdit: () => context
                                .read<SubscriptionManagementBloc>()
                                .add(const ClearSubscriptionOrder()),
                          ),
                        ],
                        const SizedBox(height: 20),
                        _PaywallAction(
                          state: state,
                          onCreateOrder: () => context
                              .read<SubscriptionManagementBloc>()
                              .add(const CreateSubscriptionOrder()),
                          onWebHandoff: state.order == null
                              ? null
                              : () => _showWebHandoff(context, state.order!),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            'You can review your order before anything opens outside the app.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showWebHandoff(BuildContext context, Order order) async {
    final shouldContinue = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => _WebHandoffSheet(
        onContinue: () => Navigator.of(sheetContext).pop(true),
      ),
    );
    if (shouldContinue != true || !context.mounted) return;

    final callback = onWebHandoffRequested;
    if (callback != null) {
      callback(order);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Your order is ready. Web checkout will be connected here.',
        ),
        behavior: .floating,
      ),
    );
  }
}

class _PaywallIntro extends StatelessWidget {
  const _PaywallIntro({required this.featureName, this.accessMessage});

  final String featureName;
  final String? accessMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lock_open_rounded, size: 72, color: colors.primary),
          const SizedBox(height: 28),
          Text(
            'Upgrade to use $featureName',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: colors.onSurface,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            accessMessage ??
                "Your current access does not include this feature. "
                    "Choose a plan to continue using it.",
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.onSurfaceVariant,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaywallAction extends StatelessWidget {
  const _PaywallAction({
    required this.state,
    required this.onCreateOrder,
    required this.onWebHandoff,
  });

  final SubscriptionManagementState state;
  final VoidCallback onCreateOrder;
  final VoidCallback? onWebHandoff;

  @override
  Widget build(BuildContext context) {
    final isCreating =
        state.status == SubscriptionManagementStatus.creatingOrder;
    final isReady = state.status == SubscriptionManagementStatus.orderReady;
    final enabled = isReady
        ? onWebHandoff != null || state.order != null
        : state.selectedPlan != null && !isCreating;

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: enabled ? (isReady ? onWebHandoff : onCreateOrder) : null,
        icon: isCreating
            ? const SizedBox(
                width: 20,
                height: 20,
                child: WavyLinearProgressIndicator(
                  amplitude: 4.0,
                  wavelength: 24.0,
                  waveSpeed: 5.0,
                  strokeWidth: 4.0,
                ),
              )
            : Icon(isReady ? Icons.open_in_new_rounded : Icons.arrow_forward),
        label: Text(
          isCreating
              ? 'Preparing order…'
              : isReady
              ? 'Continue on the web'
              : 'Review order',
        ),
      ),
    );
  }
}

class _WebHandoffSheet extends StatelessWidget {
  const _WebHandoffSheet({required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Finish your subscription on the web',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            const Text(
              'Your order is ready. You’ll be redirected to a secure web '
              'checkout to provide your details and complete payment. The app '
              'will not charge you from this screen.',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Not now'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: onContinue,
                  child: const Text('Continue'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingPlans extends StatelessWidget {
  const _LoadingPlans();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Semantics(
          label: 'Loading subscription plans',
          child: WavyCircularProgressIndicator(
            size: 64.0,
            amplitude: 3.0,
            frequency: 8.0,
          ),
        ),
      ),
    );
  }
}

class _PlansUnavailableView extends StatelessWidget {
  const _PlansUnavailableView();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      color: colors.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(Icons.cloud_off_rounded, color: colors.onSurfaceVariant),
            const SizedBox(height: 8),
            const Text('Plans are unavailable right now.'),
            const SizedBox(height: 4),
            Text(
              'Pull down to refresh and try again.',
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'splash_tip.dart';

class LaunchTipsSplashView extends StatelessWidget {
  const LaunchTipsSplashView({
    required this.brand,
    required this.tip,
    required this.tipsEnabled,
    required this.authReady,
    required this.authError,
    required this.onContinue,
    required this.onTipAction,
    required this.onRetry,
    super.key,
  });

  final Widget brand;
  final SplashTip? tip;
  final bool tipsEnabled;
  final bool authReady;
  final String? authError;
  final VoidCallback? onContinue;
  final ValueChanged<SplashTipAction>? onTipAction;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          child: Column(
            children: [
              Row(
                children: [
                  brand,
                  const SizedBox(width: 12),
                  Text(
                    'Academia',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: AnimatedSwitcher(
                    duration: reduceMotion
                        ? Duration.zero
                        : const Duration(milliseconds: 700),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (child, animation) {
                      if (reduceMotion) return child;

                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: animation.drive(
                            Tween<Offset>(
                              begin: const Offset(0, .02),
                              end: Offset.zero,
                            ),
                          ),
                          child: ScaleTransition(
                            scale: animation.drive(
                              Tween<double>(begin: .985, end: 1),
                            ),
                            child: child,
                          ),
                        ),
                      );
                    },
                    child: tipsEnabled && tip != null
                        ? _TipCard(
                            key: ValueKey(tip!.id),
                            tip: tip!,
                            actionEnabled: authReady,
                            onAction: onTipAction,
                          )
                        : const _PreparingCard(key: ValueKey('preparing')),
                  ),
                ),
              ),
              SizedBox(
                height: 88,
                child: Center(
                  child: AnimatedSwitcher(
                    duration: reduceMotion
                        ? Duration.zero
                        : const Duration(milliseconds: 450),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (child, animation) {
                      if (reduceMotion) return child;

                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: animation.drive(
                            Tween<Offset>(
                              begin: const Offset(0, .035),
                              end: Offset.zero,
                            ),
                          ),
                          child: child,
                        ),
                      );
                    },
                    child: _buildFooter(
                      context,
                      error: authError,
                      authReady: authReady,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(
    BuildContext context, {
    required String? error,
    required bool authReady,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (error case final message?) {
      return Column(
        key: const ValueKey('auth-error'),
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: colors.error),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ),
        ],
      );
    }

    if (authReady) {
      return SizedBox(
        key: const ValueKey('auth-ready'),
        width: double.infinity,
        height: 52,
        child: TextButton.icon(
          onPressed: onContinue,
          icon: const Icon(Icons.arrow_forward_rounded),
          label: const Text('Continue'),
        ),
      );
    }

    return Row(
      key: const ValueKey('auth-loading'),
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox.square(
          dimension: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: colors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Preparing your space',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard({
    required this.tip,
    required this.actionEnabled,
    required this.onAction,
    super.key,
  });

  final SplashTip tip;
  final bool actionEnabled;
  final ValueChanged<SplashTipAction>? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 480),
      child: Card.filled(
        color: colors.surfaceContainerHigh,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox.square(
                  dimension: 56,
                  child: Icon(
                    tip.icon,
                    color: colors.onPrimaryContainer,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'A QUICK TIP',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(tip.title, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 12),
              Text(
                tip.message,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              if (tip.action != null && tip.actionLabel.isNotEmpty) ...[
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: actionEnabled
                        ? () => onAction?.call(tip.action!)
                        : null,
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: Text(tip.actionLabel),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PreparingCard extends StatelessWidget {
  const _PreparingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.school_rounded, size: 56, color: colors.primary),
        const SizedBox(height: 16),
        Text('Make space for what matters.', style: theme.textTheme.titleLarge),
      ],
    );
  }
}

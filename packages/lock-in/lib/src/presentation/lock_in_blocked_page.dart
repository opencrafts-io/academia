import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material3_indicators/material3_indicators.dart';

import '../domain/lock_rule.dart';

/// The full-screen destination opened by Android after a blocked app launch.
class LockInBlockedPage extends StatefulWidget {
  const LockInBlockedPage({
    super.key,
    required this.onReturnHome,
    this.appIdentifier,
    this.loadBlockWindow,
    this.now,
  });

  final String? appIdentifier;
  final VoidCallback onReturnHome;
  final Future<LockRuleWindow?> Function(String appIdentifier, DateTime now)?
  loadBlockWindow;
  final DateTime Function()? now;

  @override
  State<LockInBlockedPage> createState() => _LockInBlockedPageState();
}

class _LockInBlockedPageState extends State<LockInBlockedPage> {
  Timer? _ticker;
  LockRuleWindow? _window;
  var _isLoadingWindow = false;

  DateTime get _now => (widget.now ?? DateTime.now)();

  @override
  void initState() {
    super.initState();
    _loadBlockWindow();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _loadBlockWindow() async {
    final identifier = widget.appIdentifier;
    final resolver = widget.loadBlockWindow;
    if (identifier == null || resolver == null) return;

    _isLoadingWindow = true;
    LockRuleWindow? window;
    try {
      window = await resolver(identifier, _now);
    } on Object {
      // The blocked screen remains useful even if the local database is
      // temporarily unavailable: the app identifier and return action remain.
    }
    if (!mounted) return;
    setState(() {
      _window = window;
      _isLoadingWindow = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final now = _now;
    final identifier = widget.appIdentifier;
    final blockedApp = identifier == null
        ? 'A distracting app'
        : _window?.appWithIdentifier(identifier)?.displayName ?? identifier;
    final remaining = _window?.remainingAt(now);
    final remainingFraction = _window == null
        ? null
        : 1 - _window!.progressAt(now);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) widget.onReturnHome();
      },
      child: Scaffold(
        backgroundColor: colors.surface,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 360),
                curve: Curves.easeOutCubic,
                tween: Tween(begin: .94, end: 1),
                builder: (context, scale, child) => Opacity(
                  opacity: scale,
                  child: Transform.scale(scale: scale, child: child),
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    crossAxisAlignment: .center,
                    children: [
                      SizedBox(
                        width: 152,
                        height: 152,
                        child: Stack(
                          alignment: .center,
                          children: [
                            WavyCircularProgressIndicator(
                              value: remainingFraction,
                              size: 152,
                              strokeWidth: 7,
                              trackStrokeWidth: 4,
                              amplitude: 2.5,
                              color: colors.primary,
                              backgroundColor: colors.primaryContainer,
                              semanticsLabel: 'Time remaining in focus rule',
                              semanticsValue: remaining == null
                                  ? 'Calculating'
                                  : _formatRemaining(remaining),
                            ),
                            Container(
                              width: 104,
                              height: 104,
                              decoration: ShapeDecoration(
                                color: colors.primaryContainer,
                                shape: RoundedSuperellipseBorder(
                                  borderRadius: BorderRadius.circular(36),
                                ),
                              ),
                              child: Icon(
                                Icons.lock_clock_rounded,
                                color: colors.onPrimaryContainer,
                                size: 52,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'This app is blocked',
                        textAlign: .center,
                        style: Theme.of(
                          context,
                        ).textTheme.displaySmall?.copyWith(fontWeight: .w800),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Blocked by Academia because of a rule you saved.',
                        textAlign: .center,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: colors.onSurfaceVariant),
                      ),
                      const SizedBox(height: 32),
                      if (_isLoadingWindow)
                        const SizedBox(height: 86)
                      else if (remaining != null) ...[
                        Text(
                          '${_formatRemaining(remaining)} remaining',
                          textAlign: .center,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: .w800),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Your ${_window!.rule.name} rule ends at '
                          '${_formatTime(_window!.endsAt)}.',
                          textAlign: .center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: colors.onSurfaceVariant),
                        ),
                        const SizedBox(height: 24),
                      ],
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: ShapeDecoration(
                          color: colors.surfaceContainerHigh,
                          shape: RoundedSuperellipseBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              'Blocked app',
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: colors.onSurfaceVariant,
                                    fontWeight: .w700,
                                  ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              blockedApp,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: .w700),
                            ),
                            if (_window != null) ...[
                              const SizedBox(height: 16),
                              Text(
                                'Saved rule',
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(
                                      color: colors.onSurfaceVariant,
                                      fontWeight: .w700,
                                    ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _window!.rule.name,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: .w700),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: widget.onReturnHome,
                        icon: const Icon(Icons.home_rounded),
                        label: const Text('Return to Academia'),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Blocked launches are saved only on this device.',
                        textAlign: .center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatRemaining(Duration duration) {
    final totalMinutes = duration.inMinutes;
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    if (hours == 0) return '${minutes == 0 ? 1 : minutes}m';
    if (minutes == 0) return '${hours}h';
    return '${hours}h ${minutes}m';
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}

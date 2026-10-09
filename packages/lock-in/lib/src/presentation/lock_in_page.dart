import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material3_indicators/material3_indicators.dart';

import '../application/app_blocking_gateway.dart';
import '../application/lock_in_service.dart';
import '../domain/lock_rule.dart';
import 'attempt_heatmap.dart';
import 'lock_rule_editor_page.dart';

class LockInPage extends StatefulWidget {
  const LockInPage({super.key, required this.service});

  final LockInService service;

  @override
  State<LockInPage> createState() => _LockInPageState();
}

class _LockInPageState extends State<LockInPage> with WidgetsBindingObserver {
  late Future<_LockInOverview> _overview;
  var _permissionSetupStarted = false;
  DateTime? _selectedActivityDate;
  int? _selectedActivityCount;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _overview = _loadOverview();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      unawaited(_refresh());
    }
  }

  Future<_LockInOverview> _loadOverview() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return const _LockInOverview.unsupported();
    }
    await widget.service.start();
    final now = DateTime.now();
    return _LockInOverview(
      permission: await widget.service.checkPermission(),
      rules: await widget.service.rules(),
      attempts: await widget.service.attemptCountsByDay(
        from: now.subtract(const Duration(days: 364)),
        to: now,
      ),
    );
  }

  Future<void> _refresh() async {
    final overview = _loadOverview();
    setState(() {
      _overview = overview;
    });
    await overview;
  }

  Future<void> _requestPermission() async {
    final consent = await _requestAccessibilityConsent();
    if (consent != true || !mounted) return;

    setState(() {
      _permissionSetupStarted = true;
    });
    await widget.service.requestPermission();
    if (mounted) await _refresh();
  }

  Future<bool?> _requestAccessibilityConsent() {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 560,
            maxHeight: MediaQuery.sizeOf(dialogContext).height * .8,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    'Allow Accessibility Service?',
                    style: Theme.of(dialogContext).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: SingleChildScrollView(
                    child: Text(
                      'Academia needs your explicit permission to use '
                      'Android\'s Accessibility Service for Lock In. With your '
                      'permission, Lock In receives the name of the app '
                      'currently open and uses it only to apply the app-blocking '
                      'rules and schedules you create.\n\n'
                      'App names and blocked-open events stay on your device '
                      'for Lock In and local focus statistics. They are not '
                      'shared with Academia or third parties.\n\n'
                      'Select Allow Accessibility Service to open Android '
                      'Settings. Select Decline to leave app blocking off.',
                      style: Theme.of(dialogContext).textTheme.bodyLarge,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                    child: const Text('Decline'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 48,
                  child: FilledButton(
                    onPressed: () => Navigator.of(dialogContext).pop(true),
                    child: const Text('Allow Accessibility Service'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _editRule([LockRule? rule]) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => LockRuleEditorPage(service: widget.service, rule: rule),
      ),
    );
    if (mounted) await _refresh();
  }

  Future<void> _deleteRule(LockRule rule) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.delete_outline_rounded),
        title: Text('Delete ${rule.name}?'),
        content: const Text(
          'This removes the rule and its scheduled app blocking. Your blocked-open history stays on this device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete rule'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    try {
      await widget.service.deleteRule(rule.id);
      if (mounted) await _refresh();
    } on StateError catch (error) {
      if (mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text(error.message.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<_LockInOverview>(
        future: _overview,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: Semantics(
                label: 'Loading Lock In',
                child: WavyCircularProgressIndicator(
                  size: 64,
                  amplitude: 3,
                  frequency: 8,
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Lock In could not load: ${snapshot.error}'),
              ),
            );
          }
          final overview = snapshot.requireData;
          if (!overview.supported) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text('Lock In is available on Android.'),
              ),
            );
          }
          final enabledRules = overview.rules.where((rule) => rule.enabled);
          final protectedApps = {
            for (final rule in enabledRules)
              ...rule.apps.map((app) => app.identifier),
          };
          final blockedOpens = overview.attempts.values.fold(
            0,
            (total, count) => total + count,
          );
          return RefreshIndicator.noSpinner(
            onRefresh: _refresh,
            child: CustomScrollView(
              slivers: [
                const SliverAppBar.large(pinned: true, title: Text('Lock In')),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
                  sliver: SliverList.list(
                    children: [
                      if (overview.permission != BlockPermissionStatus.granted)
                        _PermissionCard(
                          status: overview.permission!,
                          setupStarted: _permissionSetupStarted,
                          onGrant: _requestPermission,
                        )
                      else ...[
                        _DashboardHero(
                          activeRules: enabledRules.length,
                          protectedApps: protectedApps.length,
                        ),
                        const SizedBox(height: 28),
                        _SectionHeading(
                          title: 'Your focus, in view',
                          subtitle:
                              'A private year of activity, saved on this device.',
                        ),
                        const SizedBox(height: 14),
                        _ActivityCard(
                          attempts: overview.attempts,
                          totalAttempts: blockedOpens,
                          selectedDate: _selectedActivityDate,
                          selectedCount: _selectedActivityCount,
                          onDaySelected: (date, count) {
                            setState(() {
                              _selectedActivityDate = date;
                              _selectedActivityCount = count;
                            });
                          },
                        ),
                        const SizedBox(height: 30),
                        _SectionHeading(
                          title: 'Focus plans',
                          subtitle: overview.rules.isEmpty
                              ? 'Build a routine that protects your attention.'
                              : '${overview.rules.length} ${overview.rules.length == 1 ? 'plan' : 'plans'} configured',
                          trailing: overview.rules.isNotEmpty
                              ? TextButton.icon(
                                  onPressed: () => _editRule(),
                                  icon: const Icon(Icons.add_rounded),
                                  label: const Text('Add'),
                                )
                              : null,
                        ),
                        const SizedBox(height: 14),
                        if (overview.rules.isEmpty)
                          _EmptyRulesCard(onCreateRule: () => _editRule()),
                        for (final entry in overview.rules.indexed) ...[
                          _RuleCard(
                            rule: entry.$2,
                            onEdit: () => _editRule(entry.$2),
                            onDelete: () => _deleteRule(entry.$2),
                          ),
                          if (entry.$1 < overview.rules.length - 1)
                            SizedBox(
                              key: ValueKey('lock-in-rule-gap-${entry.$2.id}'),
                              height: 10,
                            ),
                        ],
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PermissionCard extends StatelessWidget {
  const _PermissionCard({
    required this.status,
    required this.setupStarted,
    required this.onGrant,
  });

  final BlockPermissionStatus status;
  final bool setupStarted;
  final VoidCallback onGrant;

  @override
  Widget build(BuildContext context) {
    final restricted = status == BlockPermissionStatus.restricted;
    return Container(
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Icon(
              Icons.lock_clock_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              'Finish Android setup',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: .w800),
            ),
            const SizedBox(height: 8),
            Text(
              restricted
                  ? 'Android has restricted the required app-blocking permission.'
                  : setupStarted
                  ? 'Lock In still needs a system setting. Android will open whichever is missing: Accessibility Service to detect selected apps, or Alarms & reminders to run schedules.'
                  : 'Lock In uses Accessibility Service to detect selected apps and Alarms & reminders to run schedules. We’ll open the first setting that needs attention.',
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: restricted ? null : onGrant,
              child: Text(
                setupStarted
                    ? 'Review Android settings'
                    : 'Set up focus blocking',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardHero extends StatelessWidget {
  const _DashboardHero({
    required this.activeRules,
    required this.protectedApps,
  });

  final int activeRules;
  final int protectedApps;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hasPlan = activeRules > 0;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: .96, end: 1),
      duration: const Duration(milliseconds: 520),
      curve: Curves.easeOutCubic,
      builder: (context, scale, child) => Transform.scale(
        scale: scale,
        alignment: Alignment.topCenter,
        child: child,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: ShapeDecoration(
          color: colors.primaryContainer,
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    Icons.hourglass_bottom_rounded,
                    color: colors.primary,
                  ),
                ),
                const Spacer(),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 280),
                  child: _StatusPill(
                    key: ValueKey(hasPlan),
                    label: hasPlan ? 'READY TO FOCUS' : 'YOUR SPACE',
                    icon: hasPlan
                        ? Icons.check_circle_rounded
                        : Icons.spa_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              hasPlan
                  ? 'Make room for\nwhat matters.'
                  : 'Make space for\nwhat matters.',
              style: textTheme.headlineMedium?.copyWith(
                color: colors.onPrimaryContainer,
                fontWeight: FontWeight.w700,
                height: 1.06,
                letterSpacing: -.7,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              hasPlan
                  ? 'Your focus plans are ready when you are.'
                  : 'Set a gentle boundary around the apps that pull you away.',
              style: textTheme.bodyLarge?.copyWith(
                color: colors.onPrimaryContainer.withValues(alpha: .78),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                _HeroMetric(
                  icon: Icons.event_repeat_rounded,
                  value: activeRules,
                  label: 'enabled plans',
                ),
                const SizedBox(width: 20),
                _HeroMetric(
                  icon: Icons.shield_outlined,
                  value: protectedApps,
                  label: 'apps protected',
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({super.key, required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: ShapeDecoration(
        color: colors.surface.withValues(alpha: .62),
        shape: const StadiumBorder(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: colors.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w700,
              letterSpacing: .35,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  const _HeroMetric({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      label: '$value $label',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: colors.onPrimaryContainer.withValues(alpha: .72),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: value.toDouble()),
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOutCubic,
                builder: (context, current, _) => Text(
                  current.round().toString(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colors.onPrimaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.onPrimaryContainer.withValues(alpha: .72),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -.2,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({
    required this.attempts,
    required this.totalAttempts,
    required this.selectedDate,
    required this.selectedCount,
    required this.onDaySelected,
  });

  final Map<DateTime, int> attempts;
  final int totalAttempts;
  final DateTime? selectedDate;
  final int? selectedCount;
  final void Function(DateTime, int) onDaySelected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final localizations = MaterialLocalizations.of(context);
    final selectionText = selectedDate == null
        ? 'Tap a day to explore your activity'
        : '${localizations.formatMediumDate(selectedDate!)} · ${selectedCount ?? 0} ${selectedCount == 1 ? 'blocked open' : 'blocked opens'}';
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubicEmphasized,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: ShapeDecoration(
        color: colors.surfaceContainerLow,
        shape: RoundedSuperellipseBorder(
          side: BorderSide(color: colors.outlineVariant.withValues(alpha: .55)),
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$totalAttempts',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'blocked opens in the last year',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.insights_rounded, color: colors.primary),
            ],
          ),
          const SizedBox(height: 20),
          Semantics(
            label: 'Blocked app activity calendar',
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: AttemptHeatmap(
                counts: attempts,
                onDaySelected: onDaySelected,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.swipe_rounded,
                size: 16,
                color: colors.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Text(
                'Swipe to explore the year',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: Text(
              selectionText,
              key: ValueKey(selectionText),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: colors.onSurfaceVariant),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Less', style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(width: 8),
              for (final opacity in [.10, .28, .48, .7, 1.0]) ...[
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Color.lerp(
                      colors.surfaceContainerHighest,
                      colors.primary,
                      opacity,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 4),
              ],
              Text('More', style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyRulesCard extends StatelessWidget {
  const _EmptyRulesCard({required this.onCreateRule});

  final VoidCallback onCreateRule;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: ShapeDecoration(
        color: colors.surfaceContainerLow,
        shape: RoundedSuperellipseBorder(
          side: BorderSide(color: colors.outlineVariant.withValues(alpha: .65)),
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.add_task_rounded, color: colors.primary, size: 28),
          const SizedBox(height: 14),
          Text(
            'Start with one small boundary',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            'Choose the apps and hours you want to keep clear for focused work.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: onCreateRule,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Create a focus plan'),
          ),
        ],
      ),
    );
  }
}

class _RuleCard extends StatelessWidget {
  const _RuleCard({
    required this.rule,
    required this.onEdit,
    required this.onDelete,
  });

  final LockRule rule;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final active = rule.isActiveAt(DateTime.now());
    final start = TimeOfDay(
      hour: rule.startMinutes ~/ 60,
      minute: rule.startMinutes % 60,
    ).format(context);
    final end = TimeOfDay(
      hour: rule.endMinutes ~/ 60,
      minute: rule.endMinutes % 60,
    ).format(context);
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      label: '${rule.name}, ${rule.apps.length} apps, $start to $end',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubicEmphasized,
        clipBehavior: Clip.hardEdge,
        decoration: ShapeDecoration(
          color: active ? colors.primaryContainer : colors.surfaceContainer,
          shape: RoundedSuperellipseBorder(
            side: BorderSide(
              color: active ? colors.primary : colors.outlineVariant,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Material(
          type: .transparency,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  rule.name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontWeight: .w700),
                ),
                subtitle: Text(
                  '${rule.apps.length} apps · $start–$end${rule.isOvernight ? ' next day' : ''}${active ? ' · Active' : ''}',
                ),
              ),
              if (active)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: ShapeDecoration(
                      color: colors.primary.withValues(alpha: .12),
                      shape: RoundedSuperellipseBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: colors.onPrimaryContainer,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'This rule is active and cannot be changed until it ends.',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: colors.onPrimaryContainer,
                                  fontWeight: .w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: active ? null : onEdit,
                        icon: const Icon(Icons.edit_outlined),
                        label: const Text('Edit rule'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: colors.error,
                        ),
                        onPressed: active ? null : onDelete,
                        icon: const Icon(Icons.delete_outline_rounded),
                        label: const Text('Delete rule'),
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
  }
}

class _LockInOverview {
  const _LockInOverview({
    required this.permission,
    required this.rules,
    required this.attempts,
  }) : supported = true;

  const _LockInOverview.unsupported()
    : supported = false,
      permission = null,
      rules = const [],
      attempts = const {};

  final bool supported;
  final BlockPermissionStatus? permission;
  final List<LockRule> rules;
  final Map<DateTime, int> attempts;
}

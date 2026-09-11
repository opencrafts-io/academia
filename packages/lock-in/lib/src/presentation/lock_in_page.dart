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
        from: now.subtract(const Duration(days: 83)),
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
    setState(() {
      _permissionSetupStarted = true;
    });
    await widget.service.requestPermission();
    if (mounted) await _refresh();
  }

  Future<void> _editRule([LockRule? rule]) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => LockRuleEditorPage(service: widget.service, rule: rule),
      ),
    );
    if (mounted) await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FutureBuilder<_LockInOverview>(
        future: _overview,
        builder: (context, snapshot) =>
            snapshot.data?.permission == BlockPermissionStatus.granted
            ? FloatingActionButton.extended(
                onPressed: () => _editRule(),
                icon: const Icon(Icons.add_rounded),
                label: const Text('New rule'),
              )
            : const SizedBox.shrink(),
      ),
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
          return RefreshIndicator.noSpinner(
            onRefresh: _refresh,
            child: CustomScrollView(
              slivers: [
                const SliverAppBar.large(pinned: true, title: Text('Lock In')),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 112),
                  sliver: SliverList.list(
                    children: [
                      if (overview.permission != BlockPermissionStatus.granted)
                        _PermissionCard(
                          status: overview.permission!,
                          setupStarted: _permissionSetupStarted,
                          onGrant: _requestPermission,
                        )
                      else ...[
                        Text(
                          'Recovery activity',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(fontWeight: .w800),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: ShapeDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainer,
                            shape: RoundedSuperellipseBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              AttemptHeatmap(counts: overview.attempts),
                              const SizedBox(height: 12),
                              Text(
                                'Every square is a locally stored blocked launch. No activity leaves this device.',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          'Your rules',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(fontWeight: .w800),
                        ),
                        const SizedBox(height: 8),
                        if (overview.rules.isEmpty)
                          const Card(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'No rules yet. Create one to block distracting apps during a recurring time window.',
                              ),
                            ),
                          ),
                        for (final rule in overview.rules)
                          _RuleCard(
                            rule: rule,
                            onEdit: () => _editRule(rule),
                            onDelete: () async {
                              final messenger = ScaffoldMessenger.of(context);
                              try {
                                await widget.service.deleteRule(rule.id);
                                if (mounted) {
                                  await _refresh();
                                }
                              } on StateError catch (error) {
                                if (mounted) {
                                  messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(error.message.toString()),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
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
              'Set up Lock In',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: .w800),
            ),
            const SizedBox(height: 8),
            Text(
              restricted
                  ? 'Android has restricted the required app-blocking permission.'
                  : setupStarted
                  ? 'Android grants Accessibility and Alarms & reminders separately. Continue setup until the New rule button appears.'
                  : 'Allow Accessibility and alarm permissions so Android can enforce your schedules.',
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: restricted ? null : onGrant,
              child: Text(
                setupStarted ? 'Continue setup' : 'Allow app blocking',
              ),
            ),
          ],
        ),
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
      button: !active,
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
          child: InkWell(
            onTap: active ? null : onEdit,
            child: ListTile(
              title: Text(
                rule.name,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: .w700),
              ),
              subtitle: Text(
                '${rule.apps.length} apps · $start–$end${rule.isOvernight ? ' next day' : ''}${active ? ' · Active' : ''}',
              ),
              trailing: IconButton(
                tooltip: active
                    ? 'Active rules cannot be removed'
                    : 'Delete rule',
                onPressed: active ? null : onDelete,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ),
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

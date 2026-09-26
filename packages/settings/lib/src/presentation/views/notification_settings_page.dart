import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permissions/permissions.dart';
import 'package:settings/src/presentation/cubit/notification_preferences_cubit.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage>
    with WidgetsBindingObserver {
  bool get _supportsNotifications =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  bool get _supportsPreciseAlarms =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _supportsNotifications) {
      context.read<NotificationPreferencesCubit>().refresh();
    }
  }

  Future<void> _handleNotificationAction(PermissionStatus? status) async {
    final preferences = context.read<NotificationPreferencesCubit>();
    if (status == PermissionStatus.granted ||
        status == PermissionStatus.permanentlyDenied) {
      await preferences.openSystemSettings();
      return;
    }

    await const NotificationPermissionRoute().push(context);
    if (mounted) {
      await preferences.refresh();
    }
  }

  Future<void> _handlePreciseAlarmAction(PermissionStatus? status) async {
    final preferences = context.read<NotificationPreferencesCubit>();
    if (status == PermissionStatus.permanentlyDenied) {
      await preferences.openSystemSettings();
      return;
    }
    await preferences.requestPreciseAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Notifications'),
            pinned: true,
            floating: true,
          ),
          SliverPadding(
            padding: const .all(16),
            sliver: SliverToBoxAdapter(
              child: _supportsNotifications
                  ? BlocBuilder<
                      NotificationPreferencesCubit,
                      NotificationPreferencesState
                    >(
                      builder: (context, state) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _NotificationStatusHero(
                            status: state.notifications,
                            isLoading: state.isLoading,
                            onPressed: () =>
                                _handleNotificationAction(state.notifications),
                          ),
                          const SizedBox(height: 20),
                          if (_supportsPreciseAlarms)
                            _PreciseReminderCard(
                              status: state.preciseAlarms,
                              isLoading: state.isLoading,
                              onPressed: () => _handlePreciseAlarmAction(
                                state.preciseAlarms,
                              ),
                            ),
                          if (_supportsPreciseAlarms)
                            const SizedBox(height: 20),
                          Text(
                            'You decide which alerts reach you. We only ask for '
                            'the device access needed to deliver reminders you use.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    )
                  : const _UnsupportedNotificationSettings(),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationStatusHero extends StatefulWidget {
  const _NotificationStatusHero({
    required this.status,
    required this.isLoading,
    required this.onPressed,
  });

  final PermissionStatus? status;
  final bool isLoading;
  final Future<void> Function() onPressed;

  @override
  State<_NotificationStatusHero> createState() =>
      _NotificationStatusHeroState();
}

class _NotificationStatusHeroState extends State<_NotificationStatusHero>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController =
      AnimationController.unbounded(vsync: this, value: 1);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _playEntranceMotion());
  }

  @override
  void didUpdateWidget(covariant _NotificationStatusHero oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) {
      _playEntranceMotion();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _playEntranceMotion() {
    if (!mounted || MediaQuery.of(context).disableAnimations) {
      _scaleController.value = 1;
      return;
    }
    _scaleController
      ..stop()
      ..value = .94
      ..animateWith(
        SpringSimulation(
          const SpringDescription(mass: .8, stiffness: 520, damping: 22),
          .94,
          1,
          0,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final content = _NotificationStatusContent.from(widget.status);

    return AnimatedBuilder(
      animation: _scaleController,
      builder: (context, child) => Transform.scale(
        scale: _scaleController.value.clamp(.9, 1.08).toDouble(),
        child: child,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: colorScheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Padding(
          padding: const .all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: content.isEnabled
                      ? colorScheme.secondaryContainer
                      : colorScheme.tertiaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  content.icon,
                  color: content.isEnabled
                      ? colorScheme.onSecondaryContainer
                      : colorScheme.onTertiaryContainer,
                  size: 32,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                content.title,
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(fontWeight: .w700),
              ),
              const SizedBox(height: 8),
              Text(
                content.detail,
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: widget.isLoading ? null : widget.onPressed,
                icon: Icon(content.actionIcon),
                label: Text(content.actionLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreciseReminderCard extends StatelessWidget {
  const _PreciseReminderCard({
    required this.status,
    required this.isLoading,
    required this.onPressed,
  });

  final PermissionStatus? status;
  final bool isLoading;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEnabled = status == PermissionStatus.granted;
    final needsSystemSettings = status == PermissionStatus.permanentlyDenied;
    final label = isEnabled
        ? 'Enabled'
        : needsSystemSettings
        ? 'Open system settings'
        : 'Enable';

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const .all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.alarm_rounded, color: colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Time-sensitive reminders',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: .w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              isEnabled ? 'Reminders can arrive at their scheduled time.' : 'Optional on Android. Enable this for more accurate class, exam, and to-do reminders.',
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: isLoading || isEnabled ? null : onPressed,
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

class _UnsupportedNotificationSettings extends StatelessWidget {
  const _UnsupportedNotificationSettings();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: colorScheme.surfaceContainer,
      child: Padding(
        padding: const .all(24),
        child: Text(
          'Notification delivery is available on Academia mobile apps. Your '
          'preferences remain safe on this device.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}

class _NotificationStatusContent {
  const _NotificationStatusContent({
    required this.title,
    required this.detail,
    required this.actionLabel,
    required this.icon,
    required this.actionIcon,
    required this.isEnabled,
  });

  factory _NotificationStatusContent.from(PermissionStatus? status) {
    return switch (status) {
      PermissionStatus.granted => const _NotificationStatusContent(
        title: 'Notifications are on',
        detail: 'You can receive important academic updates and reminders.',
        actionLabel: 'Review in system settings',
        icon: Icons.notifications_active_rounded,
        actionIcon: Icons.tune_rounded,
        isEnabled: true,
      ),
      PermissionStatus.permanentlyDenied => const _NotificationStatusContent(
        title: 'Notifications need device access',
        detail: 'Your phone has blocked notifications for Academia. You can enable them in system settings.',
        actionLabel: 'Open system settings',
        icon: Icons.notifications_off_rounded,
        actionIcon: Icons.open_in_new_rounded,
        isEnabled: false,
      ),
      _ => const _NotificationStatusContent(
        title: 'Stay in the loop',
        detail: 'Turn on notifications for class changes, exam reminders, and your to-dos.',
        actionLabel: 'Turn on notifications',
        icon: Icons.notifications_none_rounded,
        actionIcon: Icons.notifications_rounded,
        isEnabled: false,
      ),
    };
  }

  final String title;
  final String detail;
  final String actionLabel;
  final IconData icon;
  final IconData actionIcon;
  final bool isEnabled;
}

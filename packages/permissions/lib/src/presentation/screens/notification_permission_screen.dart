import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permissions/src/application/permission_capability.dart';
import 'package:permissions/src/presentation/cubit/permission_cubit.dart';
import 'package:permissions/src/presentation/cubit/permission_state.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:vibration/vibration.dart';

class NotificationPermissionScreen extends StatefulWidget {
  const NotificationPermissionScreen({super.key});

  @override
  State<NotificationPermissionScreen> createState() =>
      _NotificationPermissionScreenState();
}

class _NotificationPermissionScreenState
    extends State<NotificationPermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            floating: true,
            pinned: true,
            snap: true,
            automaticallyImplyLeading: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: MultiSliver(
              children: [
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: Text(
                        'Turn on notifications?',
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    Image.asset(
                      'assets/icons/notification_bell.png',
                      package: 'permissions',
                      height: 80,
                      width: 80,
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Text(
                  'Don’t miss important updates like class schedules, '
                  'school communication, checkout details and more.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Be sure to also enable alarms and reminders for '
                  'time sensitive alerts like todos and class schedules',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 28),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () => _requestNotifications(context),
                        child: const Text('Yes, notify me'),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () => context.pop(),
                        child: const Text('Skip'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _requestNotifications(BuildContext context) async {
    if (await Vibration.hasVibrator()) {
      await Vibration.vibrate(duration: 128);
    }
    if (!context.mounted) return;

    final permissions = context.read<PermissionCubit>();
    await permissions.check(PermissionCapability.notifications);
    if (!context.mounted) return;

    if (permissions.state is PermissionPermanentlyDenied) {
      await showAdaptiveDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog.adaptive(
          title: const Text('Allow permission'),
          content: const Text(
            'You previously denied notification permission. Re-enable it in '
            'your phone settings to receive important updates.',
          ),
          actions: [
            FilledButton.icon(
              onPressed: () async {
                await permissions.openSystemSettings();
                if (dialogContext.mounted) dialogContext.pop();
              },
              label: const Text('Enable'),
              icon: const Icon(Icons.notifications),
            ),
            TextButton(
              onPressed: () => dialogContext.pop(),
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
      return;
    }

    await permissions.request(PermissionCapability.notifications);
    if (!context.mounted) return;

    if (Platform.isAndroid) {
      await permissions.request(PermissionCapability.preciseAlarms);
    }
    if (context.mounted) context.pop();
  }
}

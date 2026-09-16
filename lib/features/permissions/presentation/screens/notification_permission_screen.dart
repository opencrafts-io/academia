import 'dart:io';

import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:academia/features/permissions/permissions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
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
            padding: EdgeInsets.all(16),
            sliver: MultiSliver(
              children: [
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: Text(
                        "Turn on notifications?",
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    Assets.icons.notificationIconBell.image(
                      height: 80,
                      width: 80,
                    ),
                  ],
                ),
                SizedBox(height: 22),
                Text(
                  "Don't miss important updates like class schedules, "
                  "school communication, checkout details and more..",
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                SizedBox(height: 8),
                Text(
                  "Be sure to also enable alarms and reminders for "
                  "time sensitive alerts like todos and class schedules",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                SizedBox(height: 28),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () async {
                          if (await Vibration.hasVibrator()) {
                            Vibration.vibrate(duration: 128);
                          }

                          if (!context.mounted) return;

                          // Check both permissions
                          await context.read<PermissionCubit>().checkPermission(
                            AppPermission.notification,
                          );

                          if (!context.mounted) return;

                          if (context.read<PermissionCubit>().state
                              is PermissionPermanentlyDenied) {
                            return showAdaptiveDialog(
                              context: context,
                              builder: (context) => AlertDialog.adaptive(
                                title: const Text("Allow permission"),
                                content: const Text(
                                  "You've previously denied permissions "
                                  "to send you notifications. You may miss important updates "
                                  "please re-enable them on the app's phone settings page.",
                                ),
                                actions: [
                                  FilledButton.icon(
                                    onPressed: () {
                                      openAppSettings();
                                      context.pop();
                                    },
                                    label: const Text("Enable"),
                                    icon: const Icon(Icons.notifications),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                ],
                              ),
                            );
                          }

                          // Request Notification permission
                          await context
                              .read<PermissionCubit>()
                              .requestPermission(AppPermission.notification);

                          // Also request Precise Alarm permission for timing accuracy
                          if (Platform.isAndroid) {
                            if (context.mounted) {
                              await context
                                  .read<PermissionCubit>()
                                  .requestPermission(
                                    AppPermission.preciseAlarm,
                                  );
                            }
                          }

                          if (!context.mounted) return;
                          context.pop();
                        },
                        child: Text("Yes, notify me"),
                      ),

                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () {
                          context.pop();
                        },
                        child: Text("Skip"),
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
}

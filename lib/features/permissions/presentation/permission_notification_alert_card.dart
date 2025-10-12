import 'package:academia/features/features.dart';
import 'package:academia/features/permissions/permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibration/vibration.dart';
import 'package:animated_emoji/animated_emoji.dart';

class PermissionNotificationAlertCard extends StatelessWidget {
  const PermissionNotificationAlertCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PermissionCubit, PermissionState>(
          listener: (context, state) {
            final profileState = context.read<ProfileBloc>().state;
            if (state is PermissionGranted &&
                profileState is ProfileLoadedState) {
              context.read<NotificationBloc>().add(
                SetUserDataEvent(
                  userId: profileState.profile.id,
                  name: profileState.profile.name,
                  email: profileState.profile.email,
                ),
              );
            }
          },
        ),
      ],
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Card.filled(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: Theme.of(context).colorScheme.primaryContainer,
          child: ListTile(
            leading:AnimatedEmoji(AnimatedEmojis.headNod),
            title: Text("Get message notifications"),
            subtitle: Text(
              "Turn on notifications so that you never miss any updates",
            ),
            subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
            onTap: () async {
              if (await Vibration.hasVibrator()) {
                Vibration.vibrate(duration: 128);
              }

              if (!context.mounted) return;
              await context.read<PermissionCubit>().checkPermission(
                AppPermission.notification,
              );
              if (!context.mounted) return;
              if (context.read<PermissionCubit>().state
                  is PermissionPermanentlyDenied) {
                return showAdaptiveDialog(
                  context: context,
                  builder: (context) => AlertDialog.adaptive(
                    title: Text("Allow permission"),
                    content: Text(
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
                        label: Text("Enable"),
                        icon: Icon(Icons.notifications),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text("Cancel"),
                      ),
                    ],
                  ),
                );
              }

              context.read<PermissionCubit>().requestPermission(
                AppPermission.notification,
              );
            },
          ),
        ),
      ),
    );
  }
}

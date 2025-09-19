import 'package:academia/features/features.dart';
import 'package:academia/features/permissions/permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';

class PermissionNotificationAlertCard extends StatelessWidget {
  const PermissionNotificationAlertCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoadedState) {
              context.read<NotificationBloc>().add(
                SetUserDataEvent(
                  userId: state.profile.id,
                  name: state.profile.name,
                  email: state.profile.email,
                ),
              );
            }
          },
        ),
      ],
      child: Card.filled(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: ListTile(
          leading: Icon(Icons.notifications),
          title: Text("Get message notifications"),
          subtitle: Text(
            "Make sure you know when you have new important messages",
          ),
          subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
          onTap: () async {
            context.read<PermissionCubit>().requestPermission(
              AppPermission.notification,
            );

            if (await Vibration.hasVibrator()) {
              Vibration.vibrate(duration: 128);
            }
          },
        ),
      ),
    );
  }
}

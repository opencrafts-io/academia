import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/notifications/notifications.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is NotificationsLoadedState) {
                return PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'mark_all_read':
                        context.read<NotificationBloc>().add(
                              const MarkAllNotificationsAsReadEvent(),
                            );
                        break;
                      case 'clear_all':
                        context.read<NotificationBloc>().add(
                              const ClearAllNotificationsEvent(),
                            );
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'mark_all_read',
                      child: Text('Mark all as read'),
                    ),
                    const PopupMenuItem(
                      value: 'clear_all',
                      child: Text('Clear all'),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotificationsLoadedState) {
            if (state.notifications.isEmpty) {
              return const Center(
                child: Text('No notifications yet'),
              );
            }
            return ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                final notification = state.notifications[index];
                return ListTile(
                  title: Text(notification.title),
                  subtitle: Text(notification.body),
                  trailing: notification.isRead
                      ? null
                      : const Icon(Icons.circle, size: 12, color: Colors.blue),
                  onTap: () {
                    if (!notification.isRead) {
                      context.read<NotificationBloc>().add(
                            MarkNotificationAsReadEvent(
                              notificationId: notification.id,
                            ),
                          );
                    }
                  },
                );
              },
            );
          } else if (state is NotificationErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<NotificationBloc>().add(
                            const LoadNotificationsEvent(),
                          );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('No notifications'));
        },
      ),
    );
  }
}


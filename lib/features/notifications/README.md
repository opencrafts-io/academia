# Notifications Feature

This feature provides a complete notification system using OneSignal for push notifications and local storage for notification management.

## Features

- ✅ OneSignal integration for push notifications
- ✅ Local notification storage and management
- ✅ Mark notifications as read/unread
- ✅ Delete individual notifications
- ✅ Clear all notifications
- ✅ Notification count tracking
- ✅ Unread count tracking
- ✅ Permission management
- ✅ Local notification testing

## Architecture

The feature follows Clean Architecture principles with:

- **Domain Layer**: Entities, repositories, and use cases
- **Data Layer**: Remote and local data sources, models, and repository implementation
- **Presentation Layer**: BLoC for state management, views, and widgets

## Usage

### 1. Initialize OneSignal

```dart
// In your app initialization
final notificationBloc = context.read<NotificationBloc>();
notificationBloc.add(InitializeOneSignalEvent(appId: 'YOUR_ONESIGNAL_APP_ID'));
```

### 2. Load Notifications

```dart
// Load notifications from local storage
notificationBloc.add(LoadNotificationsEvent());
```

### 3. Listen to Notification States

```dart
BlocBuilder<NotificationBloc, NotificationState>(
  builder: (context, state) {
    if (state is NotificationsLoadedState) {
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
          );
        },
      );
    }
    return const CircularProgressIndicator();
  },
)
```

### 4. Mark Notification as Read

```dart
notificationBloc.add(MarkNotificationAsReadEvent(notificationId: 'notification_id'));
```

### 5. Get Notification Count

```dart
notificationBloc.add(GetNotificationCountEvent());

// Listen to count
BlocBuilder<NotificationBloc, NotificationState>(
  builder: (context, state) {
    if (state is NotificationCountLoadedState) {
      return Text('${state.count} notifications');
    }
    return const Text('0');
  },
)
```

### 6. Get Unread Count

```dart
notificationBloc.add(GetUnreadCountEvent());

// Listen to unread count
BlocBuilder<NotificationBloc, NotificationState>(
  builder: (context, state) {
    if (state is UnreadCountLoadedState) {
      return NotificationBadge(count: state.count);
    }
    return const NotificationBadge(count: 0);
  },
)
```

### 7. Send Local Notification (for testing)

```dart
notificationBloc.add(SendLocalNotificationEvent(
  title: 'Test Notification',
  body: 'This is a test notification',
  data: {'key': 'value'},
));
```

### 8. Manage Permissions

```dart
// Get permission status
notificationBloc.add(GetNotificationPermissionEvent());

// Set permission
notificationBloc.add(SetNotificationPermissionEvent(enabled: true));
```

## Available Events

- `InitializeOneSignalEvent(appId: String)`
- `LoadNotificationsEvent()`
- `MarkNotificationAsReadEvent(notificationId: String)`
- `MarkAllNotificationsAsReadEvent()`
- `DeleteNotificationEvent(notificationId: String)`
- `ClearAllNotificationsEvent()`
- `GetNotificationCountEvent()`
- `GetUnreadCountEvent()`
- `SetNotificationPermissionEvent(enabled: bool)`
- `GetNotificationPermissionEvent()`
- `SendLocalNotificationEvent(title: String, body: String, data?: Map)`

## Available States

- `NotificationInitialState`
- `NotificationLoadingState`
- `NotificationInitializedState`
- `NotificationsLoadedState(notifications: List<NotificationEntity>)`
- `NotificationCountLoadedState(count: int)`
- `UnreadCountLoadedState(count: int)`
- `NotificationPermissionSetState(enabled: bool)`
- `NotificationPermissionLoadedState(enabled: bool)`
- `LocalNotificationSentState`
- `NotificationErrorState(message: String)`

## Widgets

### NotificationBadge

A widget to display notification count as a badge:

```dart
NotificationBadge(
  count: 5,
  size: 16.0,
  color: Colors.red,
)
```

### NotificationItem

A widget to display a single notification:

```dart
NotificationItem(
  notification: notificationEntity,
  onTap: () {
    // Handle tap
  },
  onDelete: () {
    // Handle delete
  },
)
```

## Setup

1. Add OneSignal App ID to your configuration
2. Initialize the NotificationBloc in your app
3. Request notification permissions
4. Handle notification clicks and foreground display

## Error Handling

The feature includes comprehensive error handling with custom `NotificationFailure` for OneSignal operations and `CacheFailure` for local storage operations.

## Database

Notifications are stored locally using Drift database with the `NotificationTable` schema. The database automatically handles JSON serialization for notification data.


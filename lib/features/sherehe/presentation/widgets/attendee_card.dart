import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class AttendeeCard extends StatelessWidget {
  final Attendee attendee;
  final bool isHost;

  const AttendeeCard({
    super.key,
    required this.attendee,
    this.isHost = false,
  });

  String _getInitials(String? firstName, String? lastName) {
    String initials = '';
    if (firstName != null && firstName.isNotEmpty) {
      initials += firstName[0].toUpperCase();
    }
    if (lastName != null && lastName.isNotEmpty) {
      initials += lastName[0].toUpperCase();
    }
    return initials.isEmpty ? '?' : initials;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Color avatarColor = isHost ? colorScheme.primary : colorScheme.secondary;
    Color onAvatarColor = isHost ? colorScheme.onPrimary : colorScheme.onSecondary;
    Widget? trailingWidget;

    if (isHost) {
      trailingWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'HOST',
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    } else {
      trailingWidget = Icon(
        Icons.check_circle,
        color: colorScheme.primary,
        size: 20,
      );
    }

    final String initials = _getInitials(attendee.firstName, attendee.lastName);
    final String fullName = '${attendee.firstName} ${attendee.lastName}'.trim();
    final String status = isHost ? 'Organizer' : 'Attending';

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: avatarColor,
            child: Text(
              initials, // Use dynamically calculated initials
              style: TextStyle(
                color: onAvatarColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName.isNotEmpty ? fullName : 'Unknown',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  status,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          trailingWidget,
        ],
      ),
    );
  }
}
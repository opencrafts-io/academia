import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../../../../constants/constants.dart';

class AttendeeCard extends StatelessWidget {
  final Attendee attendee;
  final bool isHost;
  final VoidCallback? onTap;

  const AttendeeCard({
    super.key,
    required this.attendee,
    this.isHost = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    Color avatarColor = Theme.of(context).colorScheme.secondary;
    Color onAvatarColor = Theme.of(context).colorScheme.onSecondary;
    Widget? trailingWidget;

    if (isHost) {
      avatarColor = Theme.of(context).colorScheme.primary;
      onAvatarColor = Theme.of(context).colorScheme.onPrimary;
      trailingWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'HOST',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    } else {
      trailingWidget = Icon(
        Icons.check_circle,
        size: 20,
      );
    }

    String initials = attendee.firstName.isNotEmpty && attendee.lastName.isNotEmpty
        ? '${attendee.firstName[0]}${attendee.lastName[0]}'
        : attendee.firstName.isNotEmpty
        ? attendee.firstName[0]
        : '?';

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: ResponsiveBreakPoints.isMobile(context) ? 20 : 24,
            backgroundColor: avatarColor,
            child: Text(
              initials.toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveBreakPoints.isMobile(context) ? 14 : 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${attendee.firstName} ${attendee.lastName}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  isHost ? 'Organizer' : 'Attending',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (trailingWidget != null) trailingWidget,
        ],
      ),
    );
  }
}
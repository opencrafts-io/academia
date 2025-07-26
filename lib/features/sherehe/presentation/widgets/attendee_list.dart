import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

class AttendeesList extends StatelessWidget {
  final Event event;
  final List<Attendee> attendees;
  final int organizerId;

  const AttendeesList({
    super.key,
    required this.event,
    required this.attendees,
    required this.organizerId,
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
    final organizerAttendee = attendees.firstWhere(
          (attendee) => attendee.id == organizerId.toString(),
      orElse: () => Attendee(
        id: '',
        firstName: 'Unknown',
        lastName: 'Organizer',
        eventId: event.id,
        createdAt: '',
      ),
    );

    final otherAttendees = attendees.where((attendee) => attendee.id != organizerId.toString()).toList();

    List<Widget> columnChildren = [
      Text(
        'Who\'s Coming',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      const SizedBox(height: 16),
    ];

    if (organizerAttendee.id.isNotEmpty) {
      columnChildren.add(
        AttendeeCard(
          attendee: organizerAttendee,
          isHost: true,
        ),
      );
    }

    final int maxOtherAttendeesToShow = 3;
    final int otherAttendeesToShowCount = otherAttendees.length > maxOtherAttendeesToShow
        ? maxOtherAttendeesToShow
        : otherAttendees.length;

    columnChildren.addAll(
      otherAttendees.take(otherAttendeesToShowCount).map((attendee) => AttendeeCard(attendee: attendee)).toList(),
    );

    final int attendeesActuallyShown = (organizerAttendee.id.isNotEmpty ? 1 : 0) + otherAttendeesToShowCount;
    final int remainingCountBasedOnEventTotal = event.numberOfAttendees - attendeesActuallyShown;

    if (remainingCountBasedOnEventTotal > 0) {
      columnChildren.add(
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                height: 48,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        child: Text(
                          _getInitials(otherAttendees.elementAtOrNull(0)?.firstName, otherAttendees.elementAtOrNull(0)?.lastName),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        child: Text(
                          _getInitials(otherAttendees.elementAtOrNull(1)?.firstName, otherAttendees.elementAtOrNull(1)?.lastName),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onTertiary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 40,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          '+${remainingCountBasedOnEventTotal}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'and $remainingCountBasedOnEventTotal others are attending',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columnChildren,
    );
  }
}
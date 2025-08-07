import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

class AttendeesList extends StatelessWidget {
  final Event event;
  final List<Attendee> allAttendees;
  const AttendeesList({
    super.key,
    required this.event,
    required this.allAttendees,
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
    // Filter attendees specific to this event
    final List<Attendee> eventSpecificAttendees = allAttendees
        .where((attendee) => attendee.eventId == event.id)
        .toList();

    if (eventSpecificAttendees.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Who's Coming",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "You're the first one here!",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      );
    }

    final organizerAttendee = eventSpecificAttendees.firstWhere(
          (attendee) => attendee.id == event.organizerId.toString(),
      orElse: () => Attendee(
        id: '',
        firstName: 'Unknown',
        lastName: 'Organizer',
        eventId: event.id,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()
      ),
    );

    final otherAttendees = eventSpecificAttendees
        .where((attendee) => attendee.id != event.organizerId.toString())
        .toList();

    List<Widget> columnChildren = [
      Text(
        "Who's Coming",
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 16),
    ];

    if (organizerAttendee.id.isNotEmpty) {
      columnChildren.add(
        AttendeeCard(attendee: organizerAttendee, isHost: true),
      );
    }

    final int maxOtherAttendeesToShow = 4;
    final int otherAttendeesToShowCount = otherAttendees.length >
        maxOtherAttendeesToShow
        ? maxOtherAttendeesToShow
        : otherAttendees.length;

    columnChildren.addAll(
      otherAttendees
          .take(otherAttendeesToShowCount)
          .map((attendee) => AttendeeCard(attendee: attendee))
          .toList(),
    );

    final int attendeesActuallyShown =
        (organizerAttendee.id.isNotEmpty ? 1 : 0) + otherAttendeesToShowCount;
    final int remainingCountBasedOnEventTotal =
        event.numberOfAttendees - attendeesActuallyShown;

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
                        backgroundColor:
                        Theme.of(context).colorScheme.secondary,
                        child: Text(
                          otherAttendees.isNotEmpty
                              ? _getInitials(otherAttendees[0].firstName,
                              otherAttendees[0].lastName)
                              : '?',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (otherAttendees.length > 1) // Only show if > 1
                      Positioned(
                        left: 20,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor:
                          Theme.of(context).colorScheme.tertiary,
                          child: Text(
                            _getInitials(otherAttendees[1].firstName,
                                otherAttendees[1].lastName),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onTertiary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    // Avatar 3: Show remaining count
                    Positioned(
                      left: otherAttendees.length > 1 ? 40 : 20, // Adjust position
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          '+$remainingCountBasedOnEventTotal',
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
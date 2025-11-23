import 'package:academia/core/core.dart';
import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

class AttendeesList extends StatelessWidget {
  final Event event;
  final List<Attendee> allAttendees;
  final bool isAttendeesLoading;
  final String? userId;

  const AttendeesList({
    super.key,
    required this.event,
    required this.allAttendees,
    this.isAttendeesLoading = false,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    List<Attendee> sortedAttendees = List.from(allAttendees);

    return Column(
      spacing: 16.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Who's Coming",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (isAttendeesLoading)
          Center(child: SpinningScallopIndicator())
        else if (allAttendees.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Don't be boring,be the first to say you're going!",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          )
        else
          ...sortedAttendees.map((attendee) {
            final bool isHost = _isAttendeeHost(attendee);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: AttendeeCard(attendee: attendee, isHost: isHost),
            );
          }),
      ],
    );
  }

  bool _isAttendeeHost(Attendee attendee) {
    if (userId != null && userId == event.organizerId) {
      return true;
    }
    return false;
  }
}

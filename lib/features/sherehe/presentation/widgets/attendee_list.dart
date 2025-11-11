import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

class AttendeesList extends StatelessWidget {
  final Event event;
  final List<Attendee> allAttendees;
  final String? userId;

  const AttendeesList({
    super.key,
    required this.event,
    required this.allAttendees,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    if (allAttendees.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Who's Coming",
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
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
          ),
        ],
      );
    }

    List<Attendee> sortedAttendees = List.from(allAttendees);
    // sortedAttendees.sort((a, b) {
    //   bool aIsHost = _isAttendeeHost(a);
    //   bool bIsHost = _isAttendeeHost(b);
    //   if (aIsHost && !bIsHost) return -1;
    //   if (!aIsHost && bIsHost) return 1;
    //   return (a..id).compareTo(b.id);
    // });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Who's Coming (${sortedAttendees.length})",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
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
    if (userId != null &&
        userId == event.organizerId) {
      return true;
    }
    return false;
  }
}

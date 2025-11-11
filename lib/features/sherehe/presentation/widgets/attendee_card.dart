import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import '../../domain/domain.dart';

class AttendeeCard extends StatelessWidget {
  final Attendee attendee;
  final bool isHost;

  const AttendeeCard({super.key, required this.attendee, this.isHost = false});

  String _getInitials(String? firstName) {
    String initials = '';
    if (firstName != null && firstName.isNotEmpty) {
      initials += firstName[0].toUpperCase();
    }
    return initials.isEmpty ? '?' : initials;
  }

  @override
  Widget build(BuildContext context) {
    final String initials = _getInitials("Unknown"); // to be replaced with attendee first name when available
    final String fullName = "Unknown"; // to be replaced with attendee full name when available
    final String status = isHost ? 'Organizer' : 'Attending';

    return Container(
      // padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Theme.of(context).colorScheme.tertiaryContainer,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(initials),
        ),
        title: Text(fullName.isNotEmpty ? fullName : "Anonymous"),
        subtitle: Text(status),
        trailing: isHost ? Icon(Symbols.server_person) : null,
      ),
    );
  }
}


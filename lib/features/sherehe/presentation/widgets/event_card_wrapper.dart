import 'package:academia/features/sherehe/presentation/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/router/routes.dart';
import '../../domain/domain.dart';
import '../bloc/sherehe_home_bloc.dart';

class EventCardWrapper extends StatelessWidget {
  final Event event;
  const EventCardWrapper({super.key, required this.event});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShereheHomeBloc, ShereheHomeState>(
      buildWhen: (previous, current) {
        if (current is! EventLoaded) return false;
        if (previous is! EventLoaded) return true;

        final oldAttendees = previous.attendeesMap[event.id];
        final newAttendees = current.attendeesMap[event.id];

        return oldAttendees != newAttendees;
      },

      builder: (context, state) {
        List<String> attendeeUserNames = [];
        bool isLoading = true;
        if (state is EventLoaded) {
          final attendees = state.attendeesMap[event.id];
          if (attendees != null) {
            attendeeUserNames = attendees.map((a) => a.user!.username).toList();
            isLoading = false;
          }
        }
        return EventCard(
          event: event,
          attendees: attendeeUserNames,
          isAttendeesLoading: isLoading,
          onTap: () => ShereheDetailsRoute(eventId: event.id).push(context),
        );
      },
    );
  }
}

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
      // buildWhen: (previous, current) {
      //   if (current is! EventLoaded) return false;
      //   if (previous is! EventLoaded) return true;

      //   final oldAttendees = previous.attendeesMap[event.id];
      //   final newAttendees = current.attendeesMap[event.id];

      //   return oldAttendees != newAttendees;
      // },
      builder: (context, state) {
        List<String> attendeeNames = ['Wamalwa', 'Eugene'];
        int attendeeCount = 2;

        bool isLoading = true;

        if (state is EventLoaded) {
          // final attendees = ['Wamalwa', 'Eugene']; //state.attendeesMap[event.id];
          // if (attendees != null) {
          //   attendeeNames = attendees
          //       .map((a) => "${a.firstName} ${a.lastName}")
          //       .toList();
          //   isLoading = false;
          // }
        }

        return EventCard(
          imagePath: event.eventBannerImage!,
          title: event.eventName,
          location: event.eventLocation,
          date: event.eventDate,
          genres: event.eventGenre!.split(',').map((e) => e.trim()).toList(),
          attendees: attendeeNames,
          attendeesCount: attendeeCount,
          isAttendeesLoading: isLoading,
          onTap: () => ShereheDetailsRoute(eventId: event.id).push(context),
        );
      },
    );
  }
}

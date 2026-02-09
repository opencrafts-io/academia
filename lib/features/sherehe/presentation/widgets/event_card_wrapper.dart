import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/router/routes.dart';
import '../../domain/domain.dart';

class EventCardWrapper extends StatelessWidget {
  final Event event;

  const EventCardWrapper({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AttendeeBloc(getAttendee: sl())
            ..add(FetchAttendees(eventId: event.id)),
      child: BlocBuilder<AttendeeBloc, AttendeeState>(
        builder: (context, state) {
          List<String> attendeeUserNames = [];
          bool isLoading = true;

          if (state is AttendeeLoaded) {
            attendeeUserNames = state.attendees
                .map((a) => a.user?.username ?? 'Guest')
                .toList();
            isLoading = false;
          } else if (state is AttendeeError) {
            // Show empty avatar row + disable loading
            isLoading = false;
          }

          return EventCard(
            event: event,
            attendees: attendeeUserNames,
            isAttendeesLoading: isLoading,
            onTap: () => context.push(
              ShereheDetailsRoute(eventId: event.id).location,
              extra: event,
            ),
          );
        },
      ),
    );
  }
}

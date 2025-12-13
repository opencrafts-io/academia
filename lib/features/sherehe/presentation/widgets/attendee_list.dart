import 'package:academia/core/core.dart';
import 'package:academia/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/domain.dart';
import '../presentation.dart';

class AttendeesList extends StatelessWidget {
  final String eventId;
  final String organizerId;
  final String? userId;

  const AttendeesList({
    super.key,
    required this.eventId,
    required this.organizerId,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AttendeeBloc(getAttendee: sl())
            ..add(FetchAttendees(eventId: eventId)),
      child: Column(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Who's Coming",
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          BlocBuilder<AttendeeBloc, AttendeeState>(
            builder: (context, state) {
              if (state is AttendeeLoading) {
                return Center(child: SpinningScallopIndicator());
              } else if (state is AttendeeError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Failed to load attendees. Please try again later.",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                );
              } else if (state is AttendeeLoaded) {
                if (state.attendees.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Don't be boring,be the first to say you're going!",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ),
                  );
                } else {
                  state.attendees.map((attendee) {
                    final bool isHost = _isAttendeeHost(attendee);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: AttendeeCard(attendee: attendee, isHost: isHost),
                    );
                  });
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  bool _isAttendeeHost(Attendee attendee) {
    if (userId != null && userId == organizerId) {
      return true;
    }
    return false;
  }
}

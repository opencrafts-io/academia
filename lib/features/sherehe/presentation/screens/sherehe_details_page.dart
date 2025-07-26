import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants/constants.dart';
import '../presentation.dart';
import 'package:academia/injection_container.dart';

class ShereheDetailsPage extends StatelessWidget {
  final String eventId;

  const ShereheDetailsPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ShereheDetailsBloc>()
        ..add(LoadShereheDetails(eventId: eventId)),
      child: Scaffold(
        body: BlocBuilder<ShereheDetailsBloc, ShereheDetailsState>(
          builder: (context, state) {
            if (state is ShereheDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ShereheDetailsLoaded) {
              final event = state.event;
              final attendees = state.attendees;

              return CustomScrollView(
                slivers: [
                  EventDetailsHeader(event: event),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(ResponsiveBreakPoints.isMobile(context) ? 16.0 : 32.0),
                      child: Column(
                        children: [
                          EventAboutSection(event: event),
                          const SizedBox(height: 24),
                          AttendeesList(attendees: attendees, event: event, organizerId: event.organizerId),
                          const SizedBox(height: 32),
                          RsvpButton(onPressed: () {
                            // Handle RSVP logic here
                          }),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ShereheDetailsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error loading event details: ${state.message}'),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ShereheDetailsBloc>().add(LoadShereheDetails(eventId: eventId));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
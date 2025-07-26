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
      create: (context) =>
          sl<ShereheDetailsBloc>()..add(LoadShereheDetails(eventId: eventId)),
      child: Scaffold(
        body: BlocBuilder<ShereheDetailsBloc, ShereheDetailsState>(
          builder: (context, state) {
            if (state is ShereheDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ShereheDetailsLoaded) {
              final event = state.event;
              final allAttendees = state.attendees;

              return CustomScrollView(
                slivers: [
                  EventDetailsHeader(event: event),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(
                        ResponsiveBreakPoints.isMobile(context) ? 16.0 : 32.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EventAboutSection(event: event),
                          const SizedBox(height: 24),
                          AttendeesList(
                            event: event,
                            allAttendees: allAttendees,
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            // Make it full width like the custom widget likely was
                            height: ResponsiveBreakPoints.isMobile(context)
                                ? 50
                                : 56,
                            // Match height logic if needed
                            child: FilledButton(
                              onPressed:
                                  () {}, //TODO:Impliment logic for when button is pressed ie purchase ticket
                              child: const Text("I'm Going"),
                            ),
                          ),
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
                        // Retry loading the event details
                        context.read<ShereheDetailsBloc>().add(
                          LoadShereheDetails(eventId: eventId),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            // Return a default widget for other states (e.g., Initial)
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}


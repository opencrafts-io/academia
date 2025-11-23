import 'package:academia/config/config.dart';
import 'package:academia/constants/constants.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:academia/features/sherehe/sherehe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShereheDetailsPage extends StatefulWidget {
  final String eventId;
  const ShereheDetailsPage({super.key, required this.eventId});

  @override
  State<ShereheDetailsPage> createState() => _ShereheDetailsPageState();
}

class _ShereheDetailsPageState extends State<ShereheDetailsPage> {
  String? userId;

  @override
  void initState() {
    super.initState();

    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadedState) {
      userId = profileState.profile.id;
    } else {
      userId = null;
    }

    // Trigger event loading
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ShereheDetailsBloc>().add(
        LoadShereheDetails(eventId: widget.eventId),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<ShereheDetailsBloc, ShereheDetailsState>(
            builder: (context, state) {
              if (state is ShereheDetailsLoading) {
                return const Center(child: SpinningScallopIndicator());
              } else if (state is ShereheDetailsLoaded) {
                return CustomScrollView(
                  slivers: [
                    EventDetailsHeader(event: state.event),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(
                          ResponsiveBreakPoints.isMobile(context) ? 16.0 : 32.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EventAboutSection(event: state.event),
                            const SizedBox(height: 24),
                            AttendeesList(
                              event: state.event,
                              allAttendees: state.attendees,
                              isAttendeesLoading: state.isLoadingAttendees,
                              userId: userId,
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              height: ResponsiveBreakPoints.isMobile(context)
                                  ? 50
                                  : 56,
                              child: FilledButton(
                                onPressed: () {
                                  TicketFlowRoute(
                                    eventId: state.event.id,
                                  ).push(context);
                                },
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
                          context.read<ShereheDetailsBloc>().add(
                            LoadShereheDetails(eventId: widget.eventId),
                          );
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
        ],
      ),
    );
  }
}

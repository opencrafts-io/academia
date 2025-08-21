import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:confetti/confetti.dart';
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
      child: _ShereheDetailsPageContent(eventId: eventId),
    );
  }
}

class _ShereheDetailsPageContent extends StatefulWidget {
  final String eventId;
  const _ShereheDetailsPageContent({required this.eventId});

  @override
  State<_ShereheDetailsPageContent> createState() => _ShereheDetailsPageContentState();
}

class _ShereheDetailsPageContentState extends State<_ShereheDetailsPageContent> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
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
                return const Center(child: CircularProgressIndicator());
              } else if (state is ShereheDetailsLoaded) {
                final event = state.event;
                final allAttendees = state.attendees;
                Widget actionButton;
                if (state.isUserAttending) {
                  actionButton = FilledButton(
                    onPressed: null,
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).disabledColor,
                    ),
                    child: const Text("You are locked in"),
                  );
                } else {
                  actionButton = BlocConsumer<ShereheDetailsBloc, ShereheDetailsState>(
                    listener: (context, state) {
                      if (state is MarkedAsGoingFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Theme.of(context).colorScheme.error,
                          ),
                        );
                      } else if (state is ShereheDetailsLoaded && state.showConfettiEffect) {
                        _confettiController.play();
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                            content: Text("You're locked in!"),
                            backgroundColor: Theme.of(context).colorScheme.onPrimary,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      bool userIsAttending = false;
                      if (state is ShereheDetailsLoaded) {
                        userIsAttending = state.isUserAttending;
                      }
                      if (state is MarkingAsGoing) {
                        return const FilledButton(
                          onPressed: null,
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        );
                      }
                      if (userIsAttending) {
                        return FilledButton(
                          onPressed: null,
                          style: FilledButton.styleFrom(
                            backgroundColor: Theme.of(context).disabledColor,
                          ),
                          child: const Text("You are so locked in"),
                        );
                      }
                      return FilledButton(
                        onPressed: () {
                          if (state is ShereheDetailsLoaded) {
                            context.read<ShereheDetailsBloc>().add(
                              MarkAsGoing(eventId: state.event.id),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Event details not available yet.")),
                            );
                          }
                        },
                        child: const Text("I'm Going"),
                      );
                    },
                  );
                }

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
                              height: ResponsiveBreakPoints.isMobile(context)
                                  ? 50
                                  : 56,
                              child: actionButton,
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
          // 4. Add Confetti widget
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 0.01,
              numberOfParticles: 100,
              maxBlastForce: 100,
              minBlastForce: 80,
              gravity: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllAttendeesScreen extends StatefulWidget {
  final String eventId;

  const AllAttendeesScreen({super.key, required this.eventId});

  @override
  State<AllAttendeesScreen> createState() => _AllAttendeesScreenState();
}

class _AllAttendeesScreenState extends State<AllAttendeesScreen> {
  int _currentPage = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // context.read<AllAttendeesBloc>().add(
    //   FetchAllAttendees(eventId: widget.eventId, page: _currentPage, limit: 20),
    // );
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      final state = context.read<AllAttendeesBloc>().state;
      if (state is AllAttendeesStateLoaded && state.hasMore) {
        _currentPage++;
        context.read<AllAttendeesBloc>().add(
          FetchAllAttendees(
            eventId: widget.eventId,
            page: _currentPage,
            limit: 20,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AllAttendeesBloc, AllAttendeesState>(
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar.large(
                title: const Text("All Attendees"),
                pinned: true,
              ),

              // INITIAL LOADING
              if (state is AllAttendeesStateLoading) ...[
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: SpinningScallopIndicator()),
                ),
              ]
              // INITIAL ERROR
              else if (state is AllAttendeesStateError) ...[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error,
                          size: 48,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 12),
                        Text(state.message),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: () {
                            _currentPage = 1;
                            context.read<AllAttendeesBloc>().add(
                              FetchAllAttendees(
                                eventId: widget.eventId,
                                page: 1,
                                limit: 20,
                              ),
                            );
                          },
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
              // LOADED
              else if (state is AllAttendeesStateLoaded) ...[
                if (state.attendees.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.person_off, size: 60),
                          SizedBox(height: 16),
                          Text("No attendees yet", textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  )
                else
                  SliverList.separated(
                    itemCount: state.attendees.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final attendee = state.attendees[index];

                      return UserTile(
                        name: attendee.user?.username ?? "Guest",
                        subtitle:
                            attendee.ticket?.ticketName ?? "Unknown Ticket",
                        icon: Icons.person_outline,
                      );
                    },
                  ),
              ]
              // PAGINATION LOADING
              else if (state is AllAttendeesStatePaginationLoading) ...[
                SliverList.separated(
                  itemCount: state.existingAttendee.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final attendee = state.existingAttendee[index];

                    return UserTile(
                      name: attendee.user?.username ?? "Guest",
                      subtitle: attendee.ticket?.ticketName ?? "Unknown Ticket",
                      icon: Icons.person_outline,
                    );
                  },
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: SpinningScallopIndicator()),
                  ),
                ),
              ]
              // PAGINATION ERROR
              else if (state is AllAttendeesStatePaginationError) ...[
                SliverList.separated(
                  itemCount: state.existingAttendee.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final attendee = state.existingAttendee[index];

                    return UserTile(
                      name: attendee.user?.username ?? "Guest",
                      subtitle: attendee.ticket?.ticketName ?? "Unknown Ticket",
                      icon: Icons.person_outline,
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          state.message,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 10),
                        FilledButton(
                          onPressed: () => context.read<AllAttendeesBloc>().add(
                            FetchAllAttendees(
                              eventId: widget.eventId,
                              page: _currentPage,
                              limit: 20,
                            ),
                          ),
                          child: const Text("Try Again"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

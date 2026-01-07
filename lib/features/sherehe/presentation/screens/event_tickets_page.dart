import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventTicketsPage extends StatefulWidget {
  final String eventId;

  const EventTicketsPage({super.key, required this.eventId});

  @override
  State<EventTicketsPage> createState() => _EventTicketsPageState();
}

class _EventTicketsPageState extends State<EventTicketsPage> {
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    context.read<UserEventTicketsBloc>().add(
      FetchUserEventTickets(
        eventId: widget.eventId,
        page: _currentPage,
        limit: 10,
      ),
    );
  }

  void _loadMore() {
    _currentPage++;
    context.read<UserEventTicketsBloc>().add(
      FetchUserEventTickets(
        eventId: widget.eventId,
        page: _currentPage,
        limit: 10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserEventTicketsBloc, UserEventTicketsState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                title: const Text("My Tickets For This Event"),
              ),

              // Header text
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Here are the tickets you've purchased for this event.",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              if (state is UserEventTicketLoading) ...[
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: SpinningScallopIndicator()),
                ),
              ] else if (state is UserEventTicketError) ...[
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
                            context.read<UserEventTicketsBloc>().add(
                              FetchUserEventTickets(
                                eventId: widget.eventId,
                                page: _currentPage,
                                limit: 10,
                              ),
                            );
                          },
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else if (state is UserEventTicketLoaded) ...[
                if (state.attendee.isEmpty)
                  // EMPTY LIST UI
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.confirmation_number_outlined, size: 60),
                          SizedBox(height: 16),
                          Text(
                            "You haven't purchased any tickets for this event yet.",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  // MAIN LIST
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverList.separated(
                      itemCount: state.attendee.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final item = state.attendee[index];

                        return TicketCardWidget(
                          ticket: item.ticket!,
                          quantity: item.ticketQuantity,
                          eventId: state.attendee[index].eventId,
                          mode: TicketStubMode.eventTicketPurchased,
                        );
                      },
                    ),
                  ),

                if (state.hasMore)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: FilledButton(
                          onPressed: _loadMore,
                          child: const Text("Load More"),
                        ),
                      ),
                    ),
                  ),
              ] else if (state is UserEventTicketPaginationLoading) ...[
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverList.separated(
                    itemCount: state.existingAttendee.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final item = state.existingAttendee[index];

                      return TicketCardWidget(
                        ticket: item.ticket!,
                        quantity: item.ticketQuantity,
                        eventId: state.existingAttendee[index].eventId,
                        mode: TicketStubMode.eventTicketPurchased,
                      );
                    },
                  ),
                ),
                // Show loading spinner for pagination
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: SpinningScallopIndicator()),
                  ),
                ),
              ] else if (state is UserEventTicketPaginationError) ...[
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverList.separated(
                    itemCount: state.existingAttendee.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final item = state.existingAttendee[index];

                      return TicketCardWidget(
                        ticket: item.ticket!,
                        quantity: item.ticketQuantity,
                        eventId: state.existingAttendee[index].eventId,
                        mode: TicketStubMode.eventTicketPurchased,
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
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
                          onPressed: _loadMore,
                          child: const Text("Try Again"),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                const SliverFillRemaining(child: SizedBox.shrink()),
              ],
            ],
          );
        },
      ),
    );
  }
}

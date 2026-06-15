import 'package:academia/config/router/routes.dart';
import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EventTicketsPage extends StatefulWidget {
  final String eventId;
  final Event? event;
  final List<Attendee>? attendees;

  const EventTicketsPage({
    super.key,
    required this.eventId,
    this.event,
    this.attendees,
  });

  @override
  State<EventTicketsPage> createState() => _EventTicketsPageState();
}

class _EventTicketsPageState extends State<EventTicketsPage> {
  int _currentPage = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.attendees != null) {
      context.read<UserEventTicketsBloc>().add(
        FetchUserAttendeeTickets(attendees: widget.attendees!),
      );
    } else {
      context.read<UserEventTicketsBloc>().add(
        FetchUserEventTickets(
          eventId: widget.eventId,
          page: _currentPage,
          limit: 10,
        ),
      );
      _scrollController.addListener(_onScroll);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      final state = context.read<UserEventTicketsBloc>().state;
      if (state is UserEventTicketLoaded && state.hasMore) {
        _currentPage++;
        context.read<UserEventTicketsBloc>().add(
          FetchUserEventTickets(
            eventId: widget.eventId,
            page: _currentPage,
            limit: 10,
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
      body: BlocBuilder<UserEventTicketsBloc, UserEventTicketsState>(
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                title: const Text("My Tickets For This Event"),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      HomeRoute().go(context);
                    }
                  },
                ),
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
                      separatorBuilder: (_, _) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final item = state.attendee[index];

                        return TicketCardWidget(
                          ticket: item.ticket!,
                          quantity: item.ticketQuantity,
                          event: widget.event,
                          attendeeId: item.id,
                          ticketStartDate: item.ticket?.startDate,
                          ticketEndDate: item.ticket?.endDate,
                          mode: TicketStubMode.eventTicketPurchased,
                        );
                      },
                    ),
                  ),
              ] else if (state is UserEventTicketPaginationLoading) ...[
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverList.separated(
                    itemCount: state.existingAttendee.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final item = state.existingAttendee[index];

                      return TicketCardWidget(
                        ticket: item.ticket!,
                        quantity: item.ticketQuantity,
                        event: widget.event,
                        attendeeId: item.id,
                        mode: TicketStubMode.eventTicketPurchased,
                        ticketStartDate: item.ticket?.startDate,
                        ticketEndDate: item.ticket?.endDate,
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
                    separatorBuilder: (_, _) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final item = state.existingAttendee[index];

                      return TicketCardWidget(
                        ticket: item.ticket!,
                        quantity: item.ticketQuantity,
                        event: widget.event,
                        attendeeId: item.id,
                        mode: TicketStubMode.eventTicketPurchased,
                        ticketStartDate: item.ticket?.startDate,
                        ticketEndDate: item.ticket?.endDate,
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
                          onPressed: () =>
                              context.read<UserEventTicketsBloc>().add(
                                FetchUserEventTickets(
                                  eventId: widget.eventId,
                                  page: _currentPage,
                                  limit: 10,
                                ),
                              ),
                          child: const Text("Try Again"),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else if (state is FetchUserAttendeeTicketsSuccess) ...[
                if (state.attendees.isEmpty)
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
                            "No tickets to show at the moment.",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverList.separated(
                      itemCount: state.attendees.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final item = state.attendees[index];

                        return TicketCardWidget(
                          ticket: item.ticket!,
                          quantity: item.ticketQuantity,
                          event: item.event,
                          attendeeId: item.id,
                          mode: TicketStubMode.eventTicketPurchased,
                          ticketStartDate: item.ticket?.startDate,
                          ticketEndDate: item.ticket?.endDate,
                        );
                      },
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

import 'dart:async';
import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurchasedTicketsPage extends StatefulWidget {
  const PurchasedTicketsPage({super.key});

  @override
  State<PurchasedTicketsPage> createState() => _PurchasedTicketsPageState();
}

class _PurchasedTicketsPageState extends State<PurchasedTicketsPage> {
  int _currentPage = 1;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  Timer? _searchDebounce;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _fetchInitialTickets();
    _scrollController.addListener(_onScroll);
  }

  void _fetchInitialTickets() {
    _currentPage = 1;
    context.read<AllUserEventTicketsBloc>().add(
      FetchAllUserTickets(page: _currentPage, limit: 10),
    );
  }

  void _onScroll() {
    if (_isSearching) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      final state = context.read<AllUserEventTicketsBloc>().state;
      if (state is UserAllTicketsLoaded && state.hasMore) {
        _currentPage++;
        context.read<AllUserEventTicketsBloc>().add(
          FetchAllUserTickets(page: _currentPage, limit: 10),
        );
      }
    }
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AllUserEventTicketsBloc, AllUserEventTicketsState>(
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                title: const Text("All Tickets"),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(76),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: SearchBar(
                      controller: _searchController,
                      backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.primaryContainer,
                      ),
                      hintText: 'Search by event or ticket name',
                      leading: const Icon(Icons.search),
                      onChanged: (value) {
                        _searchDebounce?.cancel();

                        _searchDebounce = Timer(
                          const Duration(milliseconds: 500),
                          () {
                            final query = value.trim();

                            if (query.isEmpty) {
                              _isSearching = false;
                              _fetchInitialTickets();
                            } else {
                              _isSearching = true;
                              context.read<AllUserEventTicketsBloc>().add(
                                SearchUserAttendedEvents(query: query),
                              );
                            }
                          },
                        );
                      },

                      trailing: [
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchDebounce?.cancel();
                            _searchController.clear();
                            _isSearching = false;
                            _fetchInitialTickets();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Header text
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Here are all the tickets you've purchased.",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              if (state is UserAllTicketsLoading) ...[
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: SpinningScallopIndicator()),
                ),
              ] else if (state is UserAllTicketsError) ...[
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
                            context.read<AllUserEventTicketsBloc>().add(
                              FetchAllUserTickets(
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
              ] else if (state is UserAllTicketsLoaded) ...[
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
                            "You haven’t purchased any tickets yet.",
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
                          mode: TicketStubMode.allTicketsPurchased,
                          event: item.event,
                          attendeeId: item.id,
                        );
                      },
                    ),
                  ),
              ] else if (state is UserAllTicketsPaginationLoading) ...[
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
                        mode: TicketStubMode.allTicketsPurchased,
                        event: item.event,
                        attendeeId: item.id,
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
              ] else if (state is UserAllTicketsPaginationError) ...[
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
                        mode: TicketStubMode.allTicketsPurchased,
                        event: item.event,
                        attendeeId: item.id,
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
                              context.read<AllUserEventTicketsBloc>().add(
                                FetchAllUserTickets(
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
              ] else if (state is UserAllAttendedEventsSearchLoading) ...[
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: SpinningScallopIndicator()),
                ),
              ] else if (state is UserAllAttendedEventsLoaded) ...[
                if (state.attendee.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "No results found",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Try searching with a different event or ticket name.",
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList.separated(
                      itemCount: state.attendee.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final item = state.attendee[index];
                        return TicketCardWidget(
                          ticket: item.ticket!,
                          quantity: item.ticketQuantity,
                          mode: TicketStubMode.allTicketsPurchased,
                          event: item.event,
                          attendeeId: item.id,
                        );
                      },
                    ),
                  ),
              ] else if (state is UserAllAttendedEventsSearchError) ...[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Something went wrong",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.message,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
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

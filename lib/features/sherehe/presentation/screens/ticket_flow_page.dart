import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TicketFlowPage extends StatefulWidget {
  final String eventId;

  const TicketFlowPage({super.key, required this.eventId});

  @override
  State<TicketFlowPage> createState() => _TicketFlowPageState();
}

class _TicketFlowPageState extends State<TicketFlowPage> {
  Ticket? selectedTicket;
  List<Ticket> ticketTypes = [];
  bool isFreeEvent = false;
  int quantity = 1;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    context.read<UserTicketSelectionBloc>().add(
      FetchTicketsByEventId(eventId: widget.eventId),
    );
  }

  void nextPage() {
    if (currentPage < 1) {
      setState(() => currentPage++);
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() => currentPage--);
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = (currentPage + 1) / 2;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text("Ticket Booking"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: BlocConsumer<UserTicketSelectionBloc, UserTicketSelectionState>(
        listener: (context, state) {
          if (state is UserTicketPurchased) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Ticket purchased successfully! See you at the event",
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
            context.pop();
          } else if (state is UserTicketPurchaseFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Purchase failed: ${state.message}"),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          } else if (state is UserTicketLoaded ||
              state is UserTicketPurchaseInProgress) {
            ticketTypes = state is UserTicketLoaded
                ? state.tickets
                : (state as UserTicketPurchaseInProgress).existingTickets;
            isFreeEvent =
                ticketTypes.length == 1 && ticketTypes.first.ticketPrice == 0;
            selectedTicket = isFreeEvent ? ticketTypes.first : null;
          }
        },
        builder: (context, state) {
          if (state is UserTicketLoading) {
            return const Center(child: SpinningScallopIndicator());
          } else if (state is UserTicketError) {
            return Center(child: Text(state.message));
          } else if (state is UserTicketLoaded ||
              state is UserTicketPurchaseInProgress) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: currentPage == 0
                      ? UserTicketSelectionPage(
                          ticketTypes: ticketTypes,
                          selectedTicket: selectedTicket,
                          quantity: quantity,
                          onTicketSelected: (ticket) {
                            setState(() => selectedTicket = ticket);
                          },
                          onQuantityChanged: (q) =>
                              setState(() => quantity = q),
                          onContinue: () {
                            if (selectedTicket != null) nextPage();
                          },
                          isFreeEvent: isFreeEvent,
                        )
                      : ReviewTicketPage(
                          ticket: selectedTicket!,
                          quantity: quantity,
                          onPurchase: () {
                            if (selectedTicket != null) {
                              context.read<UserTicketSelectionBloc>().add(
                                PurchaseTicket(
                                  ticketId: selectedTicket!.id!,
                                  ticketQuantity: quantity,
                                ),
                              );
                            }
                          },
                          onPrevious: () => previousPage(),
                        ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

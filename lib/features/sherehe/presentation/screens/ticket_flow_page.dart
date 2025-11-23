import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketFlowPage extends StatefulWidget {
  final String eventId;

  const TicketFlowPage({super.key, required this.eventId});

  @override
  State<TicketFlowPage> createState() => _TicketFlowPageState();
}

class _TicketFlowPageState extends State<TicketFlowPage> {
  Ticket? selectedTicket;
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
      body: BlocBuilder<UserTicketSelectionBloc, UserTicketSelectionState>(
        builder: (context, state) {
          if (state is UserTicketLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserTicketError) {
            return Center(child: Text(state.message));
          } else if (state is UserTicketLoaded) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: currentPage == 0
                      ? UserTicketSelectionPage(
                          ticketTypes: state.tickets,
                          selectedTicket: selectedTicket,
                          quantity: quantity,
                          onTicketSelected: (ticket) =>
                              setState(() => selectedTicket = ticket),
                          onQuantityChanged: (q) =>
                              setState(() => quantity = q),
                          onContinue: () {
                            if (selectedTicket != null) nextPage();
                          },
                        )
                      : ReviewTicketPage(
                          ticket: selectedTicket!,
                          quantity: quantity,
                          onPurchase: () {
                            // TODO: Implement purchase logic
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

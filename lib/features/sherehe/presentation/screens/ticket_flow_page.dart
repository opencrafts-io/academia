import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';

class TicketFlowPage extends StatefulWidget {
  const TicketFlowPage({super.key});

  @override
  State<TicketFlowPage> createState() => _TicketFlowPageState();
}

class _TicketFlowPageState extends State<TicketFlowPage> {
  final List<Ticket> ticketTypes = [
    Ticket(ticketName: "VIP", ticketPrice: 5000, ticketQuantity: 0),
    Ticket(ticketName: "Regular", ticketPrice: 2500, ticketQuantity: 0),
    Ticket(ticketName: "Medium", ticketPrice: 3500, ticketQuantity: 0),
  ];

  Ticket? selectedTicket;
  int quantity = 1;

  int currentPage = 0;

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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: currentPage == 0
                ? UserTicketSelectionPage(
                    ticketTypes: ticketTypes,
                    selectedTicket: selectedTicket,
                    quantity: quantity,
                    onTicketSelected: (ticket) =>
                        setState(() => selectedTicket = ticket),
                    onQuantityChanged: (q) => setState(() => quantity = q),
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
      ),
    );
  }
}

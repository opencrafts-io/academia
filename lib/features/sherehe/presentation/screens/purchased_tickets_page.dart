import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:academia/features/sherehe/domain/entities/ticket.dart';

class PurchasedTicketsPage extends StatelessWidget {
  final String eventId;

  const PurchasedTicketsPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> purchasedTickets = [
      {
        "ticket": Ticket(
          ticketName: "VIP Ticket",
          ticketPrice: 3500,
          ticketQuantity: 1,
        ),
        "quantity": 2,
      },
      {
        "ticket": Ticket(
          ticketName: "Regular Ticket",
          ticketPrice: 1500,
          ticketQuantity: 1,
        ),
        "quantity": 1,
      },
      {
        "ticket": Ticket(
          ticketName: "Free Ticket",
          ticketPrice: 0,
          ticketQuantity: 1,
        ),
        "quantity": 3,
      },
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            title: const Text("My Tickets"),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Here are the tickets you've purchased for this event.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList.separated(
              itemCount: purchasedTickets.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final item = purchasedTickets[index];
                final ticket = item["ticket"] as Ticket;
                final quantity = item["quantity"] as int;

                return TicketStubCard(ticket: ticket, quantity: quantity);
              },
            ),
          ),
        ],
      ),
    );
  }
}

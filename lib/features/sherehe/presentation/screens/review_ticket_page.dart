import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewTicketPage extends StatelessWidget {
  final Ticket ticket;
  final int quantity;
  final VoidCallback onPurchase;
  final VoidCallback onPrevious;

  const ReviewTicketPage({
    super.key,
    required this.ticket,
    required this.quantity,
    required this.onPurchase,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    final total = ticket.ticketPrice * quantity;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            spacing: 10.0,
            children: [
              Text("2.", style: Theme.of(context).textTheme.headlineSmall),
              Text(
                "Review & Purchase",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          TicketStubCard(ticket: ticket, quantity: quantity),
          // Payment Summary
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment Summary",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Subtotal"),
                    Text(
                      "KES ${total.toStringAsFixed(0)}",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "KES ${total.toStringAsFixed(0)}",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Purchase Button
          BlocBuilder<UserTicketSelectionBloc, UserTicketSelectionState>(
            builder: (context, state) {
              return Row(
                spacing: 6.0,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: state is UserTicketPurchaseInProgress
                          ? null
                          : onPrevious,
                      child: Text("Back"),
                    ),
                  ),

                  Expanded(
                    child: state is UserTicketPurchaseInProgress
                        ? Center(child: const CircularProgressIndicator())
                        : FilledButton(
                            onPressed: state is UserTicketPurchaseInProgress
                                ? null
                                : onPurchase,
                            child: Text("Purchase Ticket"),
                          ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

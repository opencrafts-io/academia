import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';

class ReviewTicketPage extends StatelessWidget {
  final Ticket ticket;
  final int quantity;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool? isFreeEvent;

  const ReviewTicketPage({
    super.key,
    required this.ticket,
    required this.quantity,
    required this.onNext,
    required this.onPrevious,
    this.isFreeEvent = false,
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
                "Review Purchase",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          TicketCardWidget(
            ticket: ticket,
            quantity: quantity,
            mode: TicketStubMode.purchasingTicket,
          ),
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
          Row(
            spacing: 6.0,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onPrevious,
                  child: Text("Back"),
                ),
              ),

              Expanded(
                child: FilledButton(
                  onPressed: isFreeEvent == true ? () {} : onNext,
                  child: Text(
                    isFreeEvent == true ? "Book Ticket" : "Proceed to Payment",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

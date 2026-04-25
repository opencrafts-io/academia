import 'package:academia/features/sherehe/domain/entities/ticket.dart';
import 'package:flutter/material.dart';

class TicketQuantitySelector extends StatelessWidget {
  final bool isFreeEvent;
  final Ticket selectedTicket;
  final int quantity;
  final int maxAllowedQuantity;
  final Function(int) onQuantityChanged;
  final VoidCallback onContinue;

  const TicketQuantitySelector({
    super.key,
    required this.isFreeEvent,
    required this.selectedTicket,
    required this.quantity,
    required this.maxAllowedQuantity,
    required this.onQuantityChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final ticket = selectedTicket;
    final totalPeople = quantity * (ticket.ticketFor ?? 0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isFreeEvent ? "Select Free Ticket Quantity" : "Select Quantity",
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 12),

          // Quantity controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: quantity > 1
                    ? () => onQuantityChanged(quantity - 1)
                    : null,
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text(
                quantity.toString(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              IconButton(
                onPressed: quantity < maxAllowedQuantity
                    ? () => onQuantityChanged(quantity + 1)
                    : null,
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primaryContainer.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.groups_2_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Covers $totalPeople ${totalPeople == 1 ? "person" : "people"}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Max quantity warning
          if (quantity == maxAllowedQuantity && maxAllowedQuantity > 0)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                quantity == 2 && (ticket.ticketQuantity ?? 0) > 2
                    ? "Maximum of 2 tickets can be purchased"
                    : "Only ${ticket.ticketQuantity} ${ticket.ticketQuantity == 1 ? "ticket" : "tickets"} remaining",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),

          // Sold out message
          if (ticket.ticketQuantity == 0)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                "Sorry this ticket is sold out.",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),

          const SizedBox(height: 12),

          // Continue button
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: ticket.ticketQuantity == 0 ? null : onContinue,
              child: Text(isFreeEvent ? "Continue (Free)" : "Continue"),
            ),
          ),
        ],
      ),
    );
  }
}

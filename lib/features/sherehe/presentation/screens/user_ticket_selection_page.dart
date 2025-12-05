import 'package:academia/features/sherehe/domain/entities/ticket.dart';
import 'package:flutter/material.dart';

class UserTicketSelectionPage extends StatelessWidget {
  final List<Ticket> ticketTypes;
  final Ticket? selectedTicket;
  final int quantity;
  final void Function(Ticket ticket) onTicketSelected;
  final void Function(int quantity) onQuantityChanged;
  final VoidCallback onContinue;
  final bool isFreeEvent;

  const UserTicketSelectionPage({
    super.key,
    required this.ticketTypes,
    required this.selectedTicket,
    required this.quantity,
    required this.onTicketSelected,
    required this.onQuantityChanged,
    required this.onContinue,
    required this.isFreeEvent,
  });

  @override
  Widget build(BuildContext context) {

    final int maxAllowedQuantity = selectedTicket == null
        ? 0
        : selectedTicket!.ticketQuantity < 3
        ? selectedTicket!.ticketQuantity
        : 3;

    // Sort for normal paid event UI
    final sortedTickets = [...ticketTypes]
      ..sort((a, b) => b.ticketPrice.compareTo(a.ticketPrice));

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
              Text("1.", style: Theme.of(context).textTheme.headlineSmall),
              Text(
                isFreeEvent ? "Free Ticket" : "Select Ticket",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),

          // Ticket list - only visible for paid events
          if (!isFreeEvent) ...[
            ...sortedTickets.map((ticket) {
              final isSelected = selectedTicket == ticket;
              return GestureDetector(
                onTap: ticket.ticketQuantity == 0
                    ? null
                    : () => onTicketSelected(ticket),
                child: Opacity(
                  opacity: ticket.ticketQuantity == 0 ? 0.5 : 1.0,
                  child: Card(
                    elevation: isSelected ? 6 : 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: isSelected
                          ? BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2,
                            )
                          : BorderSide.none,
                    ),
                    child: ListTile(
                      title: Text(ticket.ticketName),
                      subtitle: Text(
                        ticket.ticketQuantity == 0
                            ? "Sold Out"
                            : "KES ${ticket.ticketPrice.toStringAsFixed(0)}",
                      ),
                      trailing: Icon(
                        isSelected ? Icons.check_circle : Icons.circle_outlined,
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],

          // Quantity selector appears for both free + paid
          if (selectedTicket != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              child: Column(
                spacing: 12.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isFreeEvent
                        ? "Select Free Ticket Quantity"
                        : "Select Quantity",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

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
                  if (quantity == maxAllowedQuantity && maxAllowedQuantity > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        quantity == 3 && selectedTicket!.ticketQuantity > 3
                            ? "Maximum of 3 tickets per order"
                            : "Only ${selectedTicket!.ticketQuantity} tickets remaining",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),

                  if (selectedTicket!.ticketQuantity == 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        "Sorry this ticket is sold out.",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),

                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: selectedTicket!.ticketQuantity == 0
                          ? null
                          : onContinue,
                      child: Text(isFreeEvent ? "Continue (Free)" : "Continue"),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

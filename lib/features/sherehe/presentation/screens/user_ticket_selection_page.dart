import 'package:academia/features/sherehe/domain/entities/ticket.dart';
import 'package:flutter/material.dart';

class UserTicketSelectionPage extends StatelessWidget {
  final List<Ticket> ticketTypes;
  final Ticket? selectedTicket;
  final int quantity;
  final void Function(Ticket ticket) onTicketSelected;
  final void Function(int quantity) onQuantityChanged;
  final VoidCallback onContinue;

  const UserTicketSelectionPage({
    super.key,
    required this.ticketTypes,
    required this.selectedTicket,
    required this.quantity,
    required this.onTicketSelected,
    required this.onQuantityChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
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
                "Select Ticket",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          // Ticket list
          ...sortedTickets.map((ticket) {
            final isSelected = selectedTicket == ticket;
            return GestureDetector(
              onTap: () => onTicketSelected(ticket),
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
                    "KES ${ticket.ticketPrice.toStringAsFixed(0)}",
                  ),
                  trailing: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                ),
              ),
            );
          }),
          // Quantity selector & continue button
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
                    "Select Quantity",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
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
                        onPressed: () => onQuantityChanged(quantity + 1),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: onContinue,
                      child: const Text("Continue"),
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

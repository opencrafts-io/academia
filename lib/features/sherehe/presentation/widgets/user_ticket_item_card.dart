import 'package:academia/features/sherehe/domain/entities/ticket.dart';
import 'package:flutter/material.dart';

class UserTicketItemCard extends StatelessWidget {
  final Ticket ticket;
  final bool isSelected;
  final Function(Ticket) onTicketSelected;
  final ScrollController scrollController;

  const UserTicketItemCard({
    super.key,
    required this.ticket,
    required this.isSelected,
    required this.onTicketSelected,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ticket.ticketQuantity == 0
          ? null
          : () {
              onTicketSelected(ticket);

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!scrollController.hasClients) return;

                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                );
              });
            },
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
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "${ticket.ticketFor} ${ticket.ticketFor == 1 ? "Person" : "People"}",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            title: Text(
              ticket.ticketName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              ticket.ticketQuantity == 0
                  ? "Sold Out"
                  : "KES ${ticket.ticketPrice.toStringAsFixed(0)}",
            ),
            trailing: Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Theme.of(context).colorScheme.primary : null,
            ),
          ),
        ),
      ),
    );
  }
}

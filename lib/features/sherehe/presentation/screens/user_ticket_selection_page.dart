import 'dart:math';
import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/entities/ticket.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserTicketSelectionPage extends StatefulWidget {
  final String eventId;
  final Ticket? selectedTicket;
  final int quantity;
  final void Function(Ticket? ticket) onTicketSelected;
  final void Function(int quantity) onQuantityChanged;
  final VoidCallback onContinue;

  const UserTicketSelectionPage({
    super.key,
    required this.eventId,
    required this.selectedTicket,
    required this.quantity,
    required this.onTicketSelected,
    required this.onQuantityChanged,
    required this.onContinue,
  });

  @override
  State<UserTicketSelectionPage> createState() =>
      _UserTicketSelectionPageState();
}

class _UserTicketSelectionPageState extends State<UserTicketSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserTicketSelectionBloc, UserTicketSelectionState>(
      builder: (context, state) {
        if (state is UserTicketLoading) {
          return const Center(child: SpinningScallopIndicator());
        }

        if (state is UserTicketError) {
          return Center(child: Text(state.message));
        }

        if (state is UserTicketLoaded) {
          final isFreeEvent =
              state.tickets.length == 1 && state.tickets.first.ticketPrice == 0;

          final int maxAllowedQuantity = widget.selectedTicket == null
              ? 0
              : min(widget.selectedTicket!.ticketQuantity ?? 0, 3);

          if (isFreeEvent && widget.selectedTicket == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.onTicketSelected(state.tickets.first);
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (widget.selectedTicket != null &&
                  !state.tickets.contains(widget.selectedTicket)) {
                widget.onTicketSelected(null);
              }
            });
          }

          // Sort for normal paid event UI
          final sortedTickets = [...state.tickets]
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
                    Text(
                      "1.",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      isFreeEvent ? "Free Ticket" : "Select Ticket",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),

                // Ticket list - only visible for paid events
                if (!isFreeEvent) ...[
                  ...sortedTickets.map((ticket) {
                    final isSelected = widget.selectedTicket == ticket;
                    return GestureDetector(
                      onTap: ticket.ticketQuantity == 0
                          ? null
                          : () => widget.onTicketSelected(ticket),
                      child: Opacity(
                        opacity: ticket.ticketQuantity == 0 ? 0.5 : 1.0,
                        child: Card(
                          elevation: isSelected ? 6 : 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: isSelected
                                ? BorderSide(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
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
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
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
                if (widget.selectedTicket != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
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
                              onPressed: widget.quantity > 1
                                  ? () => widget.onQuantityChanged(
                                      widget.quantity - 1,
                                    )
                                  : null,
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text(
                              widget.quantity.toString(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            IconButton(
                              onPressed: widget.quantity < maxAllowedQuantity
                                  ? () => widget.onQuantityChanged(
                                      widget.quantity + 1,
                                    )
                                  : null,
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                        if (widget.quantity == maxAllowedQuantity &&
                            maxAllowedQuantity > 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              widget.quantity == 3 &&
                                      (widget.selectedTicket!.ticketQuantity ??
                                              0) >
                                          3
                                  ? "Maximum of 3 tickets per order"
                                  : "Only ${widget.selectedTicket!.ticketQuantity} tickets remaining",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                            ),
                          ),

                        if (widget.selectedTicket!.ticketQuantity == 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              "Sorry this ticket is sold out.",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                            ),
                          ),

                        // Continue button
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed:
                                widget.selectedTicket!.ticketQuantity == 0
                                ? null
                                : widget.onContinue,
                            child: Text(
                              isFreeEvent ? "Continue (Free)" : "Continue",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

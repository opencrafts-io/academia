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
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
          if (state.tickets.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Tickets are reserved for specific institutions",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "You are not eligible to purchase tickets for this event.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          final isFreeEvent =
              state.tickets.length == 1 && state.tickets.first.ticketPrice == 0;

          final int maxAllowedQuantity = widget.selectedTicket == null
              ? 0
              : min(widget.selectedTicket!.ticketQuantity ?? 0, 2);

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

          return SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
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
                      return UserTicketItemCard(
                        ticket: ticket,
                        isSelected: widget.selectedTicket == ticket,
                        onTicketSelected: widget.onTicketSelected,
                        scrollController: _scrollController,
                      );
                    }),
                  ],

                  // Quantity selector appears for both free + paid
                  if (widget.selectedTicket != null)
                    TicketQuantitySelector(
                      isFreeEvent: isFreeEvent,
                      selectedTicket: widget.selectedTicket!,
                      quantity: widget.quantity,
                      maxAllowedQuantity: maxAllowedQuantity,
                      onQuantityChanged: widget.onQuantityChanged,
                      onContinue: widget.onContinue,
                    ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

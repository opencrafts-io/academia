import 'package:academia/config/config.dart';
import 'package:academia/features/sherehe/domain/entities/ticket.dart';
import 'package:flutter/material.dart';

enum TicketStubMode {
  purchasingTicket,
  allTicketsPurchased,
  eventTicketPurchased,
}

class TicketCardWidget extends StatelessWidget {
  final Ticket ticket;
  final int quantity;
  final String? eventId;
  final String? eventName;
  final TicketStubMode mode;

  const TicketCardWidget({
    super.key,
    required this.ticket,
    required this.quantity,
    required this.mode,
    this.eventId,
    this.eventName,
  });

  @override
  Widget build(BuildContext context) {
    final total = ticket.ticketPrice * quantity;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              spacing: 16,
              children: [
                Icon(
                  Icons.confirmation_number_outlined,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (mode == TicketStubMode.allTicketsPurchased &&
                          eventName != null)
                        Text(
                          eventName!,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      Text(
                        ticket.ticketName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomPaint(
              painter: DashedLinePainter(
                color: Theme.of(context).colorScheme.outline,
              ),
              child: const SizedBox(height: 1, width: double.infinity),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: _TicketDetailsSection(
              ticket: ticket,
              quantity: quantity,
              total: total,
              mode: mode,
            ),
          ),

          if (mode == TicketStubMode.allTicketsPurchased ||
              mode == TicketStubMode.eventTicketPurchased)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.icon(
                    onPressed: () => QrCodeRoute(
                      eventId: eventId!,
                      ticketId: ticket.id!,
                      ticketName: ticket.ticketName,
                      quantity: quantity,
                    ).push(context),
                    icon: const Icon(Icons.qr_code),
                    label: const Text("View QR"),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Navigate to receipt
                    },
                    icon: const Icon(Icons.receipt_long),
                    label: const Text("Receipt"),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _TicketDetailsSection extends StatelessWidget {
  final Ticket ticket;
  final int quantity;
  final int total;
  final TicketStubMode mode;

  const _TicketDetailsSection({
    required this.ticket,
    required this.quantity,
    required this.total,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case TicketStubMode.purchasingTicket:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _InfoColumn(label: "Quantity", value: quantity.toString()),
            _InfoColumn(label: "Price", value: "KES ${ticket.ticketPrice}"),
            _InfoColumn(label: "Total", value: "KES $total"),
          ],
        );

      case TicketStubMode.allTicketsPurchased:
      case TicketStubMode.eventTicketPurchased:
        return Row(
          spacing: 12.0,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 8.0,
              children: [
                Icon(
                  Icons.people_alt_outlined,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(
                  "$quantity ticket${quantity > 1 ? 's' : ''}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.secondaryContainer.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                spacing: 6.0,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  Text(
                    "Purchased",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
    }
  }
}

class _InfoColumn extends StatelessWidget {
  final String label;
  final String value;

  const _InfoColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;

  DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 6.0;
    const dashSpace = 4.0;

    double startX = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

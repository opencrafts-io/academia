import 'package:academia/config/config.dart';
import 'package:academia/features/sherehe/domain/entities/ticket.dart';
import 'package:flutter/material.dart';

class TicketStubCard extends StatelessWidget {
  final Ticket ticket;
  final int quantity;
  final String? eventId;
  final bool showQrCode;

  const TicketStubCard({
    super.key,
    required this.ticket,
    required this.quantity,
    this.eventId,
    this.showQrCode = false,
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
              spacing: 16.0,
              children: [
                Icon(
                  Icons.confirmation_number_outlined,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Expanded(
                  child: Text(
                    ticket.ticketName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // PERFORATED DIVIDER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomPaint(
              painter: DashedLinePainter(
                color: Theme.of(context).colorScheme.outline,
              ),
              child: SizedBox(height: 1, width: double.infinity),
            ),
          ),

          // Bottom details
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoColumn(label: "Quantity", value: quantity.toString()),
                _InfoColumn(
                  label: "Price",
                  value: "KES ${ticket.ticketPrice.toStringAsFixed(0)}",
                ),
                _InfoColumn(
                  label: "Total",
                  value: "KES ${total.toStringAsFixed(0)}",
                ),
              ],
            ),
          ),

          if (showQrCode)
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 8),
              child: FilledButton.icon(
                onPressed: () => QrCodeRoute(
                  eventId: eventId!,
                  ticketName: ticket.ticketName,
                  quantity: quantity,
                ).push(context),
                icon: const Icon(Icons.qr_code),
                label: const Text("View QR Code"),
              ),
            ),
        ],
      ),
    );
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

import 'package:flutter/material.dart';

class TicketReceiptScreen extends StatelessWidget {
  final int ticketPrice;
  final int quantity;

  const TicketReceiptScreen({
    super.key,
    required this.ticketPrice,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final total = ticketPrice * quantity;

    return Scaffold(
      appBar: AppBar(title: const Text("Receipt"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.receipt_long,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment Receipt",
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Thank you for your purchase",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    _ReceiptRow(
                      label: "Ticket price",
                      value: "KES ${ticketPrice.toString()}",
                    ),
                    const SizedBox(height: 12),

                    _ReceiptRow(label: "Quantity", value: quantity.toString()),

                    const SizedBox(height: 20),

                    Divider(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),

                    const SizedBox(height: 20),

                    _ReceiptRow(
                      label: "Total",
                      value: "KES ${total.toString()}",
                      isTotal: true,
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Done button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Done"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _ReceiptRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)
              : Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          value,
          style: isTotal
              ? Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)
              : Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

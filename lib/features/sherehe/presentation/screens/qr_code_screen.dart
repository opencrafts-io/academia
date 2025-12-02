import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrCodeScreen extends StatelessWidget {
  final String eventId;
  final String ticketName;
  final int quantity;

  const QrCodeScreen({
    super.key,
    required this.eventId,
    required this.ticketName,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Ticket QR"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 8.0,
            children: [
              Text(
                ticketName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Quantity: $quantity",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: PrettyQrView.data(
                  data: eventId,
                  decoration: PrettyQrDecoration(
                    shape: PrettyQrSmoothSymbol(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface,
                    ),
                    image: const PrettyQrDecorationImage(
                      image: AssetImage("assets/icons/academia-v2.png"),
                    ),
                    quietZone: PrettyQrQuietZone.standart,
                  ),
                ),
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 6.0,
                  children: [
                    Text(
                      "Present this code at the entrance",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Do not share this QR code",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

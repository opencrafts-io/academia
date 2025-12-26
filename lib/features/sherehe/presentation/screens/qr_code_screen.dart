import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrCodeScreen extends StatelessWidget {
  final String eventId;
  // final String eventName;
  // final String eventDate;
  final String ticketName;
  final int quantity;

  const QrCodeScreen({
    super.key,
    required this.eventId,
    // required this.eventName,
    // required this.eventDate,
    required this.ticketName,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Ticket"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 30.0,
            children: [
              Column(
                spacing: 4.0,
                children: [
                  Text(
                    // eventName,
                    'Sample Event Name',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Text(
                  //   '${ShereheUtils.formatDate(eventDate)} • '
                  //   '${ShereheUtils.formatTime(eventDate)}',
                  //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  //     color: Theme.of(context).colorScheme.onSurfaceVariant,
                  //   ),
                  // ),
                  Text(
                    '10 Sep 2025 • '
                    '03:00 AM',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 16,
                        color: Colors.black.withValues(alpha: 0.08),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: (MediaQuery.sizeOf(context).shortestSide * 0.65).clamp(220.0, 320.0),
                    height: (MediaQuery.sizeOf(context).shortestSide * 0.65).clamp(220.0, 320.0),
                    child: PrettyQrView.data(
                      data: eventId, //placeholder for now
                      decoration: PrettyQrDecoration(
                        shape: PrettyQrSmoothSymbol(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        image: const PrettyQrDecorationImage(
                          image: AssetImage("assets/icons/academia-v2.png"),
                        ),
                        quietZone: PrettyQrQuietZone.standart,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                spacing: 4.0,
                children: [
                  Text(
                    ticketName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Quantity: $quantity',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Column(
                spacing: 6.0,
                children: [
                  Text(
                    "Present this QR code at the entrance",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "This QR code is unique and can only be used once",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

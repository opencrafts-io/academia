import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeScannerScreen extends StatefulWidget {
  final String eventId;

  const QrCodeScannerScreen({super.key, required this.eventId});

  @override
  State<QrCodeScannerScreen> createState() => _QrCodeScannerScreenState();
}

class _QrCodeScannerScreenState extends State<QrCodeScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isScanning = true; // prevents duplicate scans

  void _onDetect(BarcodeCapture capture) {
    if (!_isScanning) return;

    final barcode = capture.barcodes.first;
    final qrValue = barcode.rawValue;

    if (qrValue == null) return;

    // Lock scanner to prevent multiple scans
    setState(() => _isScanning = false);

    _validateTicket(qrValue);
  }

  Future<void> _validateTicket(String token) async {
    // TODO: call backend logic here
    await Future.delayed(const Duration(seconds: 1));

    final bool valid = token.contains(widget.eventId); // TEMP FAKE CHECK

    if (!mounted) return;

    _showResultDialog(valid, token);
  }

  void _showResultDialog(bool valid, String token) {
    final color = valid
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.error;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text(
            valid ? "Ticket Valid" : "Invalid Ticket",
            style: TextStyle(color: color),
          ),
          content: valid
              ? const Text("Access granted.")
              : const Text("This QR code is not valid for this event."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _resumeScanner();
              },
              child: const Text("Scan Another"),
            ),
          ],
        );
      },
    );
  }

  void _resumeScanner() {
    setState(() => _isScanning = true);
    _controller.start();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Ticket"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          MobileScanner(controller: _controller, onDetect: _onDetect),

          Positioned.fill(
            child: CustomPaint(
              painter: _ScannerOverlayPainter(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Text(
              _isScanning ? "Align QR inside frame to scan" : "Processing...",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  final Color color;

  _ScannerOverlayPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final rect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: size.width * .7,
      height: size.width * .7,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(16)),
      paint,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}

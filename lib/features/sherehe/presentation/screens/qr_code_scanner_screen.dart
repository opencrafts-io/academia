import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    final qrValue = capture.barcodes.first.rawValue;
    if (qrValue == null) return;

    if (!qrValue.startsWith('attendee:')) {
      _showInvalidFormat();
      return;
    }

    final attendeeId = qrValue.replaceFirst('attendee:', '');

    setState(() => _isScanning = false);

    _controller.stop();

    context.read<ValidateAttendeeBloc>().add(
      ValidateAttendee(eventId: widget.eventId, attendeeId: attendeeId),
    );
  }

  void _handleAttendeeStatus(String status) {
    final normalized = status.toUpperCase();

    late final bool valid;
    late final String title;
    late final String message;

    switch (normalized) {
      case 'VALID':
        valid = true;
        title = 'Ticket Valid';
        message = 'Attendance confirmed successfully.';
        break;

      case 'ALREADY_SCANNED':
        valid = false;
        title = 'Already Scanned';
        message = 'This ticket has already been used.';
        break;

      case 'WRONG_EVENT':
        valid = false;
        title = 'Wrong Event';
        message = 'This ticket does not belong to this event.';
        break;

      case 'TOO_EARLY':
        valid = false;
        title = 'Too Early';
        message = "It's too early to scan the ticket. Please try again later.";
        break;

      case 'EXPIRED':
        valid = false;
        title = 'Expired';
        message = "This event has already passed. This ticket has expired.";
        break;

      case 'INVALID':
      default:
        valid = false;
        title = 'Invalid Ticket';
        message = 'Invalid or unknown ticket.';
    }

    _showResultDialog(valid: valid, title: title, message: message);
  }

  void _showResultDialog({
    required bool valid,
    required String title,
    required String message,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 10,
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top icon in a tonal circle
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: valid
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.errorContainer,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    valid ? Icons.check_rounded : Icons.close_rounded,
                    color: valid
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).colorScheme.onErrorContainer,
                    size: 44,
                  ),
                ),

                const SizedBox(height: 20),

                // Title
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: valid
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.error,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                // Message
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                // Buttons row
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // close dialog
                          _resumeScanner(); // resume scanning
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: valid
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.error,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                        ),
                        child: const Text(
                          "Scan Another",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context); // close dialog
                          Navigator.pop(context); // close scanner screen
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: valid
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.error,
                            width: 2,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Close",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: valid
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resumeScanner() {
    setState(() => _isScanning = true);
    _controller.start();
  }

  void _showInvalidFormat() {
    setState(() => _isScanning = false);

    _showResultDialog(
      valid: false,
      title: "Invalid QR Code",
      message: "Invalid QR code format.",
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ValidateAttendeeBloc, ValidateAttendeeState>(
      listener: (context, state) {
        if (state is ValidateAttendeeLoaded) {
          _handleAttendeeStatus(state.status);
        } else if (state is ValidateAttendeeError) {
          _showResultDialog(
            valid: false,
            title: "Error",
            message: state.message,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Scan Ticket"), centerTitle: true),
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

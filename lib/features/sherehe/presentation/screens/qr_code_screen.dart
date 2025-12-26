import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class QrCodeScreen extends StatefulWidget {
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
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final GlobalKey _screenKey = GlobalKey();
  bool _isGenerating = false;

  Future<void> _downloadTicket() async {
    if (_isGenerating) return;

    setState(() => _isGenerating = true);

    try {
      final pdfFile = await _generateTicketPdf();

      if (!mounted) return;

      await Share.shareXFiles([
        XFile(pdfFile.path),
      ], text: 'Here is your ticket for ${widget.ticketName}!');
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to generate ticket')),
      );
    } finally {
      if (mounted) {
        setState(() => _isGenerating = false);
      }
    }
  }

  Future<File> _generateTicketPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5.landscape,
        build: (context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              color: PdfColor.fromInt(0xFFF5F5F5),
              borderRadius: pw.BorderRadius.circular(12),
              boxShadow: [
                pw.BoxShadow(
                  color: PdfColor.fromInt(0x44000000),
                  blurRadius: 6,
                ),
              ],
            ),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(16),
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromInt(0xFF1C1C1E),
                      borderRadius: const pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(12),
                        bottomLeft: pw.Radius.circular(12),
                      ),
                    ),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Sample Event Name',
                          style: pw.TextStyle(
                            fontSize: 22,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(0xFFFFFFFF),
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          '10 Sep 2025  03:00 AM',
                          style: pw.TextStyle(
                            fontSize: 14,
                            color: PdfColor.fromInt(0xFFCCCCCC),
                          ),
                        ),
                        pw.SizedBox(height: 16),
                        pw.Text(
                          widget.ticketName,
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(0xFFFFFFFF),
                          ),
                        ),
                        pw.Text(
                          'Quantity: ${widget.quantity}',
                          style: pw.TextStyle(
                            fontSize: 14,
                            color: PdfColor.fromInt(0xFFCCCCCC),
                          ),
                        ),
                        pw.Spacer(),
                        pw.Text(
                          'Present this QR code at the entrance\nUnique and single use',
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromInt(0xFFFF5555),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                pw.Expanded(
                  flex: 1,
                  child: pw.Container(
                    margin: const pw.EdgeInsets.only(left: 4),
                    padding: const pw.EdgeInsets.all(16),
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromInt(0xFFE0E0E0),
                      borderRadius: const pw.BorderRadius.only(
                        topRight: pw.Radius.circular(12),
                        bottomRight: pw.Radius.circular(12),
                      ),
                    ),
                    child: pw.Center(
                      child: pw.BarcodeWidget(
                        data: widget.eventId,
                        barcode: pw.Barcode.qrCode(),
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/ticket_${widget.eventId}.pdf');

    await file.writeAsBytes(await pdf.save());
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Ticket"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: _isGenerating
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.download_outlined),
            onPressed: _isGenerating ? null : _downloadTicket,
          ),
        ],
      ),
      body: SafeArea(
        child: RepaintBoundary(
          key: _screenKey,
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
                      width: (MediaQuery.sizeOf(context).shortestSide * 0.65)
                          .clamp(220.0, 320.0),
                      height: (MediaQuery.sizeOf(context).shortestSide * 0.65)
                          .clamp(220.0, 320.0),
                      child: PrettyQrView.data(
                        data: widget.eventId, //placeholder for now
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
                      widget.ticketName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Quantity: ${widget.quantity}',
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
      ),
    );
  }
}

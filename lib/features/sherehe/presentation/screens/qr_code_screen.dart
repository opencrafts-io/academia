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

    const primaryBg = PdfColor.fromInt(0xFF1A1A1A);
    const accentColor = PdfColor.fromInt(0xFF00A3FF);
    const stubBg = PdfColor.fromInt(0xFFF2F2F2);
    const ticketBorder = PdfColor.fromInt(0xFFE0E0E0);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5,
        build: (context) {
          return pw.Center(
            child: pw.Container(
              width: 280,
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(15),
                border: pw.Border.all(color: ticketBorder, width: 0.5),
              ),
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 30,
                    ),
                    decoration: const pw.BoxDecoration(
                      color: primaryBg,
                      borderRadius: pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(15),
                        topRight: pw.Radius.circular(15),
                      ),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'OFFICIAL TICKET',
                              style: pw.TextStyle(
                                color: accentColor,
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                            pw.Text(
                              '#${widget.eventId.substring(0, 8).toUpperCase()}',
                              style: pw.TextStyle(
                                color: PdfColors.grey600,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 12),
                        pw.Text(
                          'Sample Event Name'.toUpperCase(),
                          style: pw.TextStyle(
                            fontSize: 22,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.white,
                          ),
                        ),
                        pw.SizedBox(height: 20),
                        _TicketInfoRow(
                          label1: 'DATE',
                          value1: 'WED, 10 SEP 2025',
                          label2: 'TIME',
                          value2: '03:00 AM',
                        ),
                        pw.SizedBox(height: 15),
                        _TicketInfoRow(
                          label1: 'LOCATION',
                          value1: 'NAIROBI, KENYA',
                          label2: 'TICKET QUANTITY',
                          value2: '${widget.quantity}',
                        ),
                      ],
                    ),
                  ),

                  pw.Container(
                    height: 30,
                    color: primaryBg,
                    child: pw.Stack(
                      alignment: pw.Alignment.center,
                      children: [
                        pw.Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: pw.Container(height: 15, color: stubBg),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: pw.Row(
                            children: List.generate(
                              25,
                              (index) => pw.Expanded(
                                child: pw.Container(
                                  height: 1,
                                  color: PdfColors.grey400,
                                  margin: const pw.EdgeInsets.symmetric(
                                    horizontal: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Left Notch: Set color to white to match the PDF page background
                        pw.Positioned(
                          left: -15,
                          child: pw.Container(
                            width: 30,
                            height: 30,
                            decoration: const pw.BoxDecoration(
                              color: PdfColors.white,
                              shape: pw.BoxShape.circle,
                            ),
                          ),
                        ),
                        // Right Notch: Set color to white to match the PDF page background
                        pw.Positioned(
                          right: -15,
                          child: pw.Container(
                            width: 30,
                            height: 30,
                            decoration: const pw.BoxDecoration(
                              color: PdfColors.white,
                              shape: pw.BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.only(
                      top: 10,
                      bottom: 25,
                      left: 24,
                      right: 24,
                    ),
                    decoration: const pw.BoxDecoration(
                      color: stubBg,
                      borderRadius: pw.BorderRadius.only(
                        bottomLeft: pw.Radius.circular(15),
                        bottomRight: pw.Radius.circular(15),
                      ),
                    ),
                    child: pw.Column(
                      children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(8),
                          decoration: pw.BoxDecoration(
                            color: PdfColors.white,
                            borderRadius: pw.BorderRadius.circular(8),
                            border: pw.Border.all(
                              color: ticketBorder,
                              width: 0.5,
                            ),
                          ),
                          child: pw.BarcodeWidget(
                            data: widget.eventId,
                            barcode: pw.Barcode.qrCode(),
                            width: 100,
                            height: 100,
                            drawText: false,
                          ),
                        ),
                        pw.SizedBox(height: 15),
                        pw.Text(
                          widget.ticketName.toUpperCase(),
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12,
                            color: primaryBg,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          '18c7887-45b8679-568',
                          style: pw.TextStyle(
                            fontSize: 7,
                            color: PdfColors.grey600,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
    );
  }
}

class _TicketInfoRow extends pw.StatelessWidget {
  final String label1;
  final String value1;
  final String label2;
  final String value2;

  _TicketInfoRow({
    required this.label1,
    required this.value1,
    required this.label2,
    required this.value2,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Row(
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                label1,
                style: const pw.TextStyle(
                  color: PdfColors.grey500,
                  fontSize: 8,
                ),
              ),
              pw.Text(
                value1,
                style: pw.TextStyle(
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                label2,
                style: const pw.TextStyle(
                  color: PdfColors.grey500,
                  fontSize: 8,
                ),
              ),
              pw.Text(
                value2,
                style: pw.TextStyle(
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

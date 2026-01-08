import 'dart:io';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class QrCodeScreen extends StatefulWidget {
  final String eventId;
  final String attendeeId;
  final Event event;
  final String ticketName;
  final int quantity;

  const QrCodeScreen({
    super.key,
    required this.eventId,
    required this.attendeeId,
    required this.event,
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
      await Share.shareXFiles([
        XFile(pdfFile.path),
      ], text: 'Here is your ticket for ${widget.ticketName}!');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            Platform.isAndroid
                ? 'Ticket saved to Downloads'
                : 'Ticket saved to Files',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
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

  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      final dir = Directory('/storage/emulated/0/Download');
      if (await dir.exists()) return dir;
    }

    // iOS or fallback
    return await getApplicationDocumentsDirectory();
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
                          widget.event.eventName.toUpperCase(),
                          style: pw.TextStyle(
                            fontSize: 22,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.white,
                          ),
                        ),
                        pw.SizedBox(height: 20),
                        _PdfTicketInfo(
                          label1: 'DATE',
                          value1: ShereheUtils.formatDate(
                            widget.event.eventDate,
                          ),
                          label2: 'TIME',
                          value2: ShereheUtils.formatTime(
                            widget.event.eventDate,
                          ),
                        ),
                        pw.SizedBox(height: 15),
                        _PdfTicketInfo(
                          label1: 'LOCATION',
                          value1: widget.event.eventLocation,
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
                            data: 'attendee:${widget.eventId}', //placeholder for now
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
                          widget.eventId.substring(0,18).toLowerCase(),
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

    final dir = await _getDownloadDirectory();
    final file = File(
      '${dir.path}/ticket_${widget.ticketName}_${widget.eventId}.pdf',
    );
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Ticket"),
        centerTitle: true,
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Container(
                  width: (MediaQuery.sizeOf(context).width * 0.85).clamp(
                    280.0,
                    400.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'OFFICIAL TICKET',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  '#${widget.eventId.substring(0, 8).toUpperCase()}',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.outline,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              widget.event.eventName.toUpperCase(),
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                                  ),
                            ),
                            const SizedBox(height: 24),
                            _TicketInfoWidget(
                              label1: 'DATE',
                              value1: ShereheUtils.formatDate(
                                widget.event.eventDate,
                              ),
                              label2: 'TIME',
                              value2: ShereheUtils.formatTime(
                                widget.event.eventDate,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _TicketInfoWidget(
                              label1: 'LOCATION',
                              value1: widget.event.eventLocation,
                              label2: 'QUANTITY',
                              value2: '${widget.quantity}',
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Bottom half background
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 15,
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                              ),
                            ),
                            // Perforation dashes
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: Row(
                                children: List.generate(
                                  20,
                                  (index) => Expanded(
                                    child: Container(
                                      height: 1,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 2,
                                      ),
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.outlineVariant,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Left Notch
                            Positioned(
                              left: -15,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.surface,
                              ),
                            ),
                            // Right Notch
                            Positioned(
                              right: -15,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.surface,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //BOTTOM SECTION
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: PrettyQrView.data(
                                data:'attendee:${widget.eventId}', //placeholder for now
                                decoration: const PrettyQrDecoration(
                                  shape: PrettyQrSmoothSymbol(
                                    color: Colors.black,
                                  ),
                                  quietZone: PrettyQrQuietZone.standart,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              widget.ticketName.toUpperCase(),
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.eventId.substring(0,18).toLowerCase(),
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                    letterSpacing: 1,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "This QR code is unique and can only be used once. Do not share your ticket with anyone.",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TicketInfoWidget extends StatelessWidget {
  final String label1;
  final String value1;
  final String label2;
  final String value2;

  const _TicketInfoWidget({
    required this.label1,
    required this.value1,
    required this.label2,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label1,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onPrimaryContainer.withValues(alpha: 0.6),
                ),
              ),
              Text(
                value1,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label2,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onPrimaryContainer.withValues(alpha: 0.6),
                ),
              ),
              Text(
                value2,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PdfTicketInfo extends pw.StatelessWidget {
  final String label1;
  final String value1;
  final String label2;
  final String value2;

  _PdfTicketInfo({
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

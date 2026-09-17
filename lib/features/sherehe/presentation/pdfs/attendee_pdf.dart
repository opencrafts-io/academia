import 'dart:io';
import 'package:academia/features/sherehe/domain/entities/event.dart';
import 'package:academia/features/sherehe/presentation/utils/sherehe_utils.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<pw.MemoryImage> loadPdfImage(String assetPath) async {
  final bytes = await rootBundle.load(assetPath);
  return pw.MemoryImage(bytes.buffer.asUint8List());
}

Future<File> generateTicketPdf({
  required bool isMultiEvent,
  required String eventId,
  required Event event,
  required String attendeeId,
  required String ticketName,
  required int quantity,
  required String access,
  required String dates,
}) async {
  final pdf = pw.Document();

  const primaryBg = PdfColor.fromInt(0xFF1A1A1A);
  const accentColor = PdfColor.fromInt(0xFF00A3FF);
  const stubBg = PdfColor.fromInt(0xFFF2F2F2);
  const ticketBorder = PdfColor.fromInt(0xFFE0E0E0);
  final logo = await loadPdfImage(Assets.icons.opencrafts.path);

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
                            '#${eventId.substring(0, 8).toUpperCase()}',
                            style: pw.TextStyle(
                              color: PdfColors.grey600,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        event.eventName.toUpperCase(),
                        maxLines: 2,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.white,
                        ),
                      ),
                      pw.SizedBox(height: 20),
                      if (!isMultiEvent) ...[
                        _PdfTicketInfo(
                          label1: 'DATE',
                          value1: ShereheUtils.formatDate(event.startDate),
                          label2: 'TIME',
                          value2: ShereheUtils.formatTime(event.startDate),
                        ),
                        pw.SizedBox(height: 15),
                        _PdfTicketInfo(
                          label1: 'LOCATION',
                          value1: event.eventLocation,
                          label2: 'TICKET QUANTITY',
                          value2: '$quantity',
                        ),
                      ] else ...[
                        _PdfTicketInfo(
                          label1: 'ACCESS',
                          value1: access,
                          label2: 'DATES',
                          value2: dates,
                        ),
                        pw.SizedBox(height: 15),
                        _PdfTicketInfo(
                          label1: 'LOCATION',
                          value1: event.eventLocation,
                          label2: 'TICKET QUANTITY',
                          value2: '$quantity',
                        ),
                      ],
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
                        padding: const pw.EdgeInsets.symmetric(horizontal: 20),
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
                          data: 'academia@opencrafts:$attendeeId',
                          barcode: pw.Barcode.qrCode(),
                          width: 100,
                          height: 100,
                          drawText: false,
                        ),
                      ),
                      pw.SizedBox(height: 15),
                      pw.Text(
                        ticketName.toUpperCase(),
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 10,
                          color: primaryBg,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        eventId.substring(0, 18).toLowerCase(),
                        style: pw.TextStyle(
                          fontSize: 7,
                          color: PdfColors.grey600,
                          letterSpacing: 1,
                        ),
                      ),
                      pw.SizedBox(height: 10),

                      pw.Image(
                        logo,
                        width: 20,
                        height: 20,
                        fit: pw.BoxFit.contain,
                      ),

                      pw.SizedBox(height: 6),

                      pw.Text(
                        "Powered by Opencrafts",
                        style: pw.TextStyle(
                          fontSize: 8,
                          fontWeight: pw.FontWeight.bold,
                          color: primaryBg,
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

  // Save to **temporary directory**
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/ticket_${ticketName}_$eventId.pdf');
  await file.writeAsBytes(await pdf.save());
  return file;
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
                  fontSize: 8,
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

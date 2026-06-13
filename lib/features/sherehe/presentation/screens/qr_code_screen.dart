import 'package:academia/config/router/routes.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';

class QrCodeScreen extends StatefulWidget {
  final String eventId;
  final String attendeeId;
  final Event event;
  final String ticketName;
  final String? ticketStartDate;
  final String? ticketEndDate;
  final int quantity;

  const QrCodeScreen({
    super.key,
    required this.eventId,
    required this.attendeeId,
    required this.event,
    required this.ticketName,
    this.ticketStartDate,
    this.ticketEndDate,
    required this.quantity,
  });

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  DateTime get eventStart => DateTime.parse(widget.event.startDate);
  DateTime get eventEnd => DateTime.parse(widget.event.endDate);
  bool get isMultiDayEvent =>
      eventEnd.difference(eventStart) > const Duration(hours: 24);
  bool _isGenerating = false;

  Future<void> _downloadTicket({required bool isMultiEvent}) async {
    if (_isGenerating) return;

    setState(() => _isGenerating = true);

    try {
      final pdfFile = await generateTicketPdf(
        isMultiEvent: isMultiEvent,
        eventId: widget.eventId,
        event: widget.event,
        attendeeId: widget.attendeeId,
        ticketName: widget.ticketName,
        quantity: widget.quantity,
        ticketStartDate: widget.ticketStartDate,
        ticketEndDate: widget.ticketEndDate,
      );

      if (!mounted) return;
      // Share the PDF
      final box = context.findRenderObject() as RenderBox?;
      await Share.shareXFiles(
        [XFile(pdfFile.path)],
        text: 'Here is your ticket for ${widget.ticketName}!',
        sharePositionOrigin: box != null
            ? box.localToGlobal(Offset.zero) & box.size
            : null,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ticket Downloaded Successfully'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to generate ticket pdf')),
      );
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Ticket"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              HomeRoute().go(context);
            }
          },
        ),
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
            onPressed: _isGenerating
                ? null
                : () => _downloadTicket(isMultiEvent: isMultiDayEvent),
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
                            if (!isMultiDayEvent) ...[
                              _TicketInfoWidget(
                                label1: 'DATE',
                                value1: ShereheUtils.formatDate(
                                  widget.event.startDate,
                                ),
                                label2: 'TIME',
                                value2: ShereheUtils.formatTime(
                                  widget.event.startDate,
                                ),
                              ),
                            ] else ...[
                              _TicketInfoWidget(
                                label1: 'ACCESS',
                                value1:
                                    ShereheUtils.calculateDaysBetweenForTicket(
                                      startDate: widget.ticketStartDate,
                                      endDate: widget.ticketEndDate,
                                    ),
                                label2: 'DATES',
                                value2:
                                    (widget.ticketStartDate != null &&
                                        widget.ticketEndDate != null)
                                    ? '${ShereheUtils.formatShortMonthDay(widget.ticketStartDate!)} - ${ShereheUtils.formatShortMonthDay(widget.ticketEndDate!)}'
                                    : 'TBC',
                              ),
                            ],
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
                                data:
                                    'academia@opencrafts:${widget.attendeeId}',
                                decoration: PrettyQrDecoration(
                                  image: PrettyQrDecorationImage(
                                    image: AssetImage(
                                      Assets.icons.opencrafts.path,
                                    ),
                                  ),
                                  quietZone: PrettyQrQuietZone.standard,
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
                              widget.eventId.substring(0, 18).toLowerCase(),
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

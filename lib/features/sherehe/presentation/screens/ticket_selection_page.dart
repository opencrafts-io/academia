import 'package:academia/config/config.dart';
import 'package:academia/features/institution/domain/entities/institution.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TicketSelectionPage extends StatefulWidget {
  final DateTime eventStartDateTime;
  final DateTime eventEndDateTime;
  final List<TicketUI> tickets;
  final Function(TicketUI ticket) onAddTicket;
  final Function(TicketUI ticket) onRemoveTicket;
  final Function(TicketUI oldTicket, TicketUI updatedTicket) onUpdateTicket;
  final Function(List<TicketUI> tickets) onContinue;
  final Function() onSkip;
  final VoidCallback onPrevious;
  final ScopeTypes? selectedEventScopeType;
  final List<Institution>? eligibleInstitutions;

  const TicketSelectionPage({
    super.key,
    required this.tickets,
    required this.eventStartDateTime,
    required this.eventEndDateTime,
    required this.onAddTicket,
    required this.onRemoveTicket,
    required this.onUpdateTicket,
    required this.onContinue,
    required this.onSkip,
    required this.onPrevious,
    required this.selectedEventScopeType,
    this.eligibleInstitutions,
  });

  @override
  State<TicketSelectionPage> createState() => _TicketSelectionPageState();
}

class _TicketSelectionPageState extends State<TicketSelectionPage> {
  bool get isMultiDayEvent =>
      widget.eventEndDateTime.difference(widget.eventStartDateTime) >
      const Duration(hours: 24);
  bool get isFreeEvent => widget.tickets.any((t) => t.ticket.ticketPrice == 0);

  void _addTicket(BuildContext context) async {
    final addedTicket = await context.push(
      AddTicketRoute(
        isMultiDayEvent: isMultiDayEvent,
        eventStartDateTime: widget.eventStartDateTime,
        eventEndDateTime: widget.eventEndDateTime,
        isTicketPage: true,
        isEventScopeInstitution:
            widget.selectedEventScopeType == ScopeTypes.institution,
      ).location,
      extra: widget.selectedEventScopeType == ScopeTypes.institution
          ? widget.eligibleInstitutions
          : null,
    );

    if (!context.mounted) return;

    if (addedTicket != null && addedTicket is TicketUI) {
      widget.onAddTicket(addedTicket);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Ticket added Successfully"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }

  Future<void> _showFreeTicketQuantityDialog() async {
    final freeTicketQuantityDialogFormKey = GlobalKey<FormState>();
    final TextEditingController qtyController = TextEditingController();

    final result = await showDialog<int>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Form(
          key: freeTicketQuantityDialogFormKey,
          child: AlertDialog(
            title: const Text("Free Event Quantity"),
            content: TextFormField(
              controller: qtyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Number of free tickets",
              ),
              validator: (value) =>
                  int.tryParse(value ?? "") == null || int.parse(value!) <= 0
                  ? "Enter a valid quantity"
                  : null,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              FilledButton(
                onPressed: () {
                  if (freeTicketQuantityDialogFormKey.currentState!
                      .validate()) {
                    final qty = int.tryParse(qtyController.text.trim());
                    Navigator.pop(context, qty);
                  }
                },
                child: const Text("Confirm"),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      final freeTicket = Ticket(
        ticketName: "Free Ticket",
        ticketPrice: 0,
        ticketQuantity: result,
        ticketFor: 1,
        institutionIds: [],
        scope: ScopeTypes.public.toBackend,
        startDate: widget.eventStartDateTime.toUtc().toIso8601String(),
        endDate: widget.eventEndDateTime.toUtc().toIso8601String(),
      );

      widget.onContinue([
        TicketUI(
          ticket: freeTicket,
          institutions: [],
          selectedTicketGroupType: TicketGroupTypes.individual,
          selectedScopeType: ScopeTypes.public,
          selectedTicketDateRange: null,
        ),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          if (isFreeEvent) ...[
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 12.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "This is a FREE event.\nDelete the free ticket to add more tickets(if you wish to change it to a Paid event).",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ] else ...[
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create Ticket Types",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Add different ticket categories such as VIP, Regular, Early Bird, etc.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],

          if (widget.tickets.isEmpty) ...[
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        spacing: 12,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.confirmation_number_outlined, size: 64),
                          Text("No tickets added yet"),
                          FilledButton.icon(
                            onPressed: () => _addTicket(context),
                            icon: Icon(Icons.add),
                            label: Text("Add your first ticket"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    spacing: 12.0,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: widget.onPrevious,
                          child: const Text("Back"),
                        ),
                      ),
                      Expanded(
                        child: FilledButton(
                          onPressed: _showFreeTicketQuantityDialog,
                          child: const Text("Skip (Free Event)"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ] else ...[
            SliverList.builder(
              itemCount: widget.tickets.length,
              itemBuilder: (context, index) {
                final ticket = widget.tickets[index];
                return AddedTicketsCard(
                  addedTicket: ticket,
                  isMultiDayEvent: isMultiDayEvent,
                  isFreeEvent: isFreeEvent,
                  onEditTicket: () async {
                    final updatedTicket = await context.push(
                      EditAddedTicketRoute(
                        isMultiDayEvent: isMultiDayEvent,
                        eventStartDateTime: widget.eventStartDateTime,
                        eventEndDateTime: widget.eventEndDateTime,
                        isTicketPage: true,
                        isEventScopeInstitution:
                            widget.selectedEventScopeType ==
                            ScopeTypes.institution,
                      ).location,
                      extra: EditAddedTicketArgs(
                        ticket: ticket,
                        eligibleInstitutions: widget.eligibleInstitutions,
                      ),
                    );

                    if (!context.mounted) return;

                    if (updatedTicket != null && updatedTicket is TicketUI) {
                      widget.onUpdateTicket(ticket, updatedTicket);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Ticket Edited Successfully"),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                        ),
                      );
                    }
                  },
                  onRemoveTicket: () => widget.onRemoveTicket(ticket),
                );
              },
            ),
            if (!isFreeEvent)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: OutlinedButton.icon(
                    onPressed: () => _addTicket(context),
                    icon: const Icon(Icons.add),
                    label: const Text("Add Another Ticket"),
                  ),
                ),
              ),

            SliverFillRemaining(
              hasScrollBody: false,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 12.0,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onPrevious,
                      child: const Text("Back"),
                    ),
                  ),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => widget.onContinue(widget.tickets),
                      child: const Text("Continue"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

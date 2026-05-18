import 'package:academia/features/institution/domain/entities/institution.dart';
import 'package:academia/features/sherehe/domain/entities/ticket_ui.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditAddedTicketScreen extends StatefulWidget {
  final TicketUI addedTicket;
  final bool isMultiDayEvent;
  final DateTime eventStartDateTime;
  final DateTime eventEndDateTime;

  const EditAddedTicketScreen({
    super.key,
    required this.addedTicket,
    this.isMultiDayEvent = false,
    required this.eventStartDateTime,
    required this.eventEndDateTime,
  });

  @override
  State<EditAddedTicketScreen> createState() => _EditAddedTicketScreenState();
}

class _EditAddedTicketScreenState extends State<EditAddedTicketScreen> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController quantityController;
  late TicketGroupTypes? selectedTicketGroupType;
  late ScopeTypes? selectedScopeType;
  late Set<Institution> selectedInstitutions;
  late DateTimeRange? selectedTicketDateRange;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.addedTicket.ticket.ticketName,
    );
    priceController = TextEditingController(
      text: widget.addedTicket.ticket.ticketPrice.toString(),
    );
    quantityController = TextEditingController(
      text: widget.addedTicket.ticket.ticketQuantity.toString(),
    );
    selectedTicketGroupType = widget.addedTicket.selectedTicketGroupType;
    selectedScopeType = widget.addedTicket.selectedScopeType;
    selectedInstitutions = widget.addedTicket.institutions.toSet();
    selectedTicketDateRange = widget.addedTicket.selectedTicketDateRange;

    nameController.addListener(() => setState(() {}));
    priceController.addListener(() => setState(() {}));
    quantityController.addListener(() => setState(() {}));
  }

  bool get _canSave {
    final price = int.tryParse(priceController.text);
    final qty = int.tryParse(quantityController.text);

    if (nameController.text.trim().isEmpty) return false;
    if (price == null || price <= 0) return false;
    if (qty == null || qty <= 0) return false;
    if (selectedTicketGroupType == null) return false;
    if (selectedScopeType == ScopeTypes.institution &&
        selectedInstitutions.isEmpty) {
      return false;
    }
    if (selectedTicketDateRange == null) return false;

    return true;
  }

  void _save() {
    final price = int.tryParse(priceController.text);
    final qty = int.tryParse(quantityController.text);
    final updatedTicket = widget.addedTicket.copyWith(
      ticket: widget.addedTicket.ticket.copyWith(
        ticketName: nameController.text.trim(),
        ticketPrice: price,
        ticketQuantity: qty,
        institutionIds: selectedScopeType == ScopeTypes.institution
            ? []
            : selectedInstitutions.map((e) => e.institutionId).toList(),
        startDate:
            selectedTicketDateRange?.start.toUtc().toIso8601String() ??
            widget.eventStartDateTime.toUtc().toIso8601String(),
        endDate:
            selectedTicketDateRange?.end.toUtc().toIso8601String() ??
            widget.eventEndDateTime.toUtc().toIso8601String(),
      ),
      selectedTicketGroupType: selectedTicketGroupType,
      institutions: selectedInstitutions.toList(),
      selectedScopeType: selectedScopeType,
      selectedTicketDateRange: selectedTicketDateRange,
    );
    context.pop(updatedTicket);
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: const Text("Edit Ticket"),
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  spacing: 20,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Ticket Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Enter ticket name',
                      ),

                      validator: (v) => v == null || v.isEmpty
                          ? "Please enter ticket name"
                          : null,
                    ),
                    TextFormField(
                      controller: priceController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Ticket Price',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Enter ticket price',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        final num? parsed = num.tryParse(value ?? "");
                        if (parsed == null) return "Please enter Ticket Price";
                        if (parsed <= 0) {
                          return "Please enter a valid Ticket Price";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: quantityController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Ticket Quantity',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Enter ticket quantity',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        final int? parsed = int.tryParse(value ?? "");
                        if (parsed == null) {
                          return "Please enter Ticket Quantity";
                        }
                        if (parsed <= 0) {
                          return "Ticket Quantity must be at least 1";
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      initialValue: selectedTicketGroupType,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: "Ticket Type",
                        hintText: "Select ticket type",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      items: TicketGroupTypes.values.map((type) {
                        return DropdownMenuItem<TicketGroupTypes>(
                          value: type,
                          child: Text(type.label),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedTicketGroupType = val;
                        });
                      },
                      validator: (value) {
                        if (value == null) return "Please Select ticket type";
                        return null;
                      },
                    ),
                    TicketVisibilitySelector(
                      selectedScopeType: selectedScopeType,
                      selectedInstitutions: selectedInstitutions.toList(),
                      onScopeChanged: (value) {
                        setState(() {
                          selectedScopeType = value;
                          if (selectedScopeType != ScopeTypes.institution) {
                            selectedInstitutions.clear();
                          }
                        });
                      },
                      onInstitutionsChanged: (institutions) {
                        setState(() {
                          if (institutions != null) {
                            selectedInstitutions = institutions.toSet();
                          }
                        });
                      },
                    ),
                    if (widget.isMultiDayEvent)
                      TicketDateRangeWidget(
                        selectedTicketDateRange: selectedTicketDateRange,
                        eventStartDateTime: widget.eventStartDateTime,
                        eventEndDateTime: widget.eventEndDateTime,
                        onDateRangeChanged: (dateRange) {
                          setState(() {
                            selectedTicketDateRange = dateRange;
                          });
                        },
                      ),
                    Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                        ),
                        Expanded(
                          child: FilledButton(
                            onPressed: _canSave ? _save : null,
                            child: const Text("Save"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

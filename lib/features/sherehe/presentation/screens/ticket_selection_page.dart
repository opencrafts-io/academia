import 'package:academia/features/institution/domain/domain.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';

class TicketSelectionPage extends StatefulWidget {
  final List<TicketUI> initialTickets;
  final Function(List<TicketUI> tickets) onContinue;
  final Function() onSkip;
  final VoidCallback onPrevious;

  const TicketSelectionPage({
    super.key,
    required this.initialTickets,
    required this.onContinue,
    required this.onSkip,
    required this.onPrevious,
  });

  @override
  State<TicketSelectionPage> createState() => _TicketSelectionPageState();
}

class _TicketSelectionPageState extends State<TicketSelectionPage> {
  final _formKey = GlobalKey<FormState>();

  final _ticketNameController = TextEditingController();
  final _ticketPriceController = TextEditingController();
  final _ticketQtyController = TextEditingController();

  late List<TicketUI> _tickets;
  bool _isPublic = true;
  final Set<Institution> _selectedInstitutions = {};

  @override
  void initState() {
    super.initState();
    _tickets = widget.initialTickets;
  }

  @override
  void dispose() {
    _ticketNameController.dispose();
    _ticketPriceController.dispose();
    _ticketQtyController.dispose();
    super.dispose();
  }

  void _addTicket() {
    if (!_isPublic && _selectedInstitutions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Select at least one institution for restricted tickets",
          ),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final ticket = Ticket(
        ticketName: _ticketNameController.text.trim(),
        ticketPrice: int.tryParse(_ticketPriceController.text.trim()) ?? 0,
        ticketQuantity: int.tryParse(_ticketQtyController.text.trim()) ?? 0,
        institutionIds: _isPublic
            ? null
            : _selectedInstitutions.map((e) => e.institutionId).toList(),
      );

      setState(() {
        _tickets.add(
          TicketUI(
            ticket: ticket,
            isPublic: _isPublic,
            institutions: List.from(_selectedInstitutions),
          ),
        );
        _ticketNameController.clear();
        _ticketPriceController.clear();
        _ticketQtyController.clear();
        _isPublic = true;
        _selectedInstitutions.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Ticket added"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }

  Future<void> _editTicketDialog(int index) async {
    final current = _tickets[index];

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return TicketEditorSheet(
          initial: current,
          onSave: (updated) {
            setState(() {
              _tickets[index] = updated;
            });
          },
        );
      },
    );
  }

  Future<void> _showFreeTicketQuantityDialog() async {
    final TextEditingController qtyController = TextEditingController();

    final result = await showDialog<int>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Free Event Quantity"),
          content: TextField(
            controller: qtyController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Number of free tickets",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () {
                final qty = int.tryParse(qtyController.text.trim());
                if (qty == null || qty <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Enter a valid quantity")),
                  );
                  return;
                }
                Navigator.pop(context, qty);
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );

    if (result != null) {
      final freeTicket = Ticket(
        ticketName: "Free Ticket",
        ticketPrice: 0,
        ticketQuantity: result,
        institutionIds: [],
      );

      widget.onContinue([
        TicketUI(ticket: freeTicket, isPublic: true, institutions: []),
      ]);
    }
  }

  void _submit() {
    if (_tickets.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add at least one ticket")),
      );
      return;
    }
    widget.onContinue(_tickets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_tickets.any((t) => t.ticket.ticketPrice == 0)) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    "This is a FREE event.\nDelete the free ticket to add more tickets(if you wish to change it to a Paid event).",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ] else ...[
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
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _ticketNameController,
                        decoration: const InputDecoration(
                          labelText: "Ticket Name",
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? "Enter name" : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _ticketPriceController,
                        decoration: const InputDecoration(labelText: "Price"),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          final num? parsed = num.tryParse(value ?? "");
                          if (parsed == null) return "Price?";
                          if (parsed <= 0) return "Invalid";
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _ticketQtyController,
                        decoration: const InputDecoration(
                          labelText: "Quantity",
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          final int? parsed = int.tryParse(value ?? "");
                          if (parsed == null || parsed <= 0) return "Qty?";
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TicketVisibilitySelector(
                  isPublic: _isPublic,
                  selectedInstitutions: _selectedInstitutions.toList(),

                  onVisibilityChanged: (isPublic) {
                    setState(() {
                      _isPublic = isPublic ?? true;
                      if (_isPublic) _selectedInstitutions.clear();
                    });
                  },
                  onInstitutionSelected: (inst, selected) {
                    setState(() {
                      if (selected) {
                        if (!_selectedInstitutions.any(
                          (e) => e.institutionId == inst.institutionId,
                        )) {
                          _selectedInstitutions.add(inst);
                        }
                      } else {
                        _selectedInstitutions.removeWhere(
                          (e) => e.institutionId == inst.institutionId,
                        );
                      }
                    });
                  },
                ),

                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: _addTicket,
                    label: const Text("Add Ticket"),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              Text(
                "Added Tickets",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              if (_tickets.isEmpty) ...[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.confirmation_number_outlined, size: 64),
                        SizedBox(height: 12),
                        Text("No tickets added yet"),
                      ],
                    ),
                  ),
                ),
              ] else
                Column(
                  children: _tickets.map((ui) {
                    final t = ui.ticket;
                    final isPublic = ui.isPublic;
                    final institutions = ui.institutions;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Ticket main info
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  t.ticketName,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () => _editTicketDialog(
                                        _tickets.indexOf(ui),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () =>
                                          setState(() => _tickets.remove(ui)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Price: ${t.ticketPrice} • Qty: ${t.ticketQuantity}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8),

                            // Visibility info
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Chip(
                                  label: Text(
                                    isPublic ? "Everyone" : "Restricted",
                                  ),
                                  backgroundColor: isPublic
                                      ? Theme.of(
                                          context,
                                        ).colorScheme.primaryContainer
                                      : Theme.of(
                                          context,
                                        ).colorScheme.secondaryContainer,
                                  labelStyle: TextStyle(
                                    color: isPublic
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.onPrimaryContainer
                                        : Theme.of(
                                            context,
                                          ).colorScheme.onSecondaryContainer,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (!isPublic && institutions.isNotEmpty)
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 6,
                                    children: institutions.map((inst) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.tertiaryContainer,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Text(
                                          inst.name,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onTertiaryContainer,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),

              const SizedBox(height: 24),

              Row(
                spacing: 12.0,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onPrevious,
                      child: const Text("Back"),
                    ),
                  ),

                  if (_tickets.isEmpty)
                    Expanded(
                      child: FilledButton(
                        onPressed: _showFreeTicketQuantityDialog,
                        child: const Text("Skip (Free Event)"),
                      ),
                    ),

                  if (_tickets.isNotEmpty)
                    Expanded(
                      child: FilledButton(
                        onPressed: _submit,
                        child: const Text("Continue"),
                      ),
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

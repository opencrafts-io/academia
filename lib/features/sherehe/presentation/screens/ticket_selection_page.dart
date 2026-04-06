import 'package:academia/features/institution/domain/domain.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/presentation.dart';
import 'package:flutter/material.dart';

class TicketSelectionPage extends StatefulWidget {
  final List<TicketUI> tickets;
  final Function(TicketUI ticket) onAddTicket;
  final Function(TicketUI ticket) onRemoveTicket;
  final Function(List<TicketUI> tickets) onContinue;
  final Function() onSkip;
  final VoidCallback onPrevious;

  const TicketSelectionPage({
    super.key,
    required this.tickets,
    required this.onAddTicket,
    required this.onRemoveTicket,
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
  TicketGroupTypes? _selectedTicketGroupType;

  bool _isPublic = true;
  final Set<Institution> _selectedInstitutions = {};
  bool _showTickets = false;

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

      widget.onAddTicket(
        TicketUI(
          ticket: ticket,
          isPublic: _isPublic,
          institutions: List.from(_selectedInstitutions),
        ),
      );

      setState(() {
        _showTickets = true;
      });
      _ticketNameController.clear();
      _ticketPriceController.clear();
      _ticketQtyController.clear();
      _selectedTicketGroupType = null;

      _isPublic = true;
      _selectedInstitutions.clear();

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
    final current = widget.tickets[index];

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return TicketEditorSheet(
          initial: current,
          onSave: (updated) {
            setState(() {
              widget.tickets[index] = updated;
            });
          },
        );
      },
    );
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
        institutionIds: [],
      );

      widget.onContinue([
        TicketUI(ticket: freeTicket, isPublic: true, institutions: []),
      ]);
    }
  }

  void _submit() {
    if (widget.tickets.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add at least one ticket")),
      );
      return;
    }
    widget.onContinue(widget.tickets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.tickets.any((t) => t.ticket.ticketPrice == 0)) ...[
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

                TextFormField(
                  controller: _ticketNameController,
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

                const SizedBox(height: 12),

                TextFormField(
                  controller: _ticketPriceController,
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
                    if (parsed <= 0) return "Please enter a valid Ticket Price";
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _ticketQtyController,
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
                    if (parsed == null) return "Please enter Ticket Quantity";
                    if (parsed <= 0) {
                      return "Ticket Quantity must be at least 1";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField(
                  initialValue: _selectedTicketGroupType,
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
                      _selectedTicketGroupType = val;
                    });
                  },
                  validator: (value) {
                    if (value == null) return "Please Select ticket type";
                    return null;
                  },
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
                  onInstitutionsChanged: (institutions) {
                    setState(() {
                      if (institutions != null) {
                        _selectedInstitutions.addAll(institutions);
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

              GestureDetector(
                onTap: () {
                  setState(() {
                    _showTickets = !_showTickets;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Added Tickets",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        CircleAvatar(
                          radius: 12,
                          child: Text(
                            widget.tickets.length.toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      _showTickets
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              if (_showTickets) ...[
                if (widget.tickets.isEmpty) ...[
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
                    children: widget.tickets.map((ticket) {
                      return AddedTicketsCard(
                        addedTicket: ticket,
                        onEditTicket: () =>
                            _editTicketDialog(widget.tickets.indexOf(ticket)),
                        onRemoveTicket: () => widget.onRemoveTicket(ticket),
                      );
                    }).toList(),
                  ),
              ],

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

                  if (widget.tickets.isEmpty)
                    Expanded(
                      child: FilledButton(
                        onPressed: _showFreeTicketQuantityDialog,
                        child: const Text("Skip (Free Event)"),
                      ),
                    ),

                  if (widget.tickets.isNotEmpty)
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

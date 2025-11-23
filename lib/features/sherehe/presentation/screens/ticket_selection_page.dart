import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:flutter/material.dart';

class TicketSelectionPage extends StatefulWidget {
  final List<Ticket> initialTickets;
  final Function(List<Ticket> tickets) onContinue;
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

  late List<Ticket> _tickets;

  @override
  void initState() {
    super.initState();
    _tickets = List.from(widget.initialTickets);
  }

  @override
  void dispose() {
    _ticketNameController.dispose();
    _ticketPriceController.dispose();
    _ticketQtyController.dispose();
    super.dispose();
  }

  void _addTicket() {
    if (_formKey.currentState!.validate()) {
      final ticket = Ticket(
        ticketName: _ticketNameController.text.trim(),
        ticketPrice: int.tryParse(_ticketPriceController.text.trim()) ?? 0,
        ticketQuantity: int.tryParse(_ticketQtyController.text.trim()) ?? 0,
      );

      setState(() {
        _tickets.add(ticket);
        _ticketNameController.clear();
        _ticketPriceController.clear();
        _ticketQtyController.clear();
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
      );

      widget.onContinue([freeTicket]);
    }
  }

  // Submit paid tickets
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_tickets.any((t) => t.ticketPrice == 0)) ...[
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
                spacing: 8.0,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _ticketNameController,
                      decoration: const InputDecoration(
                        labelText: "Ticket Name",
                        hintText: "VIP / Regular",
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? "Enter name"
                          : null,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _ticketPriceController,
                      decoration: const InputDecoration(
                        labelText: "Price",
                        hintText: "0",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        final num? parsed = num.tryParse(value ?? "");
                        if (parsed == null) return "Price?";
                        if (parsed <= 0) return "Invalid";
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _ticketQtyController,
                      decoration: const InputDecoration(
                        labelText: "Quantity",
                        hintText: "0",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        final int? parsed = int.tryParse(value ?? "");
                        if (parsed == null || parsed <= 0) return "Qty?";
                        return null;
                      },
                    ),
                  ),
                  FilledButton(onPressed: _addTicket, child: const Text("Add")),
                ],
              ),
            ],

            const SizedBox(height: 20),

            Text(
              "Added Tickets",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: _tickets.isEmpty
                  ? Center(
                      child: Text(
                        "No tickets added yet",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _tickets.length,
                      itemBuilder: (context, index) {
                        final ticket = _tickets[index];
                        return Card(
                          child: ListTile(
                            title: Text(ticket.ticketName),
                            subtitle: Text(
                              "Price: ${ticket.ticketPrice}  •  Qty: ${ticket.ticketQuantity}",
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(() => _tickets.removeAt(index));
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 12),

            Row(
              spacing: 12.0,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onPrevious,
                    child: const Text("Back"),
                  ),
                ),

                // FREE EVENT → Skip → Ask for quantity
                if (_tickets.isEmpty)
                  Expanded(
                    child: FilledButton(
                      onPressed: _showFreeTicketQuantityDialog,
                      child: const Text("Skip (Free Event)"),
                    ),
                  ),

                // PAID EVENT → Continue
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
    );
  }
}

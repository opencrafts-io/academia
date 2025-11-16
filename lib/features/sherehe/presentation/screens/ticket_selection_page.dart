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

  // Add a ticket only if valid
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

  // Submit all collected tickets
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
                      hintText: "VIP / Regular / Early Bird",
                    ),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? "Enter ticket name"
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
                      if (parsed < 0) return "Invalid";
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

                ElevatedButton(onPressed: _addTicket, child: const Text("Add")),
              ],
            ),

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

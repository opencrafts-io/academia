import 'package:academia/features/institution/domain/entities/institution.dart';
import 'package:academia/features/sherehe/domain/entities/ticket_ui.dart';
import 'package:academia/features/sherehe/presentation/widgets/ticket_visibility_selector.dart';
import 'package:flutter/material.dart';

class TicketEditorSheet extends StatefulWidget {
  final TicketUI initial;
  final void Function(TicketUI updated) onSave;

  const TicketEditorSheet({
    super.key,
    required this.initial,
    required this.onSave,
  });

  @override
  State<TicketEditorSheet> createState() => _TicketEditorSheetState();
}

class _TicketEditorSheetState extends State<TicketEditorSheet> {
  late TextEditingController nameCtrl;
  late TextEditingController priceCtrl;
  late TextEditingController qtyCtrl;

  late bool isPublic;
  late Set<Institution> selectedInstitutions;

  @override
  void initState() {
    super.initState();
    final t = widget.initial;

    nameCtrl = TextEditingController(text: t.ticket.ticketName);
    priceCtrl = TextEditingController(text: t.ticket.ticketPrice.toString());
    qtyCtrl = TextEditingController(
      text: t.ticket.ticketQuantity?.toString() ?? "",
    );

    isPublic = t.isPublic;
    selectedInstitutions = t.institutions.toSet();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    priceCtrl.dispose();
    qtyCtrl.dispose();
    super.dispose();
  }

  bool get _canSave {
    final price = int.tryParse(priceCtrl.text);
    final qty = int.tryParse(qtyCtrl.text);

    if (nameCtrl.text.trim().isEmpty) return false;
    if (price == null || price <= 0) return false;
    if (qty == null || qty <= 0) return false;
    if (!isPublic && selectedInstitutions.isEmpty) return false;

    return true;
  }

  void _save() {
    final price = int.tryParse(priceCtrl.text);
    final qty = int.tryParse(qtyCtrl.text);

    if (nameCtrl.text.trim().isEmpty ||
        price == null ||
        qty == null ||
        qty <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid values")));
      return;
    }
    final updatedTicket = widget.initial.ticket.copyWith(
      ticketName: nameCtrl.text.trim(),
      ticketPrice: price,
      ticketQuantity: qty,
      institutionIds: isPublic
          ? null
          : selectedInstitutions.map((e) => e.institutionId).toList(),
    );

    widget.onSave(
      widget.initial.copyWith(
        ticket: updatedTicket,
        isPublic: isPublic,
        institutions: List.from(selectedInstitutions),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Edit Ticket", style: Theme.of(context).textTheme.titleLarge),

            const SizedBox(height: 12),

            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Ticket name"),
            ),
            TextField(
              controller: priceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Price"),
            ),
            TextField(
              controller: qtyCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Quantity"),
            ),

            const SizedBox(height: 16),

            TicketVisibilitySelector(
              isPublic: isPublic,
              selectedInstitutions: selectedInstitutions.toList(),
              onVisibilityChanged: (v) {
                setState(() {
                  isPublic = v ?? true;
                  if (isPublic) selectedInstitutions.clear();
                });
              },
              onInstitutionSelected: (inst, selected) {
                setState(() {
                  if (selected) {
                    selectedInstitutions.add(inst);
                  } else {
                    selectedInstitutions.removeWhere(
                      (e) => e.institutionId == inst.institutionId,
                    );
                  }
                });
              },
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 12),
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
    );
  }
}

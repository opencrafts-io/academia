import 'package:academia/config/config.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TicketVisibilitySelector extends StatefulWidget {
  final bool isPublic;
  final List<Institution> selectedInstitutions;
  final bool? isEditingTicket;
  final Function(List<Institution>?)? onInstitutionsChanged;
  final ValueChanged<bool?> onVisibilityChanged;

  const TicketVisibilitySelector({
    super.key,
    required this.isPublic,
    required this.selectedInstitutions,
    required this.onInstitutionsChanged,
    required this.onVisibilityChanged,
    this.isEditingTicket = false,
  });

  @override
  State<TicketVisibilitySelector> createState() =>
      _TicketVisibilitySelectorState();
}

class _TicketVisibilitySelectorState extends State<TicketVisibilitySelector> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<bool>(
          initialValue: widget.isPublic,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
            labelText: "Ticket Visibility",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          items: const [
            DropdownMenuItem(value: true, child: Text("Everyone")),
            DropdownMenuItem(
              value: false,
              child: Text("Specific Institutions"),
            ),
          ],
          onChanged: (val) {
            widget.onVisibilityChanged(val);
          },
        ),

        if (!widget.isPublic) ...[
          const SizedBox(height: 12),

          InkWell(
            onTap: () async {
              final result = await context.push(
                ShereheSelectInstitutionsRoute().location,
                extra: widget.selectedInstitutions,
              );

              if (result != null && result is List<Institution>) {
                widget.onInstitutionsChanged?.call(result);
              } else {
                widget.onInstitutionsChanged?.call([]);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: widget.selectedInstitutions.isNotEmpty
                        ? Text(
                            "${widget.selectedInstitutions.length} selected: "
                            "${widget.selectedInstitutions.take(2).map((i) => i.name).join(", ")}"
                            "${widget.selectedInstitutions.length > 2 ? "..." : ""}",
                          )
                        : Text(
                            "Select institutions",
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                  ),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

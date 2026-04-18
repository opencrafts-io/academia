import 'package:academia/config/config.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/constants/sherehe_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TicketVisibilitySelector extends StatefulWidget {
  final ScopeTypes? selectedScopeType;
  final List<Institution> selectedInstitutions;
  final bool? isEditingTicket;
  final Function(List<Institution>?)? onInstitutionsChanged;
  final ValueChanged<ScopeTypes?> onScopeChanged;

  const TicketVisibilitySelector({
    super.key,
    required this.selectedScopeType,
    required this.selectedInstitutions,
    required this.onInstitutionsChanged,
    required this.onScopeChanged,
    this.isEditingTicket = false,
  });

  @override
  State<TicketVisibilitySelector> createState() =>
      _TicketVisibilitySelectorState();
}

class _TicketVisibilitySelectorState extends State<TicketVisibilitySelector> {
  String _getScopeDescription(ScopeTypes? scope) {
    switch (scope) {
      case ScopeTypes.public:
        return "Anyone can view and purchase this ticket.";

      case ScopeTypes.institution:
        return "Only users from selected institutions can view and purchase.";

      case ScopeTypes.private:
        return "Only invited users can access this ticket via a shared link.";

      default:
        return "Choose who can view and purchase this ticket.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField(
          initialValue: widget.selectedScopeType,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
            labelText: "Ticket Scope",
            hintText: "Select Ticket scope",
            helperText: _getScopeDescription(widget.selectedScopeType),
            helperStyle: Theme.of(context).textTheme.labelSmall,
            helperMaxLines: 2,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          items: ScopeTypes.values.map((scopeType) {
            return DropdownMenuItem(
              value: scopeType,
              child: Text(scopeType.label),
            );
          }).toList(),
          onChanged: (val) {
            widget.onScopeChanged(val);
          },
        ),

        if (widget.selectedScopeType == ScopeTypes.institution) ...[
          const SizedBox(height: 12),
          InkWell(
            onTap: () async {
              final result = await context.push(
                ShereheSelectInstitutionsRoute(
                  title: "Choose who can access this ticket",
                  subtitle:
                      "Search and select one or more institutions. Only users from selected institutions will be able to view and purchase this ticket.",
                ).location,
                extra: widget.selectedInstitutions,
              );

              if (result != null && result is List<Institution>) {
                widget.onInstitutionsChanged?.call(result);
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

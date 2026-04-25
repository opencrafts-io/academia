import 'package:academia/config/config.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:academia/features/sherehe/presentation/constants/sherehe_constants.dart';
import 'package:academia/features/sherehe/presentation/widgets/modern_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventVisibilitySelector extends StatefulWidget {
  final ScopeTypes? selectedEventScopeType;
  final Set<Institution> selectedEventInstitutions;
  final Function(Set<Institution>?)? onInstitutionsChanged;
  final ValueChanged<ScopeTypes?> onScopeChanged;

  const EventVisibilitySelector({
    super.key,
    required this.selectedEventScopeType,
    required this.selectedEventInstitutions,
    required this.onInstitutionsChanged,
    required this.onScopeChanged,
  });

  @override
  State<EventVisibilitySelector> createState() =>
      _EventVisibilitySelectorState();
}

class _EventVisibilitySelectorState extends State<EventVisibilitySelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField(
          initialValue: widget.selectedEventScopeType,
          decoration: buildModernInputDecoration(
            labelText: 'Event Scope',
            hintText: 'Select Event Scope',
          ),
          // hide private option for now
          items: ScopeTypes.values
              .where((scopeType) => scopeType != ScopeTypes.private)
              .map((scopeType) {
                return DropdownMenuItem<ScopeTypes>(
                  value: scopeType,
                  child: Text(scopeType.label),
                );
              })
              .toList(),
          onChanged: (val) {
            if (val != null) {
              widget.onScopeChanged(val);
            }
          },
        ),

        if (widget.selectedEventScopeType == ScopeTypes.institution) ...[
          const SizedBox(height: 20),

          InkWell(
            onTap: () async {
              final result = await context.push(
                ShereheSelectInstitutionsRoute(
                  title: "Choose who can access this event",
                  subtitle:
                      "Search and select one or more institutions. Only users from selected institutions will be able to view this event and purchase tickets for it.",
                ).location,
                extra: widget.selectedEventInstitutions.toList(),
              );

              if (result != null && result is List<Institution>) {
                widget.onInstitutionsChanged?.call(result.toSet());
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: widget.selectedEventInstitutions.isNotEmpty
                        ? Text(
                            "${widget.selectedEventInstitutions.length} selected: "
                            "${widget.selectedEventInstitutions.take(2).map((i) => i.name).join(", ")}"
                            "${widget.selectedEventInstitutions.length > 2 ? "..." : ""}",
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

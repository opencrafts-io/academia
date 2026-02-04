import 'package:academia/features/sherehe/presentation/constants/sherehe_constants.dart';
import 'package:flutter/material.dart';

// padding: const EdgeInsets.symmetric(vertical: 12),

class TicketVisibilitySelector extends StatefulWidget {
  final bool isPublic;
  final List<String> selectedInstitutions;

  final ValueChanged<bool?> onVisibilityChanged;
  final void Function(String institution, bool selected) onInstitutionSelected;

  const TicketVisibilitySelector({
    super.key,
    required this.isPublic,
    required this.selectedInstitutions,
    required this.onVisibilityChanged,
    required this.onInstitutionSelected,
  });

  @override
  State<TicketVisibilitySelector> createState() =>
      _TicketVisibilitySelectorState();
}

class _TicketVisibilitySelectorState extends State<TicketVisibilitySelector> {
  bool _isExpanded = false;
  String _search = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filtered list based on search
    final filteredInstitutions = mockUniversityData
        .where(
          (inst) => inst.toLowerCase().contains(_search.toLowerCase().trim()),
        )
        .toList();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Ticket Visibility"),
            const SizedBox(height: 8),

            DropdownButtonFormField<bool>(
              initialValue: widget.isPublic,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
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
                setState(() => _isExpanded = false);
              },
            ),

            if (!widget.isPublic) ...[
              const SizedBox(height: 12),

              // The expandable area with selected institutions summary
              InkWell(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
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
                                "${widget.selectedInstitutions.take(2).join(", ")}"
                                "${widget.selectedInstitutions.length > 2 ? "..." : ""}",
                                style: Theme.of(context).textTheme.bodyMedium,
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
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      ),
                    ],
                  ),
                ),
              ),

              if (_isExpanded) ...[
                const SizedBox(height: 8),

                // Search field with controller and clear button
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search institution...",
                    prefixIcon: const Icon(Icons.search),
                    isDense: true,
                    border: const OutlineInputBorder(),
                    suffixIcon: _search.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _search = "");
                            },
                          )
                        : null,
                  ),
                  onChanged: (val) {
                    setState(() => _search = val);
                  },
                ),

                const SizedBox(height: 8),

                // List of institutions filtered by search
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 220),
                  child: filteredInstitutions.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredInstitutions.length,
                          itemBuilder: (context, index) {
                            final inst = filteredInstitutions[index];
                            final selected = widget.selectedInstitutions
                                .contains(inst);

                            return CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(inst),
                              value: selected,
                              onChanged: (val) => widget.onInstitutionSelected(
                                inst,
                                val ?? false,
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.search_off, size: 48),
                              SizedBox(height: 8),
                              Text("No results found"),
                            ],
                          ),
                        ),
                ),

                const SizedBox(height: 8),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () => setState(() => _isExpanded = false),
                    icon: const Icon(Icons.check),
                    label: const Text("Done selecting"),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

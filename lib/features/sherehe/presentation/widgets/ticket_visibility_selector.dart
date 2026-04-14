import 'dart:async';

import 'package:academia/core/core.dart';
import 'package:academia/features/institution/domain/domain.dart';
import 'package:academia/features/institution/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketVisibilitySelector extends StatefulWidget {
  final bool isPublic;
  final List<Institution> selectedInstitutions;
  final bool? isEditingTicket;

  final ValueChanged<bool?> onVisibilityChanged;
  final void Function(Institution institution, bool selected)
  onInstitutionSelected;

  const TicketVisibilitySelector({
    super.key,
    required this.isPublic,
    required this.selectedInstitutions,
    required this.onVisibilityChanged,
    required this.onInstitutionSelected,
    this.isEditingTicket = false,
  });

  @override
  State<TicketVisibilitySelector> createState() =>
      _TicketVisibilitySelectorState();
}

class _TicketVisibilitySelectorState extends State<TicketVisibilitySelector> {
  bool _isExpanded = false;
  String _search = "";
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _search = value;

    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (_search.trim().isNotEmpty) {
        context.read<InstitutionBloc>().add(
          SearchInstitutionByNameEvent(_search.trim()),
        );
      }
    });

    setState(() {});
  }

  void _clearSearch() {
    _searchController.clear();
    _search = "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: widget.isEditingTicket == true
            ? const EdgeInsets.symmetric(vertical: 12)
            : const EdgeInsets.all(12),
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

                /// SEARCH FIELD
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
                            onPressed: _clearSearch,
                          )
                        : null,
                  ),
                  onChanged: _onSearchChanged,
                ),

                const SizedBox(height: 8),

                /// RESULTS FROM API
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 220),
                  child: BlocBuilder<InstitutionBloc, InstitutionState>(
                    builder: (context, state) {
                      if (state is InstitutionLoadingState) {
                        return const Center(child: SpinningScallopIndicator());
                      }

                      if (state is InstitutionErrorState) {
                        return Center(
                          child: Text(
                            state.error,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        );
                      }

                      if (state is InstitutionLoadedState) {
                        if (state.institutions.isEmpty) {
                          return const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.search_off, size: 48),
                                SizedBox(height: 8),
                                Text("No results found"),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: state.institutions.length,
                          itemBuilder: (context, index) {
                            final inst = state.institutions[index];
                            final selected = widget.selectedInstitutions.any(
                              (e) => e.institutionId == inst.institutionId,
                            );

                            return CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(inst.name),
                              value: selected,
                              onChanged: (val) => widget.onInstitutionSelected(
                                inst,
                                val ?? false,
                              ),
                            );
                          },
                        );
                      }

                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.school_outlined, size: 70),
                            SizedBox(height: 10),
                            Text(
                              "Start by searching for an institution",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      );
                    },
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

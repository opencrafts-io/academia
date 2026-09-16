import 'package:academia/features/institution/domain/entities/institution.dart';
import 'package:flutter/material.dart';

class ShereheInstitutionChipSelector extends StatefulWidget {
  final List<Institution> selectedInstitutions;
  final Function(Institution) onDeleted;

  const ShereheInstitutionChipSelector({
    super.key,
    required this.selectedInstitutions,
    required this.onDeleted,
  });

  @override
  State<ShereheInstitutionChipSelector> createState() =>
      _ShereheInstitutionChipSelectorState();
}

class _ShereheInstitutionChipSelectorState
    extends State<ShereheInstitutionChipSelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        children: widget.selectedInstitutions.map((inst) {
          return Chip(
            label: Text(inst.name),
            onDeleted: () => widget.onDeleted(inst),
          );
        }).toList(),
      ),
    );
  }
}

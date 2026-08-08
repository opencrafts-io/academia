import 'package:flutter/material.dart';

class ShereheInstitutionCheckboxList extends StatefulWidget {
  final String institutionName;
  final bool selected;
  final ValueChanged<bool?> onChanged;

  const ShereheInstitutionCheckboxList({
    super.key,
    required this.institutionName,
    required this.selected,
    required this.onChanged,
  });

  @override
  State<ShereheInstitutionCheckboxList> createState() =>
      _ShereheInstitutionCheckboxListState();
}

class _ShereheInstitutionCheckboxListState
    extends State<ShereheInstitutionCheckboxList> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      title: Text(widget.institutionName),
      value: widget.selected,
      onChanged: widget.onChanged,
    );
  }
}

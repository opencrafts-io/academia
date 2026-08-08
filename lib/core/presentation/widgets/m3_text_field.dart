import 'package:flutter/material.dart';

/// A filled, rounded M3-styled text field: `surfaceContainerHighest` fill,
/// borderless `circular(20)` shape with a 2px primary focus border, and a
/// bold-primary floating label. Required by default (validator can be
/// overridden for optional fields).
class M3TextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final String? hint;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

  const M3TextField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.hint,
    this.textInputAction,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const radius = BorderRadius.all(Radius.circular(20));

    return TextFormField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyLarge,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withAlpha(128),
        border: const OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: colorScheme.primary,
        ),
      ),
      validator:
          validator ??
          (val) => (val == null || val.isEmpty) ? 'Required field' : null,
    );
  }
}

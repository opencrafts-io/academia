import 'package:flutter/material.dart';

InputDecoration buildModernInputDecoration({
  required BuildContext context,
  required String labelText,
  String? hintText,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    labelText: labelText,
    hintText: hintText,
    suffixIcon: suffixIcon,
    // filled: true,
    // fillColor: Theme.of(context).colorScheme.primaryContainer,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(width: 2),
    ),
  );
}

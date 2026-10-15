import 'package:flutter/material.dart';

const courseColors = <String>[
  '#4F46E5',
  '#0284C7',
  '#059669',
  '#D97706',
  '#DC2626',
  '#DB2777',
  '#7C3AED',
  '#475569',
];

Color colorFromHex(String? value, Color fallback) {
  if (value == null ||
      !RegExp(r'^#[0-9A-Fa-f]{6}([0-9A-Fa-f]{2})?$').hasMatch(value)) {
    return fallback;
  }
  final hex = value.substring(1);
  final parsed = int.parse(hex, radix: 16);
  return Color(
    hex.length == 8
        ? ((parsed & 0xFF) << 24) | (parsed >> 8)
        : 0xFF000000 | parsed,
  );
}

class CourseColorPicker extends StatelessWidget {
  const CourseColorPicker({
    super.key,
    required this.value,
    required this.onChanged,
    required this.defaultLabel,
  });

  final String? value;
  final ValueChanged<String?> onChanged;
  final String defaultLabel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ChoiceChip(
          label: Text(defaultLabel),
          selected: value == null,
          onSelected: (_) => onChanged(null),
          visualDensity: VisualDensity.compact,
        ),
        for (final hex in courseColors)
          Semantics(
            label: 'Color $hex',
            child: ChoiceChip(
              label: SizedBox.square(
                dimension: 18,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorFromHex(hex, colors.primary),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              selected: value == hex,
              onSelected: (_) => onChanged(hex),
              visualDensity: VisualDensity.compact,
            ),
          ),
      ],
    );
  }
}

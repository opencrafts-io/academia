import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

/// A Material 3 expressive color picker card.
///
/// Displays a curated palette of swatches. Tapping "More colors" opens
/// the full [FlexColorPicker] bottom sheet for free-form selection.
///
/// Usage:
/// ```dart
/// ColorSeedCard(
///   currentColor: selectedColor,
///   onColorChanged: (color) => setState(() => selectedColor = color),
/// )
///
/// // Custom palette + no "more colors" button:
/// ColorSeedCard(
///   currentColor: selectedColor,
///   onColorChanged: (color) => setState(() => selectedColor = color),
///   colors: myBrandColors,
///   allowCustomColor: false,
/// )
/// ```
class ColorSeedCard extends StatelessWidget {
  final Color currentColor;
  final ValueChanged<Color> onColorChanged;

  /// Override the default curated palette.
  final List<Color>? colors;

  /// Whether to show the "More colors" button that opens [FlexColorPicker].
  /// Defaults to true.
  final bool allowCustomColor;

  /// Card title. Defaults to "Pick an accent color".
  final String? label;

  static const _defaultColors = [
    Color(0xFF0061A4),
    Color(0xFF9C4DFF),
    Color(0xFF00B37E),
    Color(0xFFFF5A5F),
    Color(0xFFFF9A00),
    Color(0xFF00A3FF),
    Color(0xFF7C4DFF),
    Color(0xFF00C2A8),
    Color(0xFFFF3D00),
    Color(0xFFB00020),
    Color(0xFF006B54),
    Color(0xFF8B4513),
    Color(0xFF4A148C),
    Color(0xFF1B5E20),
    Color(0xFF880E4F),
    Color(0xFF37474F),
  ];

  const ColorSeedCard({
    super.key,
    required this.currentColor,
    required this.onColorChanged,
    this.colors,
    this.allowCustomColor = true,
    this.label,
  });

  bool _isSwatchSelected(Color swatch) =>
      currentColor.toARGB32() == swatch.toARGB32();

  Future<void> _openFullPicker(BuildContext context) async {
    Color picked = currentColor;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Custom color"),
        content: SizedBox(
          width: 360,
          child: ColorPicker(
            color: picked,
            onColorChanged: (c) => picked = c,
            pickersEnabled: const {
              ColorPickerType.wheel: true,
              ColorPickerType.primary: true,
              ColorPickerType.accent: false,
              ColorPickerType.custom: false,
            },
            enableShadesSelection: true,
            showColorCode: true,
            colorCodeHasColor: true,
            copyPasteBehavior: const ColorPickerCopyPasteBehavior(
              copyButton: true,
              pasteButton: true,
            ),
            spacing: 8,
            runSpacing: 8,
            wheelDiameter: 220,
            borderRadius: 22,
            hasBorder: false,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Apply"),
          ),
        ],
      ),
    );

    if (confirmed == true) onColorChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = colors ?? _defaultColors;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    label ?? "Pick an accent color",
                    style: theme.textTheme.labelLarge,
                  ),
                ),
                // Live preview chip
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: currentColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.outline,
                      width: 2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ...palette.map(
                  (color) => _Swatch(
                    color: color,
                    isSelected: _isSwatchSelected(color),
                    onTap: () => onColorChanged(color),
                  ),
                ),
                if (allowCustomColor)
                  _MoreColorsSwatch(onTap: () => _openFullPicker(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _Swatch({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 3,
                )
              : Border.all(color: Colors.transparent, width: 3),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withAlpha(120),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: isSelected
            ? Center(
                child: Icon(
                  Icons.check_rounded,
                  size: 20,
                  color: color.computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}

class _MoreColorsSwatch extends StatelessWidget {
  final VoidCallback onTap;
  const _MoreColorsSwatch({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: theme.colorScheme.outlineVariant,
            width: 1.5,
          ),
        ),
        child: Icon(
          Icons.palette_outlined,
          size: 20,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

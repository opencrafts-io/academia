import 'package:flutter/material.dart';

class TodoItemMetaChip extends StatelessWidget {
  const TodoItemMetaChip({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onDeleted,
  });
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onDeleted;
  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 14, color: color),
      label: Text(label, style: TextStyle(fontSize: 12, color: color)),
      deleteIcon: Icon(Icons.close, size: 14, color: color.withAlpha(180)),
      onDeleted: onDeleted,
      backgroundColor: color.withAlpha(20),
      side: BorderSide(color: color.withAlpha(80)),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      visualDensity: VisualDensity.compact,
    );
  }
}

import 'package:flutter/material.dart';

/// A rounded surface container grouping a tasklist's active items, mirroring
/// Material 3 Expressive's boxed list-group treatment.
class TodoSectionCard extends StatelessWidget {
  final List<Widget> children;
  const TodoSectionCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(children: children),
    );
  }
}

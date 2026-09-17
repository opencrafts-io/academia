import 'package:flutter/material.dart';

/// Lays out a tasklist's active items. Each [TodoCard] carries its own
/// elevated surface, so this just stacks them without an enclosing box.
class TodoSectionCard extends StatelessWidget {
  final List<Widget> children;
  const TodoSectionCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(children: children);
  }
}

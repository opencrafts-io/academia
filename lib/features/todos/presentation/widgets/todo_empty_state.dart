import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class TodoEmptyState extends StatelessWidget {
  const TodoEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.icons.computer.image(height: 180, width: 180),
            const SizedBox(height: 16),
            Text("No tasks yet", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            const Text(
              "Add your to-dos and keep track of them across Academia "
              "and Google Workspace",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {

  const EmptyState({ super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/illustrations/exam_timetable.png',
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),
            ),
            // const SizedBox(height: 24),
            Text(
              'Your timetable is empty. Please search for your courses',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

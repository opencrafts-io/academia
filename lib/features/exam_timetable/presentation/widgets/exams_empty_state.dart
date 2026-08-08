import 'package:flutter/material.dart';
import 'package:academia/gen/assets.gen.dart';

class EmptyState extends StatelessWidget {
  final VoidCallback? onSearchTap;

  const EmptyState({super.key, this.onSearchTap});

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
            GestureDetector(
              onTap: onSearchTap,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: Assets.icons.animalsIconPenguin.image(
                  height: 200,
                  width: 200,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Your timetable is empty. Please search for your courses',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface,
              ),
            ),
            if (onSearchTap != null) ...[
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: onSearchTap,
                icon: const Icon(Icons.search_rounded),
                label: const Text('Search Courses'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

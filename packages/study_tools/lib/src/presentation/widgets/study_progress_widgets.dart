import 'package:flutter/material.dart';
import 'package:material3_indicators/material3_indicators.dart';

class StudyToolsLoadingView extends StatelessWidget {
  const StudyToolsLoadingView({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const WavyCircularProgressIndicator(
          size: 52,
          amplitude: 2.2,
          frequency: 8,
          semanticsLabel: 'Loading study materials',
        ),
        const SizedBox(height: 20),
        Text(message, style: Theme.of(context).textTheme.titleMedium),
      ],
    ),
  );
}

class StudyGenerationProgressCard extends StatelessWidget {
  const StudyGenerationProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card.filled(
      color: colors.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            WavyCircularProgressIndicator(
              size: 38,
              amplitude: 1.5,
              frequency: 8,
              color: colors.onSecondaryContainer,
              backgroundColor: colors.onSecondaryContainer.withValues(
                alpha: 0.16,
              ),
              semanticsLabel: 'Generating questions',
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preparing your questions',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(color: colors.onSecondaryContainer),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'You can leave this screen. We’ll check again when you return.',
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: colors.onSecondaryContainer),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

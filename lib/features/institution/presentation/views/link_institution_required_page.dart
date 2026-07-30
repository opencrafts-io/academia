import 'package:academia/config/config.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class LinkInstitutionRequiredPage extends StatelessWidget {
  const LinkInstitutionRequiredPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Institution Required'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Assets.icons.motarboard.image(
                  height: 80,
                  width: 80,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Link Your Institution',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'To access the exam timetable feature and view your upcoming exams, you need to link your school or institution to your profile first.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              Card.filled(
                color: colorScheme.surfaceContainerHigh,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Linking your institution unlocks exam schedules, course materials, and custom tools tailored to your school.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 2),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    LinkInstitutionProfileRoute().push(context);
                  },
                  icon: const Icon(Icons.add_link_rounded),
                  label: const Text(
                    'Link Institution',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Go back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

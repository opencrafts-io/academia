import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:academia/gen/assets.gen.dart';

class AppUpdatePage extends StatelessWidget {
  final String message;
  final bool isMandatory;
  final VoidCallback onUpdate;

  const AppUpdatePage({
    super.key,
    required this.message,
    required this.isMandatory,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Assets.icons.academia.image(height: 64, width: 64),
              ),
              const SizedBox(height: 40),
              Text(
                "Time for an upgrade",
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: onUpdate,
                  icon: const Icon(Icons.download_rounded),
                  label: const Text("Get the new version"),
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ),
              ),
              if (!isMandatory) ...[
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text("Maybe later"),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

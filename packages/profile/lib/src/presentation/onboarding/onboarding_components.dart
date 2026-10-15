import 'package:flutter/material.dart';

class ProfileStepHeading extends StatelessWidget {
  const ProfileStepHeading({
    required this.icon,
    required this.title,
    this.subtitle,
    super.key,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.circular(14),
          ),
          child: SizedBox.square(
            dimension: 42,
            child: Icon(icon, size: 22, color: colors.onPrimaryContainer),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.08,
            letterSpacing: -0.5,
          ),
        ),
        if (subtitle case final subtitle?) ...[
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(color: colors.onSurfaceVariant, height: 1.35),
          ),
        ],
      ],
    );
  }
}

InputDecoration profileInputDecoration({
  required BuildContext context,
  required String label,
  String? hint,
  String? helperText,
  IconData? icon,
  String? prefixText,
}) {
  final colors = Theme.of(context).colorScheme;
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(18),
    borderSide: BorderSide.none,
  );
  return InputDecoration(
    labelText: label,
    hintText: hint,
    helperText: helperText,
    prefixIcon: icon == null ? null : Icon(icon),
    prefixText: prefixText,
    counterText: '',
    filled: true,
    fillColor: colors.surfaceContainerLow,
    border: border,
    enabledBorder: border,
    focusedBorder: border,
    errorBorder: border.copyWith(
      borderSide: BorderSide(color: colors.error, width: 1.5),
    ),
    focusedErrorBorder: border.copyWith(
      borderSide: BorderSide(color: colors.error, width: 1.5),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
  );
}

class ProfileStepActions extends StatelessWidget {
  const ProfileStepActions({
    required this.onPrevious,
    required this.onNext,
    required this.isLoading,
    required this.canContinue,
    this.nextLabel = 'Continue',
    super.key,
  });

  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool isLoading;
  final bool canContinue;
  final String nextLabel;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      TextButton.icon(
        onPressed: isLoading ? null : onPrevious,
        style: TextButton.styleFrom(
          minimumSize: const Size(72, 52),
          foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        icon: const Icon(Icons.arrow_back_rounded, size: 18),
        label: const Text('Back'),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: FilledButton.icon(
          onPressed: isLoading || !canContinue ? null : onNext,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            shape: const StadiumBorder(),
          ),
          iconAlignment: IconAlignment.end,
          icon: isLoading
              ? const SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                )
              : const Icon(Icons.arrow_forward_rounded, size: 18),
          label: Text(isLoading ? 'Saving' : nextLabel),
        ),
      ),
    ],
  );
}

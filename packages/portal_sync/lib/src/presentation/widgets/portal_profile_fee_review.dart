import 'package:flutter/material.dart';

import '../../domain/entities/portal_profile_fee_draft.dart';

/// Human readable preview of detected profile fields and fee statement
/// lines, shown before anything is saved. Follows the same shape as
/// `PortalImportReview` (courses/timetable).
class PortalProfileFeeReview extends StatelessWidget {
  const PortalProfileFeeReview({
    required this.draft,
    required this.onSave,
    required this.onDiscard,
    this.isBusy = false,
    super.key,
  });

  final PortalProfileFeeDraft draft;
  final VoidCallback onSave;
  final VoidCallback onDiscard;
  final bool isBusy;

  static const Map<String, String> _fieldLabels = {
    'fullName': 'Full name',
    'registrationNumber': 'Registration number',
    'programme': 'Programme',
    'faculty': 'Faculty',
    'yearOfStudy': 'Year of study',
    'enrollmentStatus': 'Enrollment status',
    'institutionEmail': 'Institution email',
    'phoneNumber': 'Phone number',
  };

  static const Map<String, String> _kindLabels = {
    'debit': 'Debit',
    'credit': 'Credit',
    'runningBalance': 'Running balance',
    'balanceDue': 'Balance due',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Card(
      color: colors.surfaceContainerLow,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Review before saving',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Check your profile details and fee statement. Amounts keep the currency and format your school used; unconfirmed amounts are held for review.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            if (draft.profileFields.isNotEmpty) ...[
              _SectionHeading(
                icon: Icons.badge_outlined,
                title: 'Profile',
                count: draft.profileFields.length,
              ),
              const SizedBox(height: 8),
              for (final field in draft.profileFields)
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  leading: CircleAvatar(
                    backgroundColor: colors.primaryContainer,
                    foregroundColor: colors.onPrimaryContainer,
                    child: const Icon(Icons.person_outline_rounded),
                  ),
                  title: Text(_fieldLabels[field.fieldKey] ?? field.fieldKey),
                  subtitle: Text(field.rawValue),
                ),
            ],
            if (draft.feeLineItems.isNotEmpty) ...[
              const SizedBox(height: 12),
              _SectionHeading(
                icon: Icons.receipt_long_outlined,
                title: 'Fee statement',
                count: draft.feeLineItems.length,
              ),
              const SizedBox(height: 8),
              for (final line in draft.feeLineItems)
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  leading: CircleAvatar(
                    backgroundColor: colors.tertiaryContainer,
                    foregroundColor: colors.onTertiaryContainer,
                    child: const Icon(Icons.payments_outlined),
                  ),
                  title: Text(line.description),
                  subtitle: Text(
                    [
                      _kindLabels[line.kind] ?? line.kind,
                      if (line.rawDate?.trim().isNotEmpty ?? false)
                        line.rawDate!,
                    ].join(' · '),
                  ),
                  trailing: Text(
                    line.currencyText?.trim().isNotEmpty ?? false
                        ? '${line.currencyText} ${line.rawAmount}'
                        : line.rawAmount,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
            ],
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final buttons = [
                  OutlinedButton.icon(
                    onPressed: isBusy ? null : onDiscard,
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: const Text('Discard'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 52),
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: isBusy ? null : onSave,
                    icon: isBusy
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.check_rounded),
                    label: Text(
                      isBusy ? 'Saving…' : 'Save reviewed information',
                    ),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 52),
                    ),
                  ),
                ];
                if (constraints.maxWidth < 440) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buttons[1],
                      const SizedBox(height: 8),
                      buttons[0],
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: buttons[0]),
                    const SizedBox(width: 12),
                    Expanded(flex: 2, child: buttons[1]),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.icon,
    required this.title,
    required this.count,
  });
  final IconData icon;
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(child: Text(title, style: theme.textTheme.titleMedium)),
        Text(
          '$count',
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

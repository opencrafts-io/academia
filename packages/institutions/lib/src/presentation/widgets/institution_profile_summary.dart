import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';

/// Read-only summary of a saved [AcademicProfileEntity]. Shows only fields
/// that passed validation; unvalidated/rejected fields are omitted rather
/// than shown as if confirmed.
class InstitutionProfileSummary extends StatelessWidget {
  const InstitutionProfileSummary({required this.profile, super.key});

  final AcademicProfileEntity? profile;

  static const Map<AcademicProfileFieldKey, String> _labels = {
    AcademicProfileFieldKey.fullName: 'Full name',
    AcademicProfileFieldKey.registrationNumber: 'Registration number',
    AcademicProfileFieldKey.programme: 'Programme',
    AcademicProfileFieldKey.faculty: 'Faculty',
    AcademicProfileFieldKey.yearOfStudy: 'Year of study',
    AcademicProfileFieldKey.enrollmentStatus: 'Enrollment status',
    AcademicProfileFieldKey.institutionEmail: 'Institution email',
    AcademicProfileFieldKey.phoneNumber: 'Phone number',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = this.profile;
    final entries = profile == null
        ? const <MapEntry<AcademicProfileFieldKey, AcademicProfileFieldValue>>[]
        : profile.fields.entries
              .where((entry) => entry.value.displayValue != null)
              .toList();
    if (entries.isEmpty) {
      return Text(
        'No profile fields saved yet.',
        style: theme.textTheme.bodyMedium,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final entry in entries)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 160,
                  child: Text(
                    _labels[entry.key] ?? entry.key.name,
                    style: theme.textTheme.labelLarge,
                  ),
                ),
                Expanded(
                  child: Text(
                    entry.value.displayValue ?? '',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

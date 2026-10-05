import 'package:academia/features/institution/domain/entities/institution.dart';
import 'package:flutter/material.dart';

class SchoolPortalEntryCard extends StatelessWidget {
  const SchoolPortalEntryCard({
    required this.schools,
    required this.onSelectSchool,
    required this.onLinkSchool,
    this.isLoading = false,
    super.key,
  });

  final List<Institution> schools;
  final ValueChanged<int> onSelectSchool;
  final VoidCallback onLinkSchool;
  final bool isLoading;

  Future<void> _open(BuildContext context) async {
    if (isLoading) {
      return;
    }
    if (schools.isEmpty) {
      onLinkSchool();
      return;
    }
    if (schools.length == 1) {
      onSelectSchool(schools.single.institutionId);
      return;
    }
    final selected = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (sheetContext) => FractionallySizedBox(
        heightFactor: .6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Text(
                'Choose your school',
                style: Theme.of(sheetContext).textTheme.headlineSmall,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
                itemCount: schools.length,
                itemBuilder: (_, index) => ListTile(
                  leading: const Icon(Icons.school_rounded),
                  title: Text(schools[index].name),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () =>
                      Navigator.of(sheetContext)
                          .pop(schools[index].institutionId),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    if (context.mounted && selected != null) {
      onSelectSchool(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Card.filled(
      margin: EdgeInsets.zero,
      color: colors.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        leading: Icon(
          Icons.auto_awesome_rounded,
          color: colors.onPrimaryContainer,
          size: 32,
        ),
        title: Text(
          'School portal sync',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colors.onPrimaryContainer,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          isLoading
              ? 'Loading your schools…'
              : schools.isEmpty
              ? 'Link your school to bring your courses and class times together.'
              : 'Sign in to your portal, then review courses and class times before saving.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onPrimaryContainer,
          ),
        ),
        trailing: isLoading
            ? const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(
                Icons.arrow_forward_rounded,
                color: colors.onPrimaryContainer,
              ),
        onTap: isLoading ? null : () => _open(context),
      ),
    );
  }
}

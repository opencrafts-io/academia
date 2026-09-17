import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Shown beneath the exam timetable app bar when the user is linked to more
/// than one institution, so they can switch which institution's timetable
/// they're viewing without leaving the feature. Renders nothing otherwise.
class InstitutionSwitcherChip extends StatelessWidget {
  final int currentInstitutionId;
  final ValueChanged<int> onSwitch;

  const InstitutionSwitcherChip({
    super.key,
    required this.currentInstitutionId,
    required this.onSwitch,
  });

  void _showSwitcher(BuildContext context, List<Institution> institutions) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Switch institution',
                    style: Theme.of(sheetContext).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: institutions.length,
                    itemBuilder: (context, index) {
                      final institution = institutions[index];
                      final isSelected =
                          institution.institutionId == currentInstitutionId;
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        leading: Icon(
                          Icons.school_rounded,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        title: Text(institution.name),
                        trailing: isSelected
                            ? Icon(
                                Icons.check_circle_rounded,
                                color: colorScheme.primary,
                              )
                            : null,
                        onTap: () {
                          Navigator.of(sheetContext).pop();
                          if (!isSelected) {
                            onSwitch(institution.institutionId);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<InstitutionBloc, InstitutionState>(
      builder: (context, institutionState) {
        final institutions = institutionState.whenOrNull(
          loaded: (institutions) => institutions,
        );
        if (institutions == null || institutions.length < 2) {
          return const SizedBox.shrink();
        }

        Institution? current;
        for (final institution in institutions) {
          if (institution.institutionId == currentInstitutionId) {
            current = institution;
            break;
          }
        }
        if (current == null) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Material(
            color: colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => _showSwitcher(context, institutions),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: colorScheme.onSecondaryContainer
                          .withValues(alpha: 0.12),
                      child: Icon(
                        Icons.school_rounded,
                        size: 20,
                        color: colorScheme.onSecondaryContainer,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Institution',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSecondaryContainer
                                  .withValues(alpha: 0.7),
                            ),
                          ),
                          Text(
                            current.name,
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.unfold_more_rounded,
                      color: colorScheme.onSecondaryContainer,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

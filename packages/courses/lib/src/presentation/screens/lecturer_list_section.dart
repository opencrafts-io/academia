import 'package:courses/src/domain/entities/lecturer_entity.dart';
import 'package:courses/src/presentation/bloc/course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LecturerListSection extends StatelessWidget {
  const LecturerListSection({
    super.key,
    required this.courseId,
    required this.lecturers,
  });

  final String courseId;
  final List<LecturerEntity> lecturers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Lecturers',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: () => _openEditor(context),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Add'),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                lecturers.isEmpty
                    ? 'Add the people who teach this course.'
                    : '${lecturers.length} ${lecturers.length == 1 ? 'lecturer' : 'lecturers'}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              if (lecturers.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'No lecturers have been added yet.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                )
              else
                Column(
                  children: [
                    for (var index = 0; index < lecturers.length; index++) ...[
                      _LecturerTile(
                        lecturer: lecturers[index],
                        onTap: () => _openEditor(context, lecturers[index]),
                        onDelete: () =>
                            _deleteLecturer(context, lecturers[index]),
                      ),
                      if (index < lecturers.length - 1)
                        const Divider(height: 1, indent: 64),
                    ],
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openEditor(
    BuildContext context, [
    LecturerEntity? lecturer,
  ]) async {
    final path = lecturer == null
        ? '/courses/$courseId/lecturers/create'
        : '/courses/$courseId/lecturers/${lecturer.id}/edit';
    final saved = await context.push<bool>(path);
    if (saved == true && context.mounted) {
      await context.read<CourseCubit>().loadCourse(courseId);
    }
  }

  Future<void> _deleteLecturer(
    BuildContext context,
    LecturerEntity lecturer,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.person_remove_outlined),
        title: const Text('Remove lecturer?'),
        content: Text('Remove ${lecturer.name} from this course?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await context.read<CourseCubit>().deleteLecturer(lecturer);
    }
  }
}

class _LecturerTile extends StatelessWidget {
  const _LecturerTile({
    required this.lecturer,
    required this.onTap,
    required this.onDelete,
  });

  final LecturerEntity lecturer;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final details = [
      lecturer.email,
      lecturer.phone,
      lecturer.office,
    ].whereType<String>().join(' · ');
    final initial = lecturer.name.isEmpty ? '?' : lecturer.name.substring(0, 1);

    return Semantics(
      button: true,
      label: 'Edit ${lecturer.name}',
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          leading: CircleAvatar(
            backgroundColor: colors.secondaryContainer,
            foregroundColor: colors.onSecondaryContainer,
            child: Text(
              initial,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          title: Text(
            lecturer.name,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: details.isEmpty
              ? null
              : Text(
                  details,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.chevron_right_rounded, color: colors.onSurfaceVariant),
              IconButton(
                tooltip: 'Remove ${lecturer.name}',
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

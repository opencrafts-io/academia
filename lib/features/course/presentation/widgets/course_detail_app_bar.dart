import 'package:academia/features/course/course.dart';
import 'package:flutter/material.dart';

class CourseDetailAppBar extends StatelessWidget {
  final CourseEntity course;
  final bool isEditing;
  final VoidCallback onEditToggle;
  final VoidCallback onDeletePressed;

  const CourseDetailAppBar({
    super.key,
    required this.course,
    required this.isEditing,
    required this.onEditToggle,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliverAppBar.large(
      expandedHeight: 200,
      pinned: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            course.courseCode,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            course.courseName,
            style: theme.textTheme.displaySmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(isEditing ? Icons.done_rounded : Icons.edit_rounded),
          onPressed: onEditToggle,
          tooltip: isEditing ? 'Done' : 'Edit',
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline_rounded),
          onPressed: onDeletePressed,
          tooltip: 'Delete',
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class StudyLibraryHeading extends StatelessWidget {
  const StudyLibraryHeading({required this.count, this.courseLabel, super.key});

  final int count;
  final String? courseLabel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AnimatedSize(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courseLabel ?? 'Your library',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Keep your course documents and practice in one place.',
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: colors.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Chip(
            avatar: const Icon(Icons.folder_copy_outlined, size: 17),
            label: Text('$count'),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

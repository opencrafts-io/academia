import 'package:flutter/material.dart';

import '../../domain/entities/study_entities.dart';

class StudyCourseFilterChips extends StatelessWidget {
  const StudyCourseFilterChips({
    required this.courses,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  static const unassignedFilter = 'unassigned';

  final List<StudyCourseOption> courses;
  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 48,
    child: ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsetsDirectional.only(end: 16),
      children: [
        _filterChip(
          context,
          label: 'All materials',
          icon: Icons.auto_awesome_mosaic_outlined,
          value: null,
        ),
        const SizedBox(width: 8),
        _filterChip(
          context,
          label: 'Unassigned',
          icon: Icons.folder_open_outlined,
          value: unassignedFilter,
        ),
        for (final course in courses) ...[
          const SizedBox(width: 8),
          _filterChip(
            context,
            label: course.title,
            icon: Icons.school_outlined,
            value: course.id,
          ),
        ],
      ],
    ),
  );

  Widget _filterChip(
    BuildContext context, {
    required String label,
    required IconData icon,
    required String? value,
  }) => ChoiceChip(
    label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
    avatar: Icon(icon, size: 18),
    selected: selected == value,
    onSelected: (isSelected) {
      if (isSelected) onSelected(value);
    },
    tooltip: label,
    showCheckmark: true,
  );
}

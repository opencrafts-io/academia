import 'package:academia/core/core.dart';
import 'package:academia/features/course/course.dart';
import 'package:flutter/material.dart';

class CourseInfoSection extends StatefulWidget {
  final CourseEntity course;
  final bool isEditing;
  final ValueChanged<CourseEntity> onCourseUpdated;

  const CourseInfoSection({
    super.key,
    required this.course,
    required this.isEditing,
    required this.onCourseUpdated,
  });

  @override
  State<CourseInfoSection> createState() => _CourseInfoSectionState();
}

class _CourseInfoSectionState extends State<CourseInfoSection> {
  late TextEditingController _codeController;
  late TextEditingController _nameController;
  late TextEditingController _instructorController;
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.course.courseCode);
    _nameController = TextEditingController(text: widget.course.courseName);
    _instructorController = TextEditingController(
      text: widget.course.instructor,
    );
    _selectedColor = widget.course.color ?? const Color(0xFF1E1E2E);
  }

  @override
  void didUpdateWidget(CourseInfoSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isEditing && oldWidget.isEditing) {
      // Save changes when exiting edit mode
      _saveChanges();
    }

    // Update if course changed
    if (widget.course != oldWidget.course) {
      _codeController.text = widget.course.courseCode;
      _nameController.text = widget.course.courseName;
      _instructorController.text = widget.course.instructor;
      _selectedColor = widget.course.color ?? const Color(0xFF1E1E2E);
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _instructorController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final updatedCourse = widget.course.copyWith(
      courseCode: _codeController.text,
      courseName: _nameController.text,
      instructor: _instructorController.text,
      color: _selectedColor,
    );
    widget.onCourseUpdated(updatedCourse);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isEditing) ...[
            TextField(
              controller: _nameController,
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: -1.0,
                color: _selectedColor,
              ),
              cursorHeight: 32,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: "Course Title",
                hintStyle: theme.textTheme.displaySmall?.copyWith(
                  color: _selectedColor.withAlpha(128),
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const SizedBox(height: 20),
            M3TextField(
              label: 'Course Code',
              controller: _codeController,
              icon: Icons.fingerprint_rounded,
              hint: 'e.g. MATH402',
            ),
            const SizedBox(height: 16),
            M3TextField(
              label: 'Instructor',
              controller: _instructorController,
              icon: Icons.badge_rounded,
              hint: 'e.g. Dr. Aris Thorne',
            ),
            const SizedBox(height: 20),
            Text(
              'Course Color',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            ColorSeedCard(
              currentColor: _selectedColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
            ),
          ] else ...[
            _buildInfoRow(
              context,
              Icons.person_outline_rounded,
              'Instructor',
              widget.course.instructor,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              value,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

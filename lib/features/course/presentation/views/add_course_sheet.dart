import 'package:academia/features/course/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class AddCourseSheet extends StatefulWidget {
  const AddCourseSheet({super.key});

  @override
  State<AddCourseSheet> createState() => _AddCourseSheetState();
}

class _AddCourseSheetState extends State<AddCourseSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _instructorController = TextEditingController();

  Color _selectedColor = const Color(0xFF6750A4);

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _instructorController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newCourse = CourseEntity(
        courseName: _nameController.text.trim(),
        courseCode: _codeController.text.trim().toUpperCase(),
        instructor: _instructorController.text.trim(),
        color: _selectedColor,
        isSynced: false,
        isDeleted: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      context.read<CourseCubit>().addOrUpdateCourse(newCourse);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SheetContentScaffold(
      topBar: AppBar(
        title: Text('Create Course', style: theme.textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CloseButton(onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        // Padding logic: 120px bottom to clear the sticky FAB/Button
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildM3TextField(
                label: 'Course Title',
                controller: _nameController,
                icon: Icons.auto_stories_rounded,
                hint: 'e.g. Advanced Calculus',
              ),
              const SizedBox(height: 20),
              _buildM3TextField(
                label: 'Course Code',
                controller: _codeController,
                icon: Icons.fingerprint_rounded,
                hint: 'e.g. MATH402',
              ),
              const SizedBox(height: 20),
              _buildM3TextField(
                label: 'Instructor',
                controller: _instructorController,
                icon: Icons.badge_rounded,
                hint: 'e.g. Dr. Aris Thorne',
              ),
              const SizedBox(height: 32),
              Text(
                'Course Color',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              _buildColorPicker(),
            ],
          ),
        ),
      ),
      bottomBar: _buildBottomAction(colorScheme),
    );
  }

  Widget _buildM3TextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? hint,
  }) {
    return TextFormField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withAlpha(128),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      validator: (val) =>
          (val == null || val.isEmpty) ? 'Required field' : null,
    );
  }

  Widget _buildColorPicker() {
    final colors = [
      const Color(0xFF6750A4),
      const Color(0xFFB3261E),
      const Color(0xFF21005D),
      const Color(0xFF386A20),
      const Color(0xFF7D5260),
      const Color(0xFF006A6A),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: colors.map((color) {
        final isSelected = _selectedColor == color;
        return GestureDetector(
          onTap: () => setState(() => _selectedColor = color),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: Colors.white, width: 3)
                  : Border.all(color: Colors.transparent, width: 0),
              boxShadow: [
                BoxShadow(
                  color: isSelected ? color.withAlpha(120) : Colors.transparent,
                  blurRadius: isSelected ? 12 : 0,
                  offset: isSelected ? const Offset(0, 4) : Offset.zero,
                ),
              ],
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 20)
                : null,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomAction(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outlineVariant, width: 0.5),
        ),
      ),
      child: FilledButton.icon(
        onPressed: _submit,
        icon: const Icon(Icons.add_task_rounded),
        label: const Text('Create Course'),
      ),
    );
  }
}

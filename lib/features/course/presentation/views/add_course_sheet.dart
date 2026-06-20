import 'package:academia/core/core.dart';
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
              TextFormField(
                controller: _nameController,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.0,
                  color: _selectedColor,
                ),
                cursorHeight: 32,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                autovalidateMode: AutovalidateMode.onUserInteractionIfError,
                maxLength: 30,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Course Title",
                  hintStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: _selectedColor.withAlpha(128),
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
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
              ColorSeedCard(
                currentColor: _selectedColor,
                onColorChanged: (color) => setState(() {
                  _selectedColor = color;
                }),
              ),
              // _buildColorPicker(),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:academia/features/course/course.dart';
import 'package:academia/features/timetable/timetable.dart';

/// Course detail page with Material 3 design
/// Displays course information and associated timetable entries
class CourseDetailPage extends StatefulWidget {
  final String courseId;

  const CourseDetailPage({super.key, required this.courseId});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Fetch the specific course
    context.read<CourseCubit>().fetchCourse(widget.courseId);
    // Watch timetable entries for this course
    context.read<TimetableEntryBloc>().add(
      WatchTimetableEntriesByCourseIdEvent(courseId: widget.courseId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: BlocBuilder<CourseCubit, CourseState>(
        builder: (context, courseState) {
          return courseState.when(
            initial: () => _buildLoadingView(colorScheme),
            loading: () => _buildLoadingView(colorScheme),
            success: (courses) {
              if (courses.isEmpty) {
                return _buildErrorView('Course not found', colorScheme);
              }
              final course = courses.first;

              // Wrap the content in a Theme widget that uses the course color as the seed
              return Theme(
                data: theme.copyWith(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: course.color ?? const Color(0xFF1E1E2E),
                    brightness: theme.brightness,
                  ),
                ),
                child: Builder(
                  builder: (context) {
                    final localTheme = Theme.of(context);
                    return _buildCourseContent(
                      course,
                      localTheme.colorScheme,
                      localTheme,
                    );
                  },
                ),
              );
            },
            error: (message) => _buildErrorView(message, colorScheme),
          );
        },
      ),
    );
  }

  Widget _buildLoadingView(ColorScheme colorScheme) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: const Text('Loading...'),
        ),
        SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(color: colorScheme.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorView(String message, ColorScheme colorScheme) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: const Text('Error'),
        ),
        SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: colorScheme.error),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(color: colorScheme.onSurface, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCourseContent(
    CourseEntity course,
    ColorScheme colorScheme,
    ThemeData theme,
  ) {
    return CustomScrollView(
      slivers: [
        // App Bar following M3 guidelines (no background color, surface based)
        SliverAppBar.large(
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
              icon: Icon(_isEditing ? Icons.done : Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              tooltip: _isEditing ? 'Done' : 'Edit',
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _confirmDelete(context, course),
              tooltip: 'Delete',
            ),
          ],
        ),

        // Course Information Section
        SliverToBoxAdapter(
          child: _CourseInfoSection(
            course: course,
            isEditing: _isEditing,
            onCourseUpdated: (updatedCourse) {
              context.read<CourseCubit>().addOrUpdateCourse(updatedCourse);
            },
          ),
        ),

        // Timetable Entries Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Class Schedule',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FilledButton.tonalIcon(
                  onPressed: () => _addNewTimetableEntry(context, course),
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ],
            ),
          ),
        ),

        // Timetable Entries List
        BlocBuilder<TimetableEntryBloc, TimetableEntryState>(
          builder: (context, state) {
            if (state is TimetableEntryLoading) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }

            if (state is TimetableEntriesLoaded) {
              if (state.entries.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 64,
                          color: colorScheme.outline,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No schedule entries yet',
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () =>
                              _addNewTimetableEntry(context, course),
                          icon: const Icon(Icons.add),
                          label: const Text('Add First Entry'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final entry = state.entries[index];
                    return TimetableEntryCard(
                      entry: entry,
                      course: course,
                      onTap: () => _editTimetableEntry(context, entry, course),
                      onDelete: () => _deleteTimetableEntry(context, entry),
                    );
                  }, childCount: state.entries.length),
                ),
              );
            }

            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),

        // Bottom spacing
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  void _confirmDelete(BuildContext context, CourseEntity course) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded),
        title: const Text('Delete Course?'),
        content: Text(
          'This will delete "${course.courseName}" and all associated schedule entries. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<CourseCubit>().removeCourse(course.id!);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close page
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _addNewTimetableEntry(BuildContext context, CourseEntity course) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TimetableEntryEditorPage(
          courseId: course.id!,
          courseName: course.courseName,
          courseColor: course.color!,
        ),
      ),
    );
  }

  void _editTimetableEntry(
    BuildContext context,
    TimetableEntryEntity entry,
    CourseEntity course,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TimetableEntryEditorPage(
          courseId: course.id!,
          courseName: course.courseName,
          courseColor: course.color!,
          entry: entry,
        ),
      ),
    );
  }

  void _deleteTimetableEntry(BuildContext context, TimetableEntryEntity entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.delete_outline),
        title: const Text('Delete Entry?'),
        content: const Text('This schedule entry will be permanently deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<TimetableEntryBloc>().add(
                DeleteTimetableEntryEvent(id: entry.id!),
              );
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _CourseInfoSection extends StatefulWidget {
  final CourseEntity course;
  final bool isEditing;
  final Function(CourseEntity) onCourseUpdated;

  const _CourseInfoSection({
    required this.course,
    required this.isEditing,
    required this.onCourseUpdated,
  });

  @override
  State<_CourseInfoSection> createState() => _CourseInfoSectionState();
}

class _CourseInfoSectionState extends State<_CourseInfoSection> {
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
  void didUpdateWidget(_CourseInfoSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isEditing && oldWidget.isEditing) {
      // Save changes when exiting edit mode
      _saveChanges();
    }

    // Update if course changed
    if (widget.course != oldWidget.course) {
      _codeController.text = widget.course.courseCode;
      _nameController.text = widget.course.courseName;
      _instructorController.text = widget.course.instructor ?? '';
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
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'Course Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Course Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _instructorController,
              decoration: const InputDecoration(
                labelText: 'Instructor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Course Color'),
            const SizedBox(height: 8),
            ColorPicker(
              color: _selectedColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
              width: 44,
              height: 44,
              borderRadius: 22,
              spacing: 10,
              runSpacing: 10,
              wheelDiameter: 165,
              heading: Text(
                'Select color',
                style: theme.textTheme.titleSmall,
              ),
              subheading: Text(
                'Select color shade',
                style: theme.textTheme.titleSmall,
              ),
            ),
          ] else ...[
            _buildInfoRow(
              context,
              Icons.person_outline,
              'Instructor',
              widget.course.instructor ?? 'Not assigned',
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
            color: theme.colorScheme.primaryContainer.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: theme.colorScheme.primary,
          ),
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

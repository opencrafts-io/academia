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
              return _buildCourseContent(course, colorScheme, theme);
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
          backgroundColor: colorScheme.surface,
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
          backgroundColor: colorScheme.errorContainer,
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
    final courseColor = course.color ?? const Color(0xFF1E1E2E);

    return CustomScrollView(
      slivers: [
        // App Bar with course color
        SliverAppBar.large(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: courseColor,
          foregroundColor: _getContrastColor(courseColor),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              course.courseCode,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            background: Container(
              decoration: BoxDecoration(color: courseColor),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 48),
                      Text(
                        course.courseName,
                        style: TextStyle(
                          fontSize: 16,
                          color: _getContrastColor(
                            courseColor,
                          ).withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
              icon: const Icon(Icons.more_vert),
              onPressed: () => _showOptionsMenu(context, course),
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

  Color _getContrastColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  void _showOptionsMenu(BuildContext context, CourseEntity course) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('Delete Course'),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(context, course);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement share
              },
            ),
          ],
        ),
      ),
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
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course Code Field
          _buildInfoCard(
            context,
            icon: Icons.tag,
            label: 'Course Code',
            child: widget.isEditing
                ? TextField(
                    controller: _codeController,
                    decoration: const InputDecoration(
                      hintText: 'e.g., CS101',
                      border: OutlineInputBorder(),
                    ),
                    style: theme.textTheme.titleMedium,
                  )
                : Text(
                    widget.course.courseCode,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),

          const SizedBox(height: 12),

          // Course Name Field
          _buildInfoCard(
            context,
            icon: Icons.school,
            label: 'Course Name',
            child: widget.isEditing
                ? TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'e.g., Introduction to Computer Science',
                      border: OutlineInputBorder(),
                    ),
                    style: theme.textTheme.bodyLarge,
                    maxLines: 2,
                  )
                : Text(
                    widget.course.courseName,
                    style: theme.textTheme.bodyLarge,
                  ),
          ),

          const SizedBox(height: 12),

          // Instructor Field
          _buildInfoCard(
            context,
            icon: Icons.person_outline,
            label: 'Instructor',
            child: widget.isEditing
                ? TextField(
                    controller: _instructorController,
                    decoration: const InputDecoration(
                      hintText: 'e.g., Dr. Jane Smith',
                      border: OutlineInputBorder(),
                    ),
                    style: theme.textTheme.bodyLarge,
                  )
                : Text(
                    widget.course.instructor,
                    style: theme.textTheme.bodyLarge,
                  ),
          ),

          const SizedBox(height: 12),

          // Color Picker
          if (widget.isEditing)
            _buildInfoCard(
              context,
              icon: Icons.palette_outlined,
              label: 'Course Color',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => _showColorPicker(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: _selectedColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: colorScheme.outline.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Tap to change color',
                          style: TextStyle(
                            color: _getContrastColor(_selectedColor),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Sync Status
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(
                widget.course.isSynced
                    ? Icons.cloud_done_outlined
                    : Icons.cloud_off_outlined,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                widget.course.isSynced ? 'Synced' : 'Not synced',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              if (widget.course.createdAt != null) ...[
                const SizedBox(width: 16),
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  'Created ${_formatDate(widget.course.createdAt!)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceVariant.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a Color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            color: _selectedColor,
            onColorChanged: (color) {
              setState(() {
                _selectedColor = color;
              });
            },
            width: 44,
            height: 44,
            borderRadius: 8,
            spacing: 8,
            runSpacing: 8,
            wheelDiameter: 200,
            heading: Text(
              'Select color',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            subheading: Text(
              'Select color shade',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            wheelSubheading: Text(
              'Selected color and its shades',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            showMaterialName: true,
            showColorName: true,
            showColorCode: true,
            copyPasteBehavior: const ColorPickerCopyPasteBehavior(
              longPressMenu: true,
            ),
            materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
            colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
            colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.both: false,
              ColorPickerType.primary: true,
              ColorPickerType.accent: false,
              ColorPickerType.bw: false,
              ColorPickerType.custom: false,
              ColorPickerType.wheel: true,
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Color _getContrastColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'today';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    }
  }
}

import 'package:academia/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/course/course.dart';
import 'package:academia/features/timetable/timetable.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

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
        const SliverAppBar.large(title: Text('Loading...')),
        const SliverFillRemaining(child: Center(child: LoadingIndicatorM3E())),
      ],
    );
  }

  Widget _buildErrorView(String message, ColorScheme colorScheme) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(title: Text('Error')),
        SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 64,
                  color: colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(color: colorScheme.onSurface, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_rounded),
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
        CourseDetailAppBar(
          course: course,
          isEditing: _isEditing,
          onEditToggle: () {
            setState(() {
              _isEditing = !_isEditing;
            });
          },
          onDeletePressed: () => _confirmDelete(context, course),
        ),
        SliverToBoxAdapter(
          child: CourseInfoSection(
            course: course,
            isEditing: _isEditing,
            onCourseUpdated: (updatedCourse) {
              context.read<CourseCubit>().addOrUpdateCourse(updatedCourse);
            },
          ),
        ),
        CourseScheduleSection(
          course: course,
          onAddEntry: () => _addNewTimetableEntry(context, course),
          onEditEntry: (entry) => _editTimetableEntry(context, entry, course),
          onDeleteEntry: (entry) => _deleteTimetableEntry(context, entry),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  void _confirmDelete(BuildContext context, CourseEntity course) {
    showDialog(
      context: context,
      builder: (_) => ConfirmDeleteDialog(
        title: 'Delete Course?',
        message:
            'This will delete "${course.courseName}" and all associated '
            'schedule entries. This action cannot be undone.',
        onConfirm: () {
          context.read<CourseCubit>().removeCourse(course.id!);
          Navigator.pop(context); // Close page
        },
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
      builder: (_) => ConfirmDeleteDialog(
        icon: Icons.delete_outline_rounded,
        title: 'Delete Entry?',
        message: 'This schedule entry will be permanently deleted.',
        onConfirm: () {
          context.read<TimetableEntryBloc>().add(
            DeleteTimetableEntryEvent(id: entry.id!),
          );
        },
      ),
    );
  }
}

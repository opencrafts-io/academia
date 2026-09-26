import 'package:courses/src/domain/entities/course_entity.dart';
import 'package:courses/src/presentation/bloc/course_cubit.dart';
import 'package:courses/src/presentation/routes/course_routes.dart';
import 'package:courses/src/presentation/screens/lecturer_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material3_indicators/material3_indicators.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({super.key, required this.courseId});

  final String courseId;

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().loadCourse(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CourseCubit>().state;
    final course = state.selectedCourse;
    if (state.isLoading && course == null) {
      return const Scaffold(body: _DetailLoadingState());
    }
    if (course == null) {
      return Scaffold(
        appBar: AppBar(),
        body: _DetailFailureState(
          message: state.error ?? 'This course is unavailable.',
          onRetry: () =>
              context.read<CourseCubit>().loadCourse(widget.courseId),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            pinned: true,
            title: Text(course.title),
            actions: [
              IconButton(
                tooltip: 'Edit course',
                onPressed: () => _edit(course),
                icon: const Icon(Icons.edit_outlined),
              ),
              PopupMenuButton<_CourseAction>(
                tooltip: 'Course actions',
                onSelected: (action) => _handleAction(action, course),
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: _CourseAction.archive,
                    child: ListTile(
                      leading: Icon(Icons.archive_outlined),
                      title: Text('Archive course'),
                    ),
                  ),
                  PopupMenuItem(
                    value: _CourseAction.delete,
                    child: ListTile(
                      leading: Icon(Icons.delete_forever_outlined),
                      title: Text('Delete permanently'),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverToBoxAdapter(child: _CourseDetailsSection(course: course)),
          if (state.error != null)
            SliverToBoxAdapter(child: _DetailError(message: state.error!)),
          SliverToBoxAdapter(
            child: LecturerListSection(
              courseId: course.id,
              lecturers: course.lecturers,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _edit(CourseEntity course) async {
    final saved = await EditCourseRoute(courseId: course.id)
        .push<bool>(context);
    if (saved == true && mounted) {
      await context.read<CourseCubit>().loadCourse(course.id);
    }
  }

  Future<void> _handleAction(_CourseAction action, CourseEntity course) async {
    final archive = action == .archive;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: Icon(
          archive ? Icons.archive_rounded : Icons.delete_forever_rounded,
        ),
        title: Text(archive ? 'Archive course?' : 'Delete course permanently?'),
        content: Text(
          archive
              ? 'This course will leave your active courses and appear in course history.'
              : 'This permanently deletes the course. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(archive ? 'Archive' : 'Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final cubit = context.read<CourseCubit>();
    if (archive) {
      await cubit.archive(course.id);
    } else {
      await cubit.delete(course.id);
    }
    if (mounted && cubit.state.error == null) Navigator.pop(context);
  }
}

enum _CourseAction { archive, delete }

class _CourseDetailsSection extends StatelessWidget {
  const _CourseDetailsSection({required this.course});

  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final details = <_CourseDetail>[
      if (course.termStartDate != null)
        _CourseDetail(
          Icons.event_available_outlined,
          'Starts',
          _date(context, course.termStartDate!),
        ),
      if (course.termEndDate != null)
        _CourseDetail(
          Icons.event_outlined,
          'Ends',
          _date(context, course.termEndDate!),
        ),
    ];
    final studyPeriod = [
      course.termLabel,
      course.academicYear,
    ].whereType<String>().join(' · ');

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (course.code != null)
                Text(
                  course.code!,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              if (studyPeriod.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  studyPeriod,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              if (course.code != null || studyPeriod.isNotEmpty)
                const SizedBox(height: 28),
              Text(
                'Course details',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.1,
                ),
              ),
              const SizedBox(height: 4),
              if (details.isEmpty)
                const _NoCourseDetails()
              else
                Column(
                  children: [
                    for (var index = 0; index < details.length; index++) ...[
                      _CourseDetailTile(detail: details[index]),
                      if (index < details.length - 1)
                        const Divider(height: 1, indent: 56),
                    ],
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  static String _date(BuildContext context, DateTime value) =>
      DateFormat.yMMMd(Localizations.localeOf(context).toLanguageTag())
          .format(value);
}

class _CourseDetail {
  const _CourseDetail(this.icon, this.label, this.value);

  final IconData icon;
  final String label;
  final String value;
}

class _CourseDetailTile extends StatelessWidget {
  const _CourseDetailTile({required this.detail});

  final _CourseDetail detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Semantics(
      label: '${detail.label}: ${detail.value}',
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        leading: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(detail.icon, color: colors.onSecondaryContainer),
        ),
        title: Text(
          detail.label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        subtitle: Text(
          detail.value,
          style: theme.textTheme.titleMedium?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _NoCourseDetails extends StatelessWidget {
  const _NoCourseDetails();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        'Add term dates to make this course easier to plan around.',
        style: Theme.of(context).textTheme.bodyMedium
            ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
    );
  }
}

class _DetailLoadingState extends StatelessWidget {
  const _DetailLoadingState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        label: 'Loading course',
        child: WavyCircularProgressIndicator(
          size: 40,
          amplitude: 2,
          frequency: 8,
        ),
      ),
    );
  }
}

class _DetailFailureState extends StatelessWidget {
  const _DetailFailureState({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card.outlined(
            color: colors.errorContainer,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    color: colors.onErrorContainer,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colors.onErrorContainer),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.tonalIcon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Try again'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailError extends StatelessWidget {
  const _DetailError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Container(
            decoration: BoxDecoration(
              color: colors.errorContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(
                Icons.error_outline_rounded,
                color: colors.onErrorContainer,
              ),
              title: Text(
                message,
                style: TextStyle(color: colors.onErrorContainer),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

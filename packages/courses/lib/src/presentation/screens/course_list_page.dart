import 'dart:math' as math;

import 'package:courses/src/domain/entities/course_entity.dart';
import 'package:courses/src/presentation/bloc/course_cubit.dart';
import 'package:courses/src/presentation/routes/course_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().loadActive();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CourseCubit>().state;
    return CourseListBody(
      courses: state.courses,
      loading: state.isLoading,
      error: state.error,
      onRefresh: () => context.read<CourseCubit>().loadActive(),
      onCreate: _openCreateCourse,
      onShowHistory: () => const CourseHistoryRoute().push(context),
    );
  }

  Future<void> _openCreateCourse() async {
    final saved = await const CreateCourseRoute().push<bool>(context);
    if (saved == true && mounted) context.read<CourseCubit>().loadActive();
  }
}

class CourseListBody extends StatelessWidget {
  const CourseListBody({
    super.key,
    required this.courses,
    required this.loading,
    required this.onRefresh,
    this.error,
    this.onCreate,
    this.onShowHistory,
    this.archived = false,
  });

  final List<CourseEntity> courses;
  final bool loading;
  final Future<void> Function() onRefresh;
  final String? error;
  final Future<void> Function()? onCreate;
  final VoidCallback? onShowHistory;
  final bool archived;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: onCreate == null || courses.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: onCreate,
              icon: const Icon(Icons.add_rounded),
              label: const Text('New course'),
            ),
      body: RefreshIndicator.adaptive(
        onRefresh: onRefresh,
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              pinned: true,
              title: Text(archived ? 'Course history' : 'Courses'),
              actions: [
                IconButton(
                  tooltip: 'Refresh courses',
                  onPressed: onRefresh,
                  icon: const Icon(Icons.refresh_rounded),
                ),
                if (onShowHistory != null)
                  IconButton(
                    tooltip: 'Course history',
                    onPressed: onShowHistory,
                    icon: const Icon(Icons.history_rounded),
                  ),
                const SizedBox(width: 8),
              ],
            ),
            if (loading && courses.isEmpty)
              const SliverToBoxAdapter(child: _CourseLoadingState())
            else if (error != null && courses.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _CourseEmptyState(
                  icon: Icons.cloud_off_rounded,
                  title: 'Courses are unavailable right now.',
                  message: error!,
                  actionLabel: 'Try again',
                  onAction: onRefresh,
                  error: true,
                ),
              )
            else if (courses.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _CourseEmptyState(
                  icon: archived
                      ? Icons.history_rounded
                      : Icons.auto_stories_outlined,
                  title: archived
                      ? 'No archived courses yet.'
                      : 'No courses yet.',
                  message: archived
                      ? 'Courses you archive will appear here.'
                      : 'Add a course to keep your studies organized.',
                  actionLabel: archived ? null : 'Add course',
                  onAction: archived ? null : onCreate,
                ),
              )
            else ...[
              if (error != null)
                SliverToBoxAdapter(
                  child: _CourseListMessage(
                    icon: Icons.cloud_off_rounded,
                    title: 'Showing saved courses',
                    message: error!,
                    compact: true,
                    error: true,
                  ),
                ),
              SliverLayoutBuilder(
                builder: (context, constraints) {
                  final sidePadding = math.max(
                    16.0,
                    (constraints.crossAxisExtent - 760) / 2,
                  );
                  return SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      sidePadding,
                      8,
                      sidePadding,
                      112,
                    ),
                    sliver: SliverList.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                          bottom: index == courses.length - 1 ? 0 : 8,
                        ),
                        child: _CourseCard(course: courses[index]),
                      ),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.course});

  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final metadata = [
      course.termLabel,
      course.academicYear,
    ].whereType<String>().join(' · ');

    return Semantics(
      button: true,
      label: _semanticsLabel(metadata),
      child: Card.outlined(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.push('/courses/${course.id}'),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.menu_book_outlined,
                    color: colors.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (course.code != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          course.code!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colors.primary,
                          ),
                        ),
                      ],
                      if (metadata.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          metadata,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _semanticsLabel(String metadata) {
    final details = [course.code, metadata].whereType<String>().join('. ');
    return details.isEmpty
        ? 'Open ${course.title}'
        : 'Open ${course.title}. $details.';
  }
}

class _CourseLoadingState extends StatelessWidget {
  const _CourseLoadingState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 56),
      child: Center(
        child: Semantics(
          label: 'Loading courses',
          child: const SizedBox.square(
            dimension: 32,
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
    );
  }
}

class _CourseListMessage extends StatelessWidget {
  const _CourseListMessage({
    required this.icon,
    required this.title,
    required this.message,
    this.error = false,
    this.compact = false,
  });

  final IconData icon;
  final String title;
  final String message;
  final bool error;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, compact ? 8 : 16, 16, 0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Card.outlined(
            color: error ? colors.errorContainer : colors.surfaceContainerLow,
            margin: EdgeInsets.zero,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: compact ? 4 : 8,
              ),
              leading: Icon(
                icon,
                color: error ? colors.onErrorContainer : colors.primary,
              ),
              title: Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: error ? colors.onErrorContainer : colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: error
                      ? colors.onErrorContainer
                      : colors.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CourseEmptyState extends StatelessWidget {
  const _CourseEmptyState({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.error = false,
  });

  final IconData icon;
  final String title;
  final String message;
  final Future<void> Function()? onAction;
  final String? actionLabel;
  final bool error;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final color = error ? colors.error : colors.primary;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 24, 32, 56),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Semantics(
                label: title,
                child: Icon(icon, size: 40, color: color),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 24),
              if (onAction != null)
                FilledButton.icon(
                  onPressed: onAction,
                  icon: Icon(error ? Icons.refresh_rounded : Icons.add_rounded),
                  label: Text(actionLabel!),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import 'package:academia/features/course/course.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  @override
  void initState() {
    super.initState();
    // Start watching the database stream immediately
    context.read<CourseCubit>().watchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'add-course-fab',
        onPressed: () => AddCoursesRoute().push(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Course'),
      ),
      body: BlocBuilder<CourseCubit, CourseState>(
        builder: (context, state) {
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              const SliverAppBar.large(title: Text('Courses')),

              state.when(
                initial: () =>
                    const SliverToBoxAdapter(child: SizedBox.shrink()),
                loading: () => const SliverFillRemaining(
                  child: Center(child: LoadingIndicatorM3E()),
                ),
                error: (message) =>
                    SliverFillRemaining(child: _ErrorState(message: message)),
                success: (courses) {
                  if (courses.isEmpty) {
                    return const SliverFillRemaining(child: _EmptyState());
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final course = courses[index];
                        return CourseCard(
                          course: course,
                          onTap: () async {
                            await ViewCourseRoute(
                              courseId: course.id!,
                            ).push(context);
                            if (context.mounted) {
                              context.read<CourseCubit>().watchCourses();
                              context.read<TimetableEntryBloc>().add(
                                WatchAllTimetableEntriesEvent(),
                              );
                            }
                          },
                        );
                      }, childCount: courses.length),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Card.filled(
          margin: EdgeInsets.zero,
          color: colorScheme.surfaceContainerHigh,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Assets.icons.notificationIconAlert.image(width: 140),
                const SizedBox(height: 12),
                Text(
                  'No courses yet',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tap the + button to add your first course.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  const _ErrorState({required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 40,
                color: colorScheme.onErrorContainer,
              ),
              const SizedBox(height: 12),
              Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.onErrorContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onErrorContainer,
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.tonal(
                onPressed: () => context.read<CourseCubit>().watchCourses(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

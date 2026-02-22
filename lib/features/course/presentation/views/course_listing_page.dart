import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        onPressed: () => AddCoursesRoute().push(context),
        icon: const Icon(Icons.add),
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
                  child: Center(child: CircularProgressIndicator()),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.school_outlined,
          size: 64,
          color: Theme.of(context).colorScheme.secondary,
        ),
        const SizedBox(height: 16),
        Text(
          'No courses yet',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        const Text('Tap the + button to add your first course.'),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  const _ErrorState({required this.message});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          FilledButton.tonal(
            onPressed: () => context.read<CourseCubit>().watchCourses(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

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
      // M3 standard uses a FAB for the primary action
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => /* Navigate to Add Course */ {},
        icon: const Icon(Icons.add),
        label: const Text('Add Course'),
      ),
      body: BlocBuilder<CourseCubit, CourseState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              // 1. Expressive M3 Large App Bar
              const SliverAppBar.large(
                title: Text('My Courses'),
                actions: [
                  IconButton(onPressed: null, icon: Icon(Icons.search)),
                  IconButton(onPressed: null, icon: Icon(Icons.more_vert)),
                ],
              ),

              // 2. Handle States
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
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _CourseCard(course: course),
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

class _CourseCard extends StatelessWidget {
  final CourseEntity course;
  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(
        context,
      ).colorScheme.surfaceContainerHighest.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          course.courseName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          course.courseCode,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: course.color, // Color from our converter
            shape: BoxShape.circle,
          ),
        ),
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

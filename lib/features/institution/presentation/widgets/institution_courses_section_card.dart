import 'package:academia/gen/assets.gen.dart';
import 'package:courses/courses.dart' as courses;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

class InstitutionCoursesSectionCard extends StatefulWidget {
  const InstitutionCoursesSectionCard({super.key, required this.institutionId});

  final int institutionId;

  @override
  State<InstitutionCoursesSectionCard> createState() =>
      _InstitutionCoursesSectionCardState();
}

class _InstitutionCoursesSectionCardState
    extends State<InstitutionCoursesSectionCard> {
  @override
  void initState() {
    super.initState();
    context.read<courses.CourseCubit>().loadActiveForInstitution(
      widget.institutionId,
    );
  }

  @override
  void didUpdateWidget(InstitutionCoursesSectionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.institutionId != widget.institutionId) {
      context.read<courses.CourseCubit>().loadActiveForInstitution(
        widget.institutionId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<courses.CourseCubit, courses.CourseState>(
      builder: (context, state) {
        if (state.isLoading) return Center(child: LoadingIndicatorM3E());
        if (state.error != null) return _Error(message: state.error!);
        if (state.courses.isEmpty) return const _EmptyCourses();
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: state.courses.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final course = state.courses[index];
            return Card(
              child: ListTile(
                title: Text(course.title),
                subtitle: Text(course.code ?? 'No course code'),
                onTap: () => context.push('/courses/${course.id}'),
              ),
            );
          },
        );
      },
    );
  }
}

class _EmptyCourses extends StatelessWidget {
  const _EmptyCourses();

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      margin: EdgeInsets.zero,
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          children: [
            Assets.icons.notificationIconAlert.image(width: 140),
            const SizedBox(height: 12),
            Text(
              'No courses yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            const Text(
              "We couldn't find any courses for this institution yet",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        message,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}

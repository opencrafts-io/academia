import 'package:academia/config/router/router.dart';
import 'package:academia/features/course/course.dart';
import 'package:academia/features/features.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

class InstitutionCoursesSectionCard extends StatelessWidget {
  const InstitutionCoursesSectionCard({super.key, required this.institutionId});

  final int institutionId;

  @override
  Widget build(BuildContext context) {
    context.read<CourseCubit>().watchByInstitution(institutionId);
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        return state.when(
          initial: () => Center(child: LoadingIndicatorM3E()),
          loading: () => Center(child: LoadingIndicatorM3E()),
          success: (courses) {
            if (courses.isEmpty) {
              return Card.filled(
                margin: EdgeInsets.zero,
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 28,
                  ),
                  child: Column(
                    children: [
                      Assets.icons.notificationIconAlert.image(width: 140),
                      const SizedBox(height: 12),
                      Text(
                        "No courses yet",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "We couldn't find any courses for this institution yet",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: courses.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final course = courses[index];
                return CourseCard(
                  course: course,
                  onTap: () async {
                    await ViewCourseRoute(courseId: course.id!).push(context);
                    if (context.mounted) {
                      context.read<CourseCubit>().watchByInstitution(
                        institutionId,
                      );
                      context.read<TimetableEntryBloc>().add(
                        WatchAllTimetableEntriesEvent(),
                      );
                    }
                  },
                );
              },
            );
          },
          error: (message) => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

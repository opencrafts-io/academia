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
        return ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: state.courses.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final course = state.courses[index];
            final details = [
              course.code,
              course.termLabel,
              course.academicYear,
            ].whereType<String>().join(' · ');
            final theme = Theme.of(context);
            final colors = theme.colorScheme;
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),
              minVerticalPadding: 8,
              leading: Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.menu_book_outlined,
                  color: colors.onPrimaryContainer,
                ),
              ),
              title: Text(
                course.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: details.isEmpty
                  ? null
                  : Text(
                      details,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: colors.onSurfaceVariant,
              ),
              onTap: () => context.push('/courses/${course.id}'),
            );
          },
          separatorBuilder: (_, _) => const Padding(
            padding: EdgeInsets.only(left: 64),
            child: Divider(height: 1),
          ),
        );
      },
    );
  }
}

class _EmptyCourses extends StatelessWidget {
  const _EmptyCourses();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(Icons.menu_book_outlined, color: colors.onSurfaceVariant),
        title: Text(
          'No courses yet',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "We couldn't find any courses for this institution yet.",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
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

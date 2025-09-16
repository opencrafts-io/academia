import 'package:academia/features/magnet/magnet.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class MagnetCoursesScreen extends StatefulWidget {
  const MagnetCoursesScreen({super.key, required this.institutionID});
  final int institutionID;

  @override
  State<MagnetCoursesScreen> createState() => _MagnetCoursesScreenState();
}

class _MagnetCoursesScreenState extends State<MagnetCoursesScreen> {
  @override
  void initState() {
    super.initState();
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadedState) {
      context.read<MagnetBloc>().add(
        GetCachedMagnetStudentTimetableEvent(
          institutionID: widget.institutionID,
          userID: profileState.profile.id,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MagnetBloc, MagnetState>(
        builder: (context, state) => RefreshIndicator.adaptive(
          onRefresh: () async {
            final profileState = context.read<ProfileBloc>().state;
            if (profileState is ProfileLoadedState) {
              context.read<MagnetBloc>().add(
                FetchMagnetStudentTimeTableEvent(
                  institutionID: widget.institutionID,
                  userID: profileState.profile.id,
                ),
              );
            }

            await Future.delayed(Duration(seconds: 2));
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar.large(title: Text('Your courses')),

              state is! MagnetTimeTableLoadedState
                  ? SliverPadding(
                      padding: EdgeInsets.all(12),
                      sliver: SliverFillRemaining(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              state is MagnetLoadingState
                                  ? "assets/lotties/thinking-learning.json"
                                  : "assets/lotties/digital-marketing.json",
                              height: 240,
                            ),
                            Text(
                              state is MagnetLoadingState
                                  ? "Fetching your courses. Hang on tight"
                                  : "We couldn't load your courses. Please pull to refresh",
                              style: Theme.of(context).textTheme.headlineSmall,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: EdgeInsetsGeometry.all(12),
                      sliver: state.timetable.isEmpty
                          ? SliverFillRemaining(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    "assets/lotties/thinking-learning.json",
                                    height: 240,
                                  ),
                                  Text(
                                    "No courses found",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Please ensure you're registered for courses on your portal and refresh this page",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : SliverList.builder(
                              itemCount: state.timetable.length,
                              itemBuilder: (context, index) {
                                final course = state.timetable[index];
                                return MagnetCourseCard(course: course);
                              },
                            ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class MagnetCourseCard extends StatelessWidget {
  final MagnetCourseInfo course;

  const MagnetCourseCard({super.key, required this.course});

  String _safeString(String? value, [String fallback = "N/A"]) {
    if (value == null || value.trim().isEmpty) return fallback;
    return value;
  }

  String _safeInt(int? value, [String fallback = "N/A"]) {
    return value?.toString() ?? fallback;
  }

  String _safeList(List<String>? list, [String fallback = "N/A"]) {
    if (list == null || list.isEmpty) return fallback;
    return list.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card.outlined(
      color: colors.surface,
      surfaceTintColor: colors.primary,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Viewing feature coming soon!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Code & Title
              Text(
                "${course.courseCode} — ${course.courseTitle}",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
              ),
              const SizedBox(height: 8),

              // Description
              Text(
                _safeString(
                  course.courseDescription,
                  "No description available.",
                ),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              const Divider(height: 24),

              // Key details grid
              Wrap(
                spacing: 16,
                runSpacing: 12,
                children: [
                  _infoChip("Credits", _safeInt(course.credits), colors),
                  _infoChip(
                    "Instructor",
                    _safeString(course.instructor, "TBA"),
                    colors,
                  ),
                  _infoChip(
                    "Semester",
                    _safeString(course.semester, "Not set"),
                    colors,
                  ),
                  _infoChip(
                    "Every",
                    course.schedule != null
                        ? DateFormat.EEEE().format(course.schedule!)
                        : "Not scheduled",
                    colors,
                  ),
                  _infoChip(
                    "From",
                    course.schedule != null
                        ? DateFormat.Hm().format(course.schedule!)
                        : "Not scheduled",
                    colors,
                  ),
                  _infoChip(
                    "To",
                    course.schedule != null
                        ? DateFormat.Hm().format(
                            course.schedule!.add(
                              course.duration ?? Duration(seconds: 0),
                            ),
                          )
                        : "Not scheduled",
                    colors,
                  ),

                  _infoChip(
                    "Duration",
                    "${course.duration?.inHours.toString() ?? 0} hrs",
                    colors,
                  ),
                  _infoChip(
                    "Type",
                    _safeString(course.courseType, "General"),
                    colors,
                  ),
                  _infoChip(
                    "Level",
                    _safeString(course.courseLevel, "N/A"),
                    colors,
                  ),
                  _infoChip(
                    "Location",
                    _safeString(course.location, "TBA"),
                    colors,
                  ),
                  _infoChip(
                    "Enrollment Limit",
                    _safeInt(course.enrollmentLimit),
                    colors,
                  ),
                  _infoChip(
                    "Current Enrolled",
                    _safeInt(course.currentEnrollment, "0"),
                    colors,
                  ),
                ],
              ),
              const Divider(height: 24),

              // Prerequisites
              Text(
                "Prerequisites: ${_safeList(course.prerequisites)}",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.secondary,
                ),
              ),

              const SizedBox(height: 8),

              // Course materials
              Text(
                "Materials: ${_safeList(course.courseMaterials)}",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.tertiary,
                ),
              ),

              const Divider(height: 24),
              Text(
                "Actions",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.secondary,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.outlined(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog.adaptive(
                          title: Text('Are you sure you want to drop course'),
                          content: Text(
                            'Dropping this course will only remove it from your saved courses. Proceed with caution',
                          ),
                          actions: [
                            FilledButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                final profileState = context
                                    .read<ProfileBloc>()
                                    .state;
                                if (profileState is ProfileLoadedState) {
                                  context.read<MagnetBloc>().add(
                                    DeleteCachedMagnetStudentTimetableEvent(
                                      courseCode: course.courseCode,
                                      institutionID: course.institutionID,
                                      userID: profileState.profile.id,
                                    ),
                                  );
                                }

                                context.pop();
                              },
                              label: Text('Im sure delete it'),
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
                  FilledButton.icon(
                    onPressed: () {},
                    label: Text('Add to Agenda'),
                    icon: Icon(Icons.add_link),
                  ),
                  // IconButton.outlined(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.delete_forever),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(String label, String value, ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: colors.tertiaryContainer.withAlpha(128),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: colors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

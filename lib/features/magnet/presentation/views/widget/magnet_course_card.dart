import 'package:academia/features/agenda/presentation/bloc/agenda_event_bloc.dart';
import 'package:academia/features/magnet/magnet.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';
import './add_course_to_agenda_widget.dart';

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
                  fontFamily: GoogleFonts.rubikDirt().fontFamily,
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
                    onPressed: () async {
                      if (await Vibration.hasVibrator()) {
                        await Vibration.vibrate(duration: 128, amplitude: 128);
                      }
                      if (!context.mounted) return;

                      final agenda = await showModalBottomSheet(
                        showDragHandle: true,
                        clipBehavior: Clip.hardEdge,
                        context: context,
                        builder: (context) =>
                            AddCourseToAgendaWidget(magnetCourseInfo: course),
                      );

                      if (agenda != null && context.mounted) {
                        context.read<AgendaEventBloc>().add(
                          CreateAgendaEventEvent(agendaEvent: agenda),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Your course has been added to agenda events',
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
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

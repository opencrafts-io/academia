import 'package:academia/features/magnet/magnet.dart';
import './widget/magnet_course_card.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<MagnetBloc, MagnetState>(
            listener: (context, state) {
              if (state is MagnetErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
            },
          ),
        ],
        child: BlocBuilder<MagnetBloc, MagnetState>(
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
                                    : "We couldn't load your courses. Please pull to refresh.",
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
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
      ),
    );
  }
}

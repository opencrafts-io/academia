import 'package:academia/config/router/router.dart';
import 'package:academia/features/course/course.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:magnet/magnet.dart';

class InstitutionHomePage extends StatefulWidget {
  const InstitutionHomePage({super.key, required this.institutionID});
  final int institutionID;

  @override
  State<InstitutionHomePage> createState() => _InstitutionHomePageState();
}

class _InstitutionHomePageState extends State<InstitutionHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    context.read<MagnetBloc>().add(
      InitializeMagnet(MagnetConfig.production(schemaServerUrl: "")),
    );

    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadedState) {
      context.read<StudentProfileBloc>().add(FetchCurrentUserProfileEvent());

      context.read<StudentProfileBloc>().add(
        WatchProfileByUserAndInstitutionEvent(
          userID: profileState.profile.id,
          institutionID: widget.institutionID,
        ),
      );
    }
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<ScrappingCommandBloc, ScrappingCommandState>(
            listener: (context, state) {
              if (state is ScrappingCommandLoading) {}
            },
          ),
          BlocListener<InstitutionKeyBloc, InstitutionKeyState>(
            listener: (context, state) {
              if (state is InstitutionKeyError) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("We couldn't retrieve your keys"),
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: "Try again",
                      onPressed: () => context.read<InstitutionKeyBloc>().add(
                        GetInstitutionKeyEvent(
                          institutionID: widget.institutionID,
                        ),
                      ),
                    ),
                  ),
                );
              } else if (state is InstitutionKeyLoaded && state.key == null) {
                showModalBottomSheet(
                  context: context,
                  isDismissible: false,
                  enableDrag: false,
                  isScrollControlled: true,
                  showDragHandle: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28.0),
                    ),
                  ),
                  builder: (context) {
                    return InstitutionSetupSheetContent();
                  },
                );
              }
            },
          ),
          BlocListener<MagnetBloc, MagnetState>(
            listener: (context, state) async {
              if (state is MagnetSuccess) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("All synced — now saving offline…"),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
              // }
            },
          ),
        ],
        child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<ScrappingCommandBloc>(context).add(
              GetScrappingCommandEvent(institutionID: widget.institutionID),
            );
            await Future.delayed(Duration(seconds: 3));
          },
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              _InstitutionHomePageAppBar(institutionID: widget.institutionID),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: MultiSliver(
                  children: [
                    SyncStatusSection(),
                    SliverPinnedHeader(
                      child: Container(
                        color: Theme.of(context).colorScheme.surface,
                        padding: EdgeInsetsGeometry.symmetric(vertical: 8),
                        child: Text("Profile"),
                      ),
                    ),

                    BlocBuilder<StudentProfileBloc, StudentProfileState>(
                      builder: (context, state) =>
                          InstitutionStudentProfileCard(
                            onTap: () {
                              if ((state.profile?.id) != null) {
                                EditStudentProfileRoute(
                                  profileId: state.profile!.id!,
                                  institutionID: widget.institutionID,
                                ).push(context);
                                return;
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Can't update your profile at the moment"
                                    " please try again later",
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            profile: state.profile,
                          ),
                    ),

                    SliverPinnedHeader(
                      child: Container(
                        color: Theme.of(context).colorScheme.surface,
                        padding: EdgeInsetsGeometry.symmetric(vertical: 8),
                        child: Text("Finances"),
                      ),
                    ),

                    _FeesSectionCard(institutionID: widget.institutionID),

                    SliverPinnedHeader(
                      child: Container(
                        color: Theme.of(context).colorScheme.surface,
                        padding: EdgeInsetsGeometry.symmetric(vertical: 8),
                        child: Text("Courses"),
                      ),
                    ),
                    _CoursesSectionCard(institutionId: widget.institutionID),
                    SizedBox(height: 22),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstitutionHomePageAppBar extends StatelessWidget {
  const _InstitutionHomePageAppBar({required this.institutionID});
  final int institutionID;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstitutionBloc, InstitutionState>(
      builder: (context, state) => SliverAppBar.large(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          state is InstitutionLoadedState
              ? state.institutions
                    .firstWhere((ins) => ins.institutionId == institutionID)
                    .name
              : "#Error",
        ),
        actions: [
          BlocBuilder<ScrappingCommandBloc, ScrappingCommandState>(
            builder: (context, state) => state is ScrappingCommandLoaded
                ? IconButton(
                    onPressed: () {
                      InstitutionKeysViewRoute(
                        institutionID: institutionID,
                      ).push(context);
                    },
                    icon: Icon(Icons.key_outlined),
                  )
                : LoadingIndicatorM3E(),
          ),
        ],
      ),
    );
  }
}

class SyncStatusSection extends StatelessWidget {
  const SyncStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    final scrappingState = context.watch<ScrappingCommandBloc>().state;
    final magnetState = context.watch<MagnetBloc>().state;
    final keyState = context.watch<InstitutionKeyBloc>().state;

    // Condition logic moved here for readability
    final bool canExecute =
        (magnetState is MagnetReady || magnetState is MagnetSuccess) &&
        scrappingState is ScrappingCommandLoaded &&
        keyState is InstitutionKeyLoaded;

    final bool shouldShow = canExecute && magnetState is! MagnetProcessing;

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: shouldShow
          ? Card.filled(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: ListTile(
                onTap: () => _handleSync(context, scrappingState, keyState),
                leading: const Icon(Icons.sync_rounded),
                title: const Text("Sync your information"),
                subtitle: const Text("Update your profile and courses now"),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  void _handleSync(
    BuildContext context,
    ScrappingCommandLoaded scrappingState,
    InstitutionKeyLoaded keyState,
  ) {
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadedState) {
      context.read<MagnetBloc>().add(
        ExecuteScrappingCommand(
          institutionID: keyState.key?.institutionId ?? 0,
          userID: profileState.profile.id,
          command: scrappingState.command!,
          institutionKey: keyState.key!,
        ),
      );
    }
  }
}

class _FeesSectionCard extends StatelessWidget {
  const _FeesSectionCard({required this.institutionID});
  final int institutionID;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: ListTile(
        onTap: () {
          InstitutionFeesTransactionRoute(
            institutionID: institutionID,
          ).push(context);
        },
        leading: Icon(Icons.account_balance_rounded),
        title: Text("Fees transactions"),
        subtitle: Text("View your fees transactions"),
        trailing: Icon(Icons.arrow_forward_rounded),
      ),
    );
  }
}

class _CoursesSectionCard extends StatelessWidget {
  const _CoursesSectionCard({required this.institutionId});
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
              return Column(children: [Icon(Icons.emoji_people), Text("We")]);
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.emoji_people), Text("We")],
            );

            // return ListView.builder(
            //   padding: EdgeInsets.zero,
            //   itemCount: courses.length,
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, index) =>
            //       CourseCard(course: courses[index]),
            // );
          },
          error: (message) => Column(children: [Text(message)]),
        );
      },
    );
  }
}

import 'package:academia/config/router/router.dart';
import 'package:academia/features/course/course.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/gen/assets.gen.dart';
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
                    _MagnetLoadingProgressCard(),
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Assets.icons.notificationIconAlert.image(width: 250),
                  ),
                  Text(
                    "Oops!",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("We couldn't find any courses for this institution yet"),
                ],
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
                    await ViewCourseRoute(
                      courseId: course.id!,
                    ).push(context);
                    if (context.mounted) {
                      context.read<CourseCubit>().watchByInstitution(institutionId);
                      context.read<TimetableEntryBloc>().add(
                        WatchAllTimetableEntriesEvent(),
                      );
                    }
                  },
                );
              },
            );
          },
          error: (message) => Column(children: [Text(message)]),
        );
      },
    );
  }
}

class _MagnetLoadingProgressCard extends StatelessWidget {
  const _MagnetLoadingProgressCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<MagnetBloc, MagnetState>(
      builder: (context, state) {
        if (state is! MagnetProcessing) return const SizedBox.shrink();

        final progress = state.progress;
        final percent = (progress?.progressPercent ?? 0) / 100;

        // Dynamic labels based on the instruction type
        final actionLabel = _getFriendlyLabel(progress?.instructionType);
        final statusDetail = _getStatusDetail(progress);

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: BorderSide(color: theme.colorScheme.outlineVariant),
          ),
          color: theme.colorScheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    _AnimatedStatusAvatar(status: progress?.status),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            actionLabel,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            statusDetail,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Percentage indicator
                    Text(
                      '${(percent * 100).toInt()}%',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Smooth M3 Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: LinearProgressIndicator(
                    value: percent > 0 ? percent : null,
                    minHeight: 8,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progress?.status == InstructionStatus.failed
                          ? theme.colorScheme.error
                          : theme.colorScheme.primary,
                    ),
                  ),
                ),
                if (progress?.error != null) ...[
                  const SizedBox(height: 12),
                  _ErrorNote(message: progress!.error!),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  String _getFriendlyLabel(String? type) {
    switch (type) {
      case 'extract':
        return 'Syncing data...';
      case 'click':
        return 'Navigating portal...';
      case 'fill-form':
        return 'Authenticating...';
      case 'wait':
        return 'Optimizing connection...';
      case 'jsCode':
        return 'Processing request...';
      default:
        return 'Connecting to institution';
    }
  }

  String _getStatusDetail(InstructionProgressEvent? progress) {
    if (progress == null) return "Initializing...";
    if (progress.status == InstructionStatus.failed) {
      return "Retrying connection...";
    }
    return "Step ${progress.instructionIndex} of ${progress.totalInstructions}";
  }
}

class _AnimatedStatusAvatar extends StatelessWidget {
  final InstructionStatus? status;
  const _AnimatedStatusAvatar({this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRunning = status == InstructionStatus.running;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isRunning
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.surfaceContainerHighest,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: isRunning
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: theme.colorScheme.primary,
                ),
              )
            : Icon(
                status == InstructionStatus.completed
                    ? Icons.check
                    : Icons.sync,
                size: 20,
                color: theme.colorScheme.onSurfaceVariant,
              ),
      ),
    );
  }
}

class _ErrorNote extends StatelessWidget {
  final String message;
  const _ErrorNote({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 14, color: theme.colorScheme.error),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

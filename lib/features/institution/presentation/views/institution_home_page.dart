import 'package:academia/config/router/router.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            listener: (context, state) {},
          ),
          BlocListener<InstitutionKeyBloc, InstitutionKeyState>(
            listener: (context, state) {
              state.whenOrNull(
                error: (message, key) {
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
                },
                loaded: (key) {
                  if (key == null) {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      enableDrag: false,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(28.0),
                        ),
                      ),
                      builder: (context) {
                        return InstitutionSetupSheetContent(
                          institutionID: widget.institutionID,
                        );
                      },
                    );
                  }
                },
              );
            },
          ),
          BlocListener<MagnetBloc, MagnetState>(
            listener: (context, state) async {
              state.whenOrNull(
                success: (result) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("All synced — now saving offline…"),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              );
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
              InstitutionHomeAppBar(institutionID: widget.institutionID),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: MultiSliver(
                  children: [
                    SyncStatusSection(),
                    MagnetLoadingProgressCard(),
                    SliverPinnedHeader(
                      child: InstitutionSectionLabel(
                        icon: Icons.person_rounded,
                        title: "Profile",
                      ),
                    ),

                    BlocBuilder<StudentProfileBloc, StudentProfileState>(
                      builder: (context, state) {
                        final profile = state.whenOrNull(
                          success: (profile, profiles) => profile,
                        );
                        return InstitutionStudentProfileCard(
                          onTap: () {
                            if (profile?.id != null) {
                              EditStudentProfileRoute(
                                profileId: profile!.id!,
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
                          profile: profile,
                        );
                      },
                    ),

                    SliverPinnedHeader(
                      child: InstitutionSectionLabel(
                        icon: Icons.payments_rounded,
                        title: "Finances",
                      ),
                    ),

                    InstitutionFeesSectionCard(
                      institutionID: widget.institutionID,
                    ),

                    SliverPinnedHeader(
                      child: InstitutionSectionLabel(
                        icon: Icons.menu_book_rounded,
                        title: "Courses",
                      ),
                    ),
                    InstitutionCoursesSectionCard(
                      institutionId: widget.institutionID,
                    ),
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

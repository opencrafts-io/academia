import 'package:academia/config/router/router.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:academia/core/integration/portal_sync/portal_firebase_bootstrap.dart';

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
      body: RefreshIndicator(
        onRefresh: () async {
          // Re-reading the institution key here still serves one purpose:
          // it lazily migrates any legacy plaintext key row into secure
          // storage (see InstitutionKeyRepositoryImpl). There is no more
          // user-facing "keys" UI for it to feed.
          BlocProvider.of<InstitutionKeyBloc>(context)
              .add(GetInstitutionKeyEvent(institutionID: widget.institutionID));
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
                  if (portalSyncEnabled)
                    Card.filled(
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        leading: const Icon(Icons.language_rounded),
                        title: const Text('Connect your school portal'),
                        subtitle: const Text(
                          'Browse your courses and review class times before saving',
                        ),
                        trailing: const Icon(Icons.arrow_forward_rounded),
                        onTap: () => SchoolPortalRoute(
                          institutionID: widget.institutionID,
                        ).push(context),
                      ),
                    ),
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
    );
  }
}

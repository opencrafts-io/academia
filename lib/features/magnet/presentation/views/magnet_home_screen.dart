import 'package:academia/config/router/router.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/features/magnet/data/models/magnet_credential_extension.dart';
import 'package:academia/features/magnet/magnet.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

class MagnetHomeScreenAction {
  final String title;
  final String subtitle;
  final String assetImagePath;
  final Function(BuildContext context, int institutionID) ontap;

  MagnetHomeScreenAction({
    required this.title,
    required this.subtitle,
    required this.ontap,
    required this.assetImagePath,
  });
}

class MagnetHomeScreen extends StatefulWidget {
  const MagnetHomeScreen({super.key, required this.institutionID});

  final int institutionID;
  @override
  State<MagnetHomeScreen> createState() => _MagnetHomeScreenState();
}

class _MagnetHomeScreenState extends State<MagnetHomeScreen> {
  List<MagnetHomeScreenAction> get _magnetHomeScreenActions {
    return [
      MagnetHomeScreenAction(
        title: "School profile",
        subtitle: "View and manage your school profile",
        ontap: (BuildContext context, int institutionID) {
          MagnetProfileRoute(institutionID: institutionID).push(context);
        },
        assetImagePath: "assets/illustrations/authenticate.jpg",
      ),
      MagnetHomeScreenAction(
        title: "Classes",
        subtitle: "Never miss a class",
        ontap: (BuildContext context, int institutionID) {
          MagnetCoursesRoute(institutionID: institutionID).push(context);
        },
        assetImagePath: "assets/illustrations/classes.jpg",
      ),
      MagnetHomeScreenAction(
        title: "Your grades",
        subtitle: "Check your grades",
        ontap: (BuildContext context, int institutionID) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Your institution does not support showing this information yet",
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        assetImagePath: "assets/illustrations/grades.jpg",
      ),
      MagnetHomeScreenAction(
        title: "Fees statements",
        subtitle: "Your finances simplified",
        ontap: (BuildContext context, int institutionID) {
          MagnetFeesRoute(institutionID: institutionID).push(context);
        },
        assetImagePath: "assets/illustrations/school-fees.jpg",
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadedState) {
      context.read<MagnetBloc>().add(
        GetCachedMagnetCredentialEvent(
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
              if (state is MagnetCredentialNotFetched) {
                // context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Please link your school account to continue.",
                    ),
                    duration: Duration(seconds: 10),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                MagnetAuthRoute(
                  institutionID: widget.institutionID,
                ).push(context);
              } else if (state is MagnetCredentialFetched) {
                final profileState = context.read<ProfileBloc>().state;
                if (profileState is ProfileLoadedState) {
                  context.read<MagnetBloc>().add(
                    RefreshMagnetAuthenticationEvent(
                      institutionID: widget.institutionID,
                      userID: profileState.profile.id,
                      credentials: state.magnetCredential.toMagnet(),
                    ),
                  );
                }
              }
            },
          ),
        ],
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
          },
          child: BlocBuilder<InstitutionBloc, InstitutionState>(
            builder: (context, state) {
              Institution? institution;

              if (state is InstitutionLoadedState) {
                institution = state.institutions.firstWhere(
                  (ins) => ins.institutionId == widget.institutionID,
                );
              }

              return CustomScrollView(
                slivers: [
                  SliverAppBar.large(
                    pinned: true,
                    floating: true,
                    snap: true,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(institution?.name ?? "Unknown"),
                        if (institution?.domains?.isNotEmpty ?? false)
                          Text(
                            institution!.domains!.first,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(12),
                    sliver: SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            childAspectRatio: 0.8,
                          ),
                      itemCount: _magnetHomeScreenActions.length,
                      itemBuilder: (context, index) {
                        final item = _magnetHomeScreenActions[index];
                        return Card.outlined(
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () async {
                              if (await Vibration.hasVibrator()) {
                                Vibration.vibrate(
                                  pattern: [0, 50, 100, 50, 100, 100],
                                  intensities: [0, 128, 0, 128, 0, 128],
                                );
                              }
                              if (!context.mounted) return;
                              item.ontap(context, widget.institutionID);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    item.assetImagePath,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.subtitle,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Hello
                  SliverPadding(
                    padding: EdgeInsets.all(12),
                    sliver: MultiSliver(
                      children: [
                        BlocBuilder<InstitutionBloc, InstitutionState>(
                          buildWhen: (previous, current) =>
                              current is InstitutionLoadedState,
                          builder: (context, state) => Card.outlined(
                            clipBehavior: Clip.antiAlias,
                            child: ListTile(
                              trailing: Icon(Icons.open_in_new),
                              title: Text("Visit Institution's Official Site"),
                              onTap: () async {
                                final institution =
                                    (state as InstitutionLoadedState)
                                        .institutions
                                        .firstWhere(
                                          (ins) =>
                                              ins.institutionId ==
                                              widget.institutionID,
                                        );
                                final schoolUrl = Uri.parse(
                                  "https://${institution.domains?.first}",
                                );

                                if (await canLaunchUrl(schoolUrl)) {
                                  launchUrl(schoolUrl);
                                  return;
                                }
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Failed to launch ${institution.name} url",
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 22),
                        Text(
                          "Copyright ${DateTime.now().year}. All Rights Reserved.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:academia/features/magnet/magnet.dart';
import 'package:academia/features/magnet/presentation/views/widget/magnet_profile_widget.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:time_since/time_since.dart';

class MagnetProfilePage extends StatefulWidget {
  const MagnetProfilePage({super.key, required this.institutionID});
  final int institutionID;

  @override
  State<MagnetProfilePage> createState() => _MagnetProfilePageState();
}

class _MagnetProfilePageState extends State<MagnetProfilePage> {
  @override
  void initState() {
    super.initState();
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadedState) {
      context.read<MagnetBloc>().add(
        GetCachedMagnetProfileEvent(
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
              } else if (state is MagnetNotSupportedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Your institution does not support this feature",
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
            },
          ),
        ],
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            final profileState = context.read<ProfileBloc>().state;
            if (profileState is ProfileLoadedState) {
              context.read<MagnetBloc>().add(
                FetchMagnetProfileEvent(
                  institutionID: widget.institutionID,
                  userID: profileState.profile.id,
                ),
              );
            }

            await Future.delayed(Duration(seconds: 2));
          },
          child: BlocBuilder<MagnetBloc, MagnetState>(
            buildWhen: (previous, current) =>
                current is MagnetProfileLoadedState,
            builder: (context, state) => CustomScrollView(
              slivers: [
                SliverAppBar.large(
                  snap: true,
                  pinned: true,
                  floating: true,
                  title: Text("Your Profile"),
                  actions: [
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Your institution does not support this feature.",
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ],
                ),

                state is! MagnetProfileLoadedState
                    ? SliverPadding(
                        padding: EdgeInsets.all(12),
                        sliver: SliverFillRemaining(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LottieBuilder.asset(
                                "assets/lotties/digital-marketing.json",
                                height: 240,
                              ),
                              Text(
                                "We couldn't load your profile. Please pull to refresh",
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
                        padding: EdgeInsets.all(12),
                        sliver: MultiSliver(
                          children: [
                            MagnetProfileWidget(
                              image: (state as MagnetProfileLoadedState)
                                  .magnetStudentProfile
                                  .profilePictureUrl,
                              radius: 64,
                            ),
                            SizedBox(height: 22),
                            Text(
                              "Bio Data",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              margin: EdgeInsets.all(2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.vertical(
                                  top: Radius.circular(12),
                                  bottom: Radius.circular(0),
                                ),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.person),
                                title: Text(
                                  "${state.magnetStudentProfile.firstName} ${state.magnetStudentProfile.otherNames}",
                                ),
                                subtitle: Text(
                                  "Your recognized intitutional name",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              margin: EdgeInsets.all(2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.all(
                                  Radius.circular(0),
                                ),
                              ),
                              elevation: 0,
                              child: ListTile(
                                leading: Icon(Icons.numbers),
                                title: Text(
                                  state.magnetStudentProfile.nationalID ??
                                      'Please update your national ID',
                                ),
                                subtitle: Text(
                                  "National Identification Number",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              margin: EdgeInsets.all(2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.all(
                                  Radius.circular(0),
                                ),
                              ),
                              elevation: 0,
                              child: ListTile(
                                leading: Icon(Icons.email),
                                title: Text("Email address"),
                                subtitle: Text(
                                  state.magnetStudentProfile.email ??
                                      'No email address found',

                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),

                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              margin: EdgeInsets.all(2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.all(
                                  Radius.circular(0),
                                ),
                              ),
                              elevation: 0,
                              child: ListTile(
                                leading: Icon(Icons.today),
                                title: Text(
                                  DateFormat.yMMMMEEEEd().format(
                                    state.magnetStudentProfile.dateOfBirth ??
                                        DateTime(1900),
                                  ),
                                ),
                                subtitle: Text(
                                  "Your birthday was ${timeSince(state.magnetStudentProfile.dateOfBirth ?? DateTime(1900))}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),

                            Card(
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              margin: EdgeInsets.all(2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.vertical(
                                  bottom: Radius.circular(8),
                                ),
                              ),
                              elevation: 0,
                              child: ListTile(
                                leading: Icon(Icons.transgender),
                                title: Text(
                                  state.magnetStudentProfile.gender ??
                                      'Unknown',
                                ),
                                subtitle: Text(
                                  "Gender",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                            SizedBox(height: 22),
                            Text(
                              "Intitutional Data",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.tertiaryContainer,
                              margin: EdgeInsets.all(2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.vertical(
                                  top: Radius.circular(12),
                                  bottom: Radius.circular(0),
                                ),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.person),
                                title: Text(
                                  state.magnetStudentProfile.admissionNumber,
                                ),
                                subtitle: Text(
                                  "Your unique organizational identifier",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.tertiaryContainer,
                              margin: EdgeInsets.all(2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.all(
                                  Radius.circular(0),
                                ),
                              ),
                              elevation: 0,
                              child: ListTile(
                                leading: Icon(Icons.work),
                                title: Text(state.magnetStudentProfile.school),
                                subtitle: Text(
                                  "Your institution's name",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.tertiaryContainer,
                              margin: EdgeInsets.all(2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.all(
                                  Radius.circular(0),
                                ),
                              ),
                              elevation: 0,
                              child: ListTile(
                                leading: Icon(Icons.business_center),
                                title: Text(
                                  "${state.magnetStudentProfile.campus}",
                                ),
                                subtitle: Text(
                                  "Campus you're assigned to",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),

                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.tertiaryContainer,
                              margin: EdgeInsets.all(2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.all(
                                  Radius.circular(0),
                                ),
                              ),
                              elevation: 0,
                              child: ListTile(
                                leading: Icon(Icons.event_note),
                                title: Text(
                                  "${state.magnetStudentProfile.academicYear}",
                                ),
                                subtitle: Text(
                                  "Your current year of study",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.tertiaryContainer,
                              margin: EdgeInsets.all(2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.all(
                                  Radius.circular(0),
                                ),
                              ),
                              elevation: 0,
                              child: ListTile(
                                leading: Icon(Icons.workspace_premium),
                                title: Text(
                                  "${(state.magnetStudentProfile.degree?.isEmpty ?? true) ? 'Unknown' : state.magnetStudentProfile.degree}",
                                ),
                                subtitle: Text(
                                  "Degree your're pursuing",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.tertiaryContainer,
                              margin: EdgeInsets.all(2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.all(
                                  Radius.circular(0),
                                ),
                              ),
                              elevation: 0,
                              child: ListTile(
                                leading: Icon(Icons.card_membership),
                                title: Text(
                                  "${(state.magnetStudentProfile.programme?.isEmpty ?? true) ? 'Unknown' : state.magnetStudentProfile.programme}",
                                ),
                                subtitle: Text(
                                  "Programme you're enrolled",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),

                            Card.filled(
                              color: Theme.of(
                                context,
                              ).colorScheme.tertiaryContainer,
                              margin: EdgeInsets.all(2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.vertical(
                                  bottom: Radius.circular(8),
                                ),
                              ),
                              elevation: 0,
                              child: ListTile(
                                leading: Icon(Icons.calendar_month),
                                title: Text(
                                  state.magnetStudentProfile.dateOfAdmission ==
                                          null
                                      ? 'Unknown'
                                      : DateFormat.yMMMMEEEEd().format(
                                          state
                                              .magnetStudentProfile
                                              .dateOfAdmission!,
                                        ),
                                ),
                                subtitle: Text(
                                  "Date Admitted",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                          ],
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

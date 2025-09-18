import 'package:academia/constants/constants.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:time_since/time_since.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late AdBloc adBloc = BlocProvider.of<AdBloc>(context);
  @override
  void initState() {
    super.initState();
    final profileState = BlocProvider.of<ProfileBloc>(context).state;

    if (profileState is ProfileLoadedState) {
      context.read<InstitutionBloc>().add(
        GetCachedUserInstitutionsEvent(profileState.profile.id),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          final profileState = context.read<ProfileBloc>().state;

          if (profileState is ProfileLoadedState) {
            context.read<InstitutionBloc>().add(
              RefreshUserInstitutionsEvent(profileState.profile.id),
            );
          }

          BlocProvider.of<ProfileBloc>(context).add(RefreshProfileEvent());
          return Future.delayed(Duration(seconds: 2));
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (stateA, stateB) => stateB is ProfileLoadedState,
          builder: (context, state) => CustomScrollView(
            slivers: [
              SliverAppBar(
                snap: true,
                pinned: true,
                floating: true,
                title: Text("Profile"),
                actions: [
                  Visibility(
                    visible: kDebugMode,
                    child: IconButton(
                      icon: Icon(Icons.token),
                      onPressed: () {
                        final token =
                            (BlocProvider.of<AuthBloc>(context).state
                                    as AuthAuthenticated)
                                .token;
                        Clipboard.setData(
                          ClipboardData(text: token.accessToken),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Debug token copied to system clipboard",
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Symbols.edit_rounded),
                    onPressed: () {},
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    constraints: BoxConstraints(
                      maxWidth: ResponsiveBreakPoints.mobile,
                    ),
                    child: Column(
                      spacing: 0,
                      children: [
                        UserAvatar(radius: 60),
                        SizedBox(height: 12),
                        Text(
                          (state as ProfileLoadedState).profile.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          "@${state.profile.username?.toLowerCase() ?? 'anonymous'}",
                        ),

                        SizedBox(height: 12),
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your Academia Profile",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.all(2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.vertical(
                              top: Radius.circular(12),
                              bottom: Radius.circular(0),
                            ),
                          ),
                          elevation: 0,
                          child: ListTile(
                            leading: Icon(Symbols.person_filled),
                            title: Text(state.profile.name),
                            subtitle: Text(
                              "Your full name",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.all(2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.all(
                              Radius.circular(0),
                            ),
                          ),
                          elevation: 0,
                          child: ListTile(
                            leading: Icon(Symbols.numbers),
                            title: Text(
                              state.profile.nationalID ??
                                  'Please update your national ID',
                            ),
                            subtitle: Text(
                              "National Identification Number",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.all(2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.all(
                              Radius.circular(0),
                            ),
                          ),
                          elevation: 0,
                          child: ListTile(
                            leading: Icon(Symbols.phone),
                            title: Text(
                              state.profile.phone ??
                                  'Please update your phone number',
                            ),
                            subtitle: Text(
                              "Your phone number",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.all(2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.all(
                              Radius.circular(0),
                            ),
                          ),
                          elevation: 0,
                          child: ListTile(
                            leading: Icon(Symbols.email),
                            title: Text(state.profile.email),
                            subtitle: Text(
                              "Your personal email",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.all(2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.vertical(
                              bottom: Radius.circular(8),
                            ),
                          ),
                          elevation: 0,
                          child: ListTile(
                            leading: Icon(Symbols.today),
                            title: Text(timeSince(state.profile.createdAt)),
                            subtitle: Text(
                              "Time since you joined Academia",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(12),
                          child: BannerAdWidget(
                            adUnitId: "ca-app-pub-3940256099942544/6300978111",
                            adSize: AdSize(width: 320, height: 50),
                            height: 50,
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your Institutional Profiles",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),

                        ProfileInstitutionSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

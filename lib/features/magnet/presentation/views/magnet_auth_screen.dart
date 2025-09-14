import 'package:academia/features/institution/institution.dart';
import 'package:academia/features/magnet/magnet.dart';
import 'package:academia/features/profile/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:magnet/magnet.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:url_launcher/url_launcher.dart';

class MagnetAuthScreen extends StatefulWidget {
  final int institutionID;
  const MagnetAuthScreen({super.key, required this.institutionID});

  @override
  State<MagnetAuthScreen> createState() => _MagnetAuthScreenState();
}

class _MagnetAuthScreenState extends State<MagnetAuthScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        final profileState = context.read<ProfileBloc>().state;
        if (profileState is ProfileLoadedState) {
          context.read<InstitutionBloc>().add(
            RefreshUserInstitutionsEvent(profileState.profile.id),
          );
        }
        await Future.delayed(Duration(seconds: 2));
      },
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<InstitutionBloc, InstitutionState>(
              listener: (context, state) {
                if (state is InstitutionErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 30),
                      showCloseIcon: true,
                      content: Text(state.error),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }
                if (state is InstitutionLoadedState &&
                    state.institutions.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 30),
                      showCloseIcon: true,
                      content: Text(
                        "Seems youre not enrolled to an institution yet enroll to continue..",
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }
              },
            ),

            BlocListener<MagnetBloc, MagnetState>(
              listener: (context, state) {
                if (state is MagnetNotSupportedState) {
                print(widget.institutionID);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 30),
                      showCloseIcon: true,
                      content: Text(
                        "Your institution is unsupported on Academia."
                        " Stay alert for updates supporting your institution",
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }
              },
            ),
          ],
          child: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Link your school account."),
                    Text(
                      "Powered by magnet",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              SliverPadding(
                padding: EdgeInsetsGeometry.all(12),
                sliver: MultiSliver(
                  children: [
                    BlocBuilder<InstitutionBloc, InstitutionState>(
                      builder: (context, state) {
                        if (state is InstitutionLoadedState) {
                          final institution = state.institutions.firstWhere(
                            (inst) =>
                                inst.institutionId == widget.institutionID,
                          );

                          return Card.outlined(
                            child: ListTile(
                              title: Text(institution.name),
                              subtitle: Text(
                                "Provide credentials for this institution",
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  final url = Uri.parse(
                                    "https://${institution.domains?.first ?? ''}",
                                  );
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(
                                      url,
                                      mode: LaunchMode
                                          .externalApplication, // opens in browser
                                    );
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                icon: Icon(Icons.link),
                              ),
                            ),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Please fill in the form below to link your"
                      " account of the institution shown above",
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        hintText: "Admission Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Your school password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    SizedBox(height: 22),
                    BlocBuilder<MagnetBloc, MagnetState>(
                      builder: (context, state) {
                        if (state is MagnetLoadingState) {
                          return Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        return FilledButton(
                          onPressed: () {
                            showAdaptiveDialog(
                              context: context,
                              builder: (context) => AlertDialog.adaptive(
                                title: Text("Just a quick minute"),
                                content: Text(
                                  "By continuing, you consent to us processing your school data in line with our policies. You remain responsible for how you use and share this data.",
                                ),
                                actions: [
                                  FilledButton(
                                    onPressed: () {
                                      context.read<MagnetBloc>().add(
                                        LinkMagnetAccountEvent(
                                          credentials: Credentials(
                                            username: _usernameController.text,
                                            password: _passwordController.text,
                                          ),
                                          institutionID: widget.institutionID,
                                        ),
                                      );
                                      context.pop();
                                    },
                                    child: Text("Continue"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    child: Text("Leave"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text("Link your school account"),
                        );
                      },
                    ),

                    SizedBox(height: 22),
                    Text(
                      "Your school data remains secure using millitary"
                      " grade encryption standards. Not even us can read your school data without your explicit consent. "
                      "Checkout on our terms of service and privacy policy"
                      " for more information.",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
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

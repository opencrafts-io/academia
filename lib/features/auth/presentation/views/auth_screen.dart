import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Oops! ${state.message}"),
                    behavior: SnackBarBehavior.floating,
                    width: MediaQuery.of(context).size.width * 0.75,
                    showCloseIcon: true,
                  ),
                  snackBarAnimationStyle: AnimationStyle(
                    curve: Curves.bounceIn,
                  ),
                );
                return;
              }

              if (state is AuthAuthenticated) {
                // Trigger profile refresh and let router handle navigation
                BlocProvider.of<ProfileBloc>(
                  context,
                ).add(RefreshProfileEvent());

                // Add a timeout fallback in case profile loading takes too long
                Future.delayed(Duration(seconds: 5), () {
                  if (context.mounted) {
                    final currentProfileState = BlocProvider.of<ProfileBloc>(
                      context,
                    ).state;
                    if (currentProfileState is! ProfileLoadedState) {
                      // Force navigation to home if profile loading is taking too long
                      if (mounted) {
                        HomeRoute().go(context);
                      }
                    }
                  }
                });
                return;
              }
            },
          ),
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Oops! ${state.message}"),
                    behavior: SnackBarBehavior.floating,
                    width: MediaQuery.of(context).size.width * 0.75,
                    showCloseIcon: true,
                  ),
                  snackBarAnimationStyle: AnimationStyle(
                    curve: Curves.bounceIn,
                  ),
                );
                return;
              }

              // Profile loaded successfully - router will handle navigation
              if (state is ProfileLoadedState) {
                // Trigger router refresh to handle navigation
                AppRouter.router.refresh();
              }
            },
          ),
        ],
        child: SafeArea(
          minimum: EdgeInsets.all(12),
          child: LayoutBuilder(
            builder: (context, constraints) => Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    maxWidth: 320,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Spacer(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Assets.icons.padlock.image(),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Your school life. Fun.",
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Continue to your Academia account.",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.outlineVariant,
                              ),
                        ),

                        SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(
                              context,
                            ).add(AuthSignInWithAppleEvent());
                          },
                          label: Text("Continue with Apple"),
                          icon: Icon(FontAwesome.apple_brand),
                        ),

                        FilledButton.icon(
                          iconAlignment: IconAlignment.start,
                          onPressed: () async {
                            BlocProvider.of<AuthBloc>(
                              context,
                            ).add(AuthSignInWithGoogleEvent());
                          },
                          label: Text("Continue with Google"),
                          icon: Icon(FontAwesome.google_brand),
                        ),
                        SizedBox(height: 22),
                        Text.rich(
                          TextSpan(
                            text:
                                "By continuing, you acknowledge that you understand and agree to Academia's ",
                            children: [
                              TextSpan(
                                text: "Terms & conditions",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      decoration: TextDecoration.underline,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    try {
                                      final url = Uri.parse(
                                        'https://policy.opencrafts.io',
                                      );
                                      if (await canLaunchUrl(url)) {
                                        launchUrl(url);
                                      }
                                    } catch (e) {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text("Failed to lauch url"),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    }
                                  },
                              ),
                              const TextSpan(text: " and "),
                              TextSpan(
                                text: "Privacy Policy",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      decoration: TextDecoration.underline,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    try {
                                      final url = Uri.parse(
                                        'https://policy.opencrafts.io',
                                      );
                                      if (await canLaunchUrl(url)) {
                                        launchUrl(url);
                                      }
                                    } catch (e) {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text("Failed to lauch url"),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    }
                                  },
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Spacer(),

                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Assets.icons.opencrafts.image(height: 40),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text.rich(
                            TextSpan(
                              text: "Powered by Open Crafts Interactive",
                              style: Theme.of(context).textTheme.bodySmall,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  try {
                                    final url = Uri.parse(
                                      'https://opencrafts.io/',
                                    );
                                    if (await canLaunchUrl(url)) {
                                      launchUrl(url);
                                    }
                                  } catch (e) {
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Failed to lauch url"),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

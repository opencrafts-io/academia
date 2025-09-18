import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 320),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset("assets/icons/academia.png", width: 60),
                  ),

                  Text(
                    "Your school life. Fun.",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Login to your Academia account.",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),

                  SizedBox(height: 16),
                  OutlinedButton.icon(
                    iconAlignment: IconAlignment.start,
                    onPressed: () async {
                      BlocProvider.of<AuthBloc>(
                        context,
                      ).add(AuthSignInWithGoogleEvent());
                    },
                    label: Text("Continue with Google"),
                    icon: Icon(FontAwesome.google_brand),
                  ),
                  // OutlinedButton.icon(
                  //   onPressed: () {},
                  //   label: Text("Continue with Apple"),
                  //   icon: Icon(FontAwesome.apple_brand),
                  // ),
                  // OutlinedButton.icon(
                  //   onPressed: () {},
                  //   label: Text("Continue with Microsoft"),
                  //   icon: Icon(FontAwesome.microsoft_brand),
                  // ),
                  // OutlinedButton.icon(
                  //   onPressed: () {},
                  //   label: Text("Continue with Github"),
                  //   icon: Icon(FontAwesome.github_brand),
                  // ),
                  OutlinedButton.icon(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(
                        context,
                      ).add(AuthSignInWithSpotifyEvent());
                    },
                    label: Text("Continue with Spotify"),
                    icon: Icon(FontAwesome.spotify_brand),
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
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

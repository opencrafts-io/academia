import '../bloc/auth_bloc.dart';
import 'password_sign_in_form.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
                if (!state.inline) {
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
                }
                return;
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
                            child: Image.asset('assets/icons/padlock.png'),
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                        ),

                        SizedBox(height: 16),
                        PasswordSignInForm(),
                        SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text("or continue with"),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        SizedBox(height: 12),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            final loading = state is AuthLoading;
                            return Row(
                              mainAxisAlignment: .center,
                              spacing: 12,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: loading
                                      ? null
                                      : () => context.read<AuthBloc>().add(
                                          AuthSignInWithAppleEvent(),
                                        ),
                                  label: Text("Apple"),
                                  icon: FaIcon(FontAwesomeIcons.apple),
                                ),
                                OutlinedButton.icon(
                                  iconAlignment: IconAlignment.start,
                                  onPressed: loading
                                      ? null
                                      : () => context.read<AuthBloc>().add(
                                          AuthSignInWithGoogleEvent(),
                                        ),
                                  label: Text("Google"),
                                  icon: FaIcon(FontAwesomeIcons.google),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 22),
                        Text.rich(
                          TextSpan(
                            text:
                                "By continuing, you acknowledge that you"
                                " understand and agree to Academia's ",
                            children: [
                              TextSpan(
                                text: "Terms & conditions",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
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
                          child: Image.asset(
                            'assets/icons/opencrafts.png',
                            height: 40,
                          ),
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

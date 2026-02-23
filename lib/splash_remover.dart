import 'package:academia/features/auth/auth.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashRemover extends StatefulWidget {
  final Widget child;
  const SplashRemover({super.key, required this.child});

  @override
  State<SplashRemover> createState() => _SplashRemoverState();
}

class _SplashRemoverState extends State<SplashRemover> {
  bool _splashRemoved = false;

  void _checkAndRemoveSplash(AuthState authState, ProfileState profileState) {
    if (_splashRemoved) return;

    final shouldRemove =
        authState is! AuthLoading &&
        (authState is AuthUnauthenticated ||
            (authState is AuthAuthenticated &&
                (profileState is ProfileLoadedState ||
                    profileState is ProfileErrorState)));

    if (shouldRemove) {
      FlutterNativeSplash.remove();
      _splashRemoved = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, profileState) {
            _checkAndRemoveSplash(authState, profileState);
            return widget.child;
          },
        );
      },
    );
  }
}

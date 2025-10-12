import 'package:academia/config/router/routes.dart';
import 'package:academia/features/profile/profile.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class OnboardingSuccessPage extends StatefulWidget {
  const OnboardingSuccessPage({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  State<OnboardingSuccessPage> createState() => _OnboardingSuccessPageState();
}

class _OnboardingSuccessPageState extends State<OnboardingSuccessPage> {
  UserProfile? profile;
  final ConfettiController _confettiController = ConfettiController(
    duration: Duration(seconds: 20),
  );

  @override
  void initState() {
    final profileState = BlocProvider.of<ProfileBloc>(context).state;
    if (profileState is ProfileLoadedState) {
      profile = profileState.profile;
    } else {
      BlocProvider.of<ProfileBloc>(context).add(RefreshProfileEvent());
    }
    super.initState();
    // _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadedState) {
          widget.onNext();
          return;
        }
        if (state is ProfileErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Oops! ${state.message}"),
              behavior: SnackBarBehavior.floating,
              width: MediaQuery.of(context).size.width * 0.75,
              showCloseIcon: true,
            ),
            snackBarAnimationStyle: AnimationStyle(curve: Curves.bounceIn),
          );
          return;
        }
      },
      builder: (context, state) => Stack(
        alignment: Alignment.center,
        children: [
          Align(
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 20,
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: AnimatedEmoji(AnimatedEmojis.fireHeart, size: 120),
                ),

                Text(
                  "Yay! Thats it for now. We'll tune Academia for you",
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                FilledButton(
                  onPressed: () async {
                    _confettiController.play();
                    BlocProvider.of<ProfileBloc>(context).add(
                      UpdateUserProfileEvent(
                        profile: profile!.copyWith(
                          onboarded: true,
                          termsAccepted: true,
                        ),
                      ),
                    );
                    if (await Vibration.hasVibrator()) {
                      await Vibration.vibrate(
                        preset: VibrationPreset.dramaticNotification,
                      );
                    }
                  },
                  child: Text("Get started"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

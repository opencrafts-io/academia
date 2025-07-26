import 'package:academia/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingSuccessPage extends StatefulWidget {
  const OnboardingSuccessPage({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  State<OnboardingSuccessPage> createState() => _OnboardingSuccessPageState();
}

class _OnboardingSuccessPageState extends State<OnboardingSuccessPage> {
  UserProfile? profile;

  @override
  void initState() {
    final profileState = BlocProvider.of<ProfileBloc>(context).state;
    if (profileState is ProfileLoadedState) {
      profile = profileState.profile;
    } else {
      BlocProvider.of<ProfileBloc>(context).add(RefreshProfileEvent());
    }
    super.initState();
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
      builder: (context, state) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          Text(
            "Yay! Thats it for now. We'll tune Academia for you",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          FilledButton(
            onPressed: () async {
              BlocProvider.of<ProfileBloc>(context).add(
                UpdateUserProfileEvent(
                  profile: profile!.copyWith(
                    onboarded: true,
                    termsAccepted: true,
                  ),
                ),
              );
              await Future.delayed(Duration(seconds: 2));
            },
            child: Text("Get started"),
          ),
        ],
      ),
    );
  }
}

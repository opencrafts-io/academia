import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/gen/assets.gen.dart';

import './school_edit_page.dart';
import './account_recovery_page.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  bool _isRecovery = false;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _determineInitialPage();
    }
  }

  void _determineInitialPage() {
    final profileState = context.read<ProfileBloc>().state;

    if (profileState is ProfileLoadedState) {
      final profile = profileState.profile;

      _isRecovery = profile.deletedAt != null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
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
        } else if (state is AccountRecoveryRequestedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              behavior: SnackBarBehavior.floating,
            ),
          );

          // Refresh profile
          context.read<ProfileBloc>().add(RefreshProfileEvent());
        } else if (state is ProfileLoadedState) {
          // Only navigate home after recovery, not during normal onboarding
          if (_isRecovery) {
            HomeRoute().go(context);
          }
        }
      },
      child: _isRecovery
          ? Scaffold(body: _buildRecoveryPage())
          : ProfileOnboardingWizard(
              brand: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.icons.academia.image(width: 32, height: 32),
                  const SizedBox(width: 8),
                  Text(
                    'Academia',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              placeholderAvatar: const Center(
                child: Text('😎', style: TextStyle(fontSize: 48)),
              ),
              institutionStepBuilder: (
                context, {
                required onPrevious,
                required onNext,
              }) => SchoolEditPage(onPrevious: onPrevious, onNext: onNext),
              onFinished: () => HomeRoute().go(context),
            ),
    );
  }

  Widget _buildRecoveryPage() {
    final profileState = context.read<ProfileBloc>().state;

    if (profileState is! ProfileLoadedState) {
      return Center(child: CircularProgressIndicator());
    }

    return AccountRecoveryPage(
      deletedAt: profileState.profile.deletedAt!,
      onRecover: () {
        context.read<ProfileBloc>().add(RequestAccountRecoveryEvent());
      },
    );
  }
}

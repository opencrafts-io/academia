import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';

import '../../domain/user_profile.dart';
import '../bloc/profile_bloc.dart';
import 'onboarding_components.dart';

class OnboardingSuccessPage extends StatefulWidget {
  const OnboardingSuccessPage({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  State<OnboardingSuccessPage> createState() => _OnboardingSuccessPageState();
}

class _OnboardingSuccessPageState extends State<OnboardingSuccessPage> {
  UserProfile? _profile;
  bool _acceptedTerms = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileBloc>().state;
    if (state is ProfileLoadedState) {
      _profile = state.profile;
      _acceptedTerms = state.profile.termsAccepted;
    }
  }

  void _complete() {
    final profile = _profile;
    if (_saving || profile == null || !_acceptedTerms) return;
    setState(() => _saving = true);
    context.read<ProfileBloc>().add(
      UpdateUserProfileEvent(
        profile: profile.copyWith(onboarded: true, termsAccepted: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => BlocListener<ProfileBloc, ProfileState>(
    listener: (context, state) {
      if (state is ProfileLoadedState) {
        final shouldFinish = _saving;
        setState(() {
          _profile = state.profile;
          _saving = false;
        });
        if (shouldFinish) widget.onNext();
      } else if (state is ProfileErrorState) {
        setState(() => _saving = false);
      }
    },
    child: ListView(
      padding: const EdgeInsets.symmetric(vertical: 24),
      children: [
        Center(
          child: SizedBox.square(
            dimension: 132,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipPath(
                  clipper: const M3EShapeClipper(M3EShape.cookie9Sided),
                  child: ColoredBox(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: const SizedBox.expand(),
                  ),
                ),
                Icon(
                  Icons.done_all_rounded,
                  size: 54,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),
        ProfileStepHeading(
          icon: Icons.verified_outlined,
          title: 'You’re ready to get started',
          subtitle:
              'Review and accept the terms to finish setting up your profile.',
        ),
        const SizedBox(height: 24),
        CheckboxListTile(
          value: _acceptedTerms,
          onChanged: _saving
              ? null
              : (accepted) =>
                    setState(() => _acceptedTerms = accepted ?? false),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 4,
          ),
          controlAffinity: ListTileControlAffinity.leading,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          tileColor: Theme.of(context).colorScheme.surfaceContainerLow,
          title: const Text('I agree to the Academia terms and privacy policy'),
          subtitle: const Text('You can review these before continuing.'),
        ),
        const SizedBox(height: 22),
        FilledButton.icon(
          onPressed: _acceptedTerms && _profile != null && !_saving
              ? _complete
              : null,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(58),
            shape: const StadiumBorder(),
          ),
          iconAlignment: IconAlignment.end,
          icon: _saving
              ? const SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                )
              : const Icon(Icons.arrow_forward_rounded),
          label: Text(_saving ? 'Finishing setup' : 'Finish setup'),
        ),
        const SizedBox(height: 16),
        Text(
          'You’re in control of your profile details and can update them later.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ],
    ),
  );
}

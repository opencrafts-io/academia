import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/user_profile.dart';
import '../bloc/profile_bloc.dart';
import 'onboarding_components.dart';

class NameEditPage extends StatefulWidget {
  const NameEditPage({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  State<NameEditPage> createState() => _NameEditPageState();
}

class _NameEditPageState extends State<NameEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  UserProfile? _profile;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileBloc>().state;
    if (state is ProfileLoadedState) {
      _applyProfile(state.profile);
    } else {
      context.read<ProfileBloc>().add(RefreshProfileEvent());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _applyProfile(UserProfile profile) {
    _profile = profile;
    _nameController.text = profile.name;
    _usernameController.text = profile.username ?? '';
  }

  void _submit() {
    if (_saving || _profile == null || !_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _saving = true);
    context.read<ProfileBloc>().add(
      UpdateUserProfileEvent(
        profile: _profile!.copyWith(
          username: _usernameController.text.trim(),
          name: _nameController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => BlocListener<ProfileBloc, ProfileState>(
    listener: (context, state) {
      if (state is ProfileLoadedState) {
        final shouldAdvance = _saving;
        setState(() {
          _applyProfile(state.profile);
          _saving = false;
        });
        if (shouldAdvance) widget.onNext();
      } else if (state is ProfileErrorState) {
        setState(() => _saving = false);
      }
    },
    child: Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          ProfileStepHeading(
            icon: Icons.badge_outlined,
            title: 'The basics',
            subtitle:
                'Choose the name and username people will recognize you by.',
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            maxLength: 100,
            decoration: profileInputDecoration(
              context: context,
              label: 'Full name',
              hint: 'e.g. Alex Kamau',
              icon: Icons.person_outline_rounded,
            ),
            validator: (value) {
              final parts = (value ?? '').trim().split(RegExp(r'\s+'));
              if (parts.length < 2 || parts.any((part) => part.isEmpty)) {
                return 'Enter your first and last name.';
              }
              return null;
            },
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _usernameController,
            textInputAction: TextInputAction.next,
            maxLength: 30,
            autocorrect: false,
            decoration: profileInputDecoration(
              context: context,
              label: 'Username',
              hint: 'e.g. alex_k',
              prefixText: '@',
              icon: Icons.alternate_email_rounded,
              helperText: 'Use 3–30 letters, numbers or underscores.',
            ),
            validator: (value) {
              final username = (value ?? '').trim();
              if (!RegExp(r'^[a-zA-Z0-9_]{3,30}$').hasMatch(username)) {
                return 'Use 3–30 letters, numbers or underscores.';
              }
              return null;
            },
          ),
          const SizedBox(height: 28),
          ProfileStepActions(
            onPrevious: widget.onPrevious,
            onNext: _submit,
            isLoading: _saving,
            canContinue: _profile != null,
          ),
        ],
      ),
    ),
  );
}

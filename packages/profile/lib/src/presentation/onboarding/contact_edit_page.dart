import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../domain/user_profile.dart';
import '../bloc/profile_bloc.dart';
import 'onboarding_components.dart';

class ContactEditPage extends StatefulWidget {
  const ContactEditPage({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  State<ContactEditPage> createState() => _ContactEditPageState();
}

class _ContactEditPageState extends State<ContactEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = PhoneController(
    initialValue: PhoneNumber(isoCode: IsoCode.KE, nsn: ''),
  );
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
    _phoneController.dispose();
    super.dispose();
  }

  void _applyProfile(UserProfile profile) {
    _profile = profile;
    final phone = profile.phone;
    if (phone == null || phone.isEmpty) return;
    try {
      _phoneController.value = PhoneNumber.parse(phone);
    } on FormatException {
      _phoneController.value = PhoneNumber(isoCode: IsoCode.KE, nsn: '');
    }
  }

  void _submit() {
    if (_saving || _profile == null || !_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _saving = true);
    context.read<ProfileBloc>().add(
      UpdateUserPhoneEvent(
        profile: _profile!.copyWith(
          phone: _phoneController.value.international,
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
          const ProfileStepHeading(
            icon: Icons.call_outlined,
            title: 'Add a contact number',
            subtitle:
                'Your number helps with account recovery and student services.',
          ),
          const SizedBox(height: 30),
          PhoneFormField(
            controller: _phoneController,
            validator: PhoneValidator.compose([
              PhoneValidator.required(context),
              PhoneValidator.validMobile(context),
            ]),
            countrySelectorNavigator:
                const CountrySelectorNavigator.modalBottomSheet(),
            isCountrySelectionEnabled: true,
            isCountryButtonPersistent: true,
            countryButtonStyle: const CountryButtonStyle(
              showFlag: true,
              flagSize: 20,
            ),
            decoration: profileInputDecoration(
              context: context,
              label: 'Mobile number',
              hint: '+254 712 345 678',
              icon: Icons.phone_iphone_rounded,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your number is used for essential account and campus services.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
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

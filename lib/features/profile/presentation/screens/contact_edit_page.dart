import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:animated_emoji/animated_emoji.dart';

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
  final PhoneController _phoneController = PhoneController(
    initialValue: PhoneNumber(isoCode: IsoCode.KE, nsn: ""),
  );
  final _formKey = GlobalKey<FormState>();
  UserProfile? profile;

  @override
  void initState() {
    final profileState = BlocProvider.of<ProfileBloc>(context).state;
    if (profileState is ProfileLoadedState) {
      profile = profileState.profile;
      if (profile?.phone != null) {
        _phoneController.value = PhoneNumber.parse(profile!.phone!);
      }
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
      builder: (context, state) => Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: AnimatedEmoji(AnimatedEmojis.callMeHand, size: 120),
              ),

              SizedBox(height: 12),
              Text(
                "How can we reach you",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              PhoneFormField(
                controller: _phoneController,
                validator: PhoneValidator.compose([
                  PhoneValidator.required(context),
                  PhoneValidator.validMobile(context),
                ]),
                countrySelectorNavigator:
                    const CountrySelectorNavigator.modalBottomSheet(),
                enabled: true,
                isCountrySelectionEnabled: true,
                isCountryButtonPersistent: true,
                countryButtonStyle: const CountryButtonStyle(
                  showFlag: true,
                  flagSize: 16,
                ),

                decoration: InputDecoration(
                  label: Text("Your phone number"),
                  hintText: "+254 712345678",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 12),
              ListTile(
                isThreeLine: true,
                leading: Icon(Icons.info),
                title: Text("About your phone number"),
                subtitle: Text(
                  "Some services in the application require your phone number.",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Row(
                spacing: 12,
                children: [
                  OutlinedButton(
                    onPressed: widget.onPrevious,
                    child: Text("Previous"),
                  ),
                  FilledButton(
                    onPressed: () async {
                      if (!context.mounted) return;

                      if (_formKey.currentState?.validate() ?? false) {
                        // Handle phone number submission
                        BlocProvider.of<ProfileBloc>(context).add(
                          UpdateUserPhoneEvent(
                            profile: profile!.copyWith(
                              phone: _phoneController.value.international,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text("Next"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

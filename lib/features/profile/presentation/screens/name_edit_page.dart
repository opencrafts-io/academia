import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_emoji/animated_emoji.dart';

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
  final TextEditingController _nationalIDController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserProfile? profile;

  @override
  void initState() {
    final profileState = BlocProvider.of<ProfileBloc>(context).state;
    if (profileState is ProfileLoadedState) {
      profile = profileState.profile;
      _nationalIDController.text = profileState.profile.nationalID ?? '';
      _nameController.text = profileState.profile.name;
      _nicknameController.text = profileState.profile.username ?? "";
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
          _nameController.text = state.profile.name;
          _nicknameController.text = state.profile.username ?? "";
          widget.onNext.call();
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
                child: AnimatedEmoji(AnimatedEmojis.nerdFace, size: 120),
              ),
              SizedBox(height: 12),
              Text(
                "Lets get to know you by name",
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              TextFormField(
                controller: _nationalIDController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if ((value?.length ?? 0) < 7) {
                    return "Please provide your ID number or passport number";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text("Your ID number"),
                  hintText: "Provide your passport number if international",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              TextFormField(
                controller: _nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if ((value?.split(' ').length ?? 0) < 2) {
                    return "Please provide at least two names";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text("Your names"),
                  hintText: "Arnold Schwarzenegger",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              TextFormField(
                controller: _nicknameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  // Check for letters and underscores only
                  if (!RegExp(r'^[a-zA-Z_]+$').hasMatch(value ?? '')) {
                    return "Please use only letters and underscores for the nickname";
                  }
                  if ((value?.length ?? 0) < 3) {
                    return "Please provide a nickname (min 3 characters)";
                  }
                  return null;
                },

                decoration: InputDecoration(
                  label: Text("Your nickname"),
                  hintText: "Schwarzenegger",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              ListTile(
                isThreeLine: true,
                leading: Icon(Icons.info),
                title: Text("About nicknames"),
                subtitle: Text(
                  "Nicknames are like usernames in the app. "
                  "We'll only show them to your friends",
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
                        // Only update profile if the form is valid
                        BlocProvider.of<ProfileBloc>(context).add(
                          UpdateUserProfileEvent(
                            profile: profile!.copyWith(
                              nationalID: _nationalIDController.text,
                              username: _nicknameController.text,
                              name: _nameController.text,
                            ),
                          ),
                        );
                      }
                    },
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileLoadingstate) {
                          return CircularProgressIndicator();
                        }
                        return Text("Next");
                      },
                    ),
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

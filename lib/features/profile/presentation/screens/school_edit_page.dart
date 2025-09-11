import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class SchoolEditPage extends StatefulWidget {
  const SchoolEditPage({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  State<SchoolEditPage> createState() => _SchoolEditPageState();
}

class _SchoolEditPageState extends State<SchoolEditPage> {
  Institution? _selectedInstitution;
  final SearchController _searchController = SearchController();
  UserProfile? profile;

  @override
  void initState() {
    super.initState();
    final profileState = BlocProvider.of<ProfileBloc>(context).state;
    if (profileState is ProfileLoadedState) {
      profile = profileState.profile;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        SizedBox(height: 12),
        Text(
          "Which school are you from?",
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        SizedBox(height: 22),

        SearchAnchor.bar(
          searchController: _searchController,
          barElevation: WidgetStatePropertyAll(0),
          barShape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              side: BorderSide(width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          barHintText: "Hogwart's School of Wizardry",
          barLeading: Icon(Icons.search),
          viewElevation: 0,
          suggestionsBuilder: (context, searchController) async {
            final InstitutionCubit institutionCubit =
                BlocProvider.of<InstitutionCubit>(context);

            final response = await institutionCubit.searchForInstitutionByName(
              searchController.text,
            );

            return response.fold(
              (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return [];
              },
              (intitutions) => intitutions
                  .map(
                    (ins) => ListTile(
                      onTap: () {
                        Vibration.vibrate(
                          preset: VibrationPreset.dramaticNotification,
                        );
                        setState(() {
                          _selectedInstitution = ins;
                          searchController.closeView(ins.name);
                        });
                      },
                      title: Text(ins.name),
                      subtitle: Text(ins.domains?.first ?? ""),
                      trailing: Text(ins.alphaTwoCode ?? 'TF'),
                    ),
                  )
                  .toList(),
            );
          },
        ),

        ListTile(
          isThreeLine: true,
          leading: Icon(Icons.info),
          title: Text("Why is my school information important"),
          subtitle: Text(
            "Some services in the application require to know where you're from to work",
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
              onPressed: () {
                if (_selectedInstitution != null) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Confirmation"),
                      content: Text(
                        "Are you sure you're a member of ${_selectedInstitution?.name}"
                        "? We may have to verify your information just to comply with your institution's Terms and Conditions",
                      ),
                      actions: [
                        FilledButton(
                          onPressed: () async {
                            final InstitutionCubit institutionCubit =
                                BlocProvider.of<InstitutionCubit>(context);

                            final result = await institutionCubit
                                .linkAccountToInstitution(
                                  profile!.id,
                                  _selectedInstitution!.institutionId,
                                );

                            if (!context.mounted) return;
                            context.pop();

                            return result.fold(
                              (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(error),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              (ok) {
                                if (ok) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "You account has successfully been linked to ${_selectedInstitution!.name}",
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  widget.onNext();
                                  return;
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "We ran into an issue attempting to link you to the selected institution. Please try again later",
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              },
                            );
                          },
                          child: Text("Yes im sure"),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedInstitution = null;
                              _searchController.clear();
                            });
                            context.pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "We've reset your input. Please provide your authentic institution",
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Text("I was just kidding"),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text("Next"),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                widget.onNext();
              },
              child: Text("Skip this step"),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:academia/features/features.dart';
import 'package:academia/features/institution/institution.dart';
import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import 'package:confetti/confetti.dart';

class InstitutionLinkingPage extends StatefulWidget {
  const InstitutionLinkingPage({super.key});

  @override
  State<InstitutionLinkingPage> createState() => _InstitutionLinkingPageState();
}

class _InstitutionLinkingPageState extends State<InstitutionLinkingPage> {
  final SearchController _searchController = SearchController();
  final ConfettiController _confettiController = ConfettiController(
    duration: Duration(seconds: 2),
  );
  Institution? _selectedInstitution;

  @override
  void dispose() {
    _searchController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      bottomBarVisibility: BottomBarVisibility.always(),
      extendBodyBehindTopBar: true,
      extendBodyBehindBottomBar: true,
      topBar: AppBar(
        leading: IconButton.filledTonal(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: BlocListener<InstitutionBloc, InstitutionState>(
        listener: (context, state) {
          if (state is InstitutionLinkedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "You have linked your account to ${_selectedInstitution?.name ?? ''}",
                ),
              ),
            );
            final profileState = context.read<ProfileBloc>().state;

            if (profileState is! ProfileLoadedState) {
              return;
            }

            context.read<InstitutionBloc>().add(
              GetCachedUserInstitutionsEvent(profileState.profile.id),
            );
          }
        },
        child: SafeArea(
          minimum: EdgeInsets.fromLTRB(32, 8, 32, 32),
          maintainBottomViewPadding: true,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                // color: Colors.red,
                constraints: BoxConstraints(maxWidth: 380),
                child: Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Assets.icons.animalsIconBird.image(height: 120, width: 120),
                    Text(
                      "Add an institution to your profile.",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    SizedBox(height: 24),
                    SearchAnchor.bar(
                      searchController: _searchController,
                      barElevation: WidgetStatePropertyAll(0),
                      barShape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      barHintText: "Hogwart's School of Wizardry",
                      barLeading: Icon(Icons.search),
                      viewElevation: 0,
                      isFullScreen: true,
                      suggestionsBuilder: (context, searchController) {
                        if (searchController.text == '') {
                          return [
                            Center(
                              child: Text("Please search for your school.."),
                            ),
                          ];
                        }

                        context.read<InstitutionBloc>().add(
                          SearchInstitutionByNameEvent(searchController.text),
                        );

                        return [
                          BlocBuilder<InstitutionBloc, InstitutionState>(
                            builder: (context, state) {
                              if (state is InstitutionLoadingState) {
                                return const Center(
                                  child: LoadingIndicatorM3E(),
                                );
                              }

                              if (state is InstitutionErrorState) {
                                return Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Card.filled(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.errorContainer,
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        state.error,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleSmall,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              if (state is InstitutionLoadedState) {
                                final institutions = state.institutions;
                                if (institutions.isEmpty) {
                                  return const ListTile(
                                    title: Text("No institutions found"),
                                  );
                                }
                                return Column(
                                  children: institutions
                                      .map(
                                        (ins) => ListTile(
                                          onTap: () {
                                            setState(() {
                                              _selectedInstitution = ins;
                                              searchController.closeView(
                                                ins.name,
                                              );
                                            });
                                          },
                                          title: Text(ins.name),
                                          subtitle: Text(
                                            ins.domains?.first ?? "",
                                          ),
                                          trailing: Text(
                                            ins.alphaTwoCode ?? 'TF',
                                          ),
                                        ),
                                      )
                                      .toList(),
                                );
                              }

                              return const SizedBox.shrink();
                            },
                          ),
                        ];
                      },
                    ),

                    SizedBox(height: 12),

                    ConfettiWidget(
                      confettiController: _confettiController,
                      gravity: 0.3,
                      shouldLoop: false,
                      blastDirectionality: BlastDirectionality.explosive,
                      maxBlastForce: 1.0,
                      minBlastForce: 0.15,
                      emissionFrequency: 0.05,
                      child: FilledButton(
                        onPressed: _selectedInstitution == null
                            ? null
                            : () {
                                final profileState = context
                                    .read<ProfileBloc>()
                                    .state;

                                if (profileState is! ProfileLoadedState) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        'Failed to load your academia profile please retry',
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                _confettiController.play();
                                context.read<InstitutionBloc>().add(
                                  LinkAccountToInstitutionEvent(
                                    accountID: profileState.profile.id,
                                    institutionID:
                                        _selectedInstitution!.institutionId,
                                  ),
                                );
                              },
                        child: Text("Add institution"),
                      ),
                    ),

                    Text.rich(
                      TextSpan(
                        text:
                            "By continuing, you acknowledge that you understand and agree to Academia's ",
                        children: [
                          TextSpan(
                            text: "Terms & conditions",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  decoration: TextDecoration.underline,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                try {
                                  final url = Uri.parse(
                                    'https://policy.opencrafts.io',
                                  );
                                  if (await canLaunchUrl(url)) {
                                    launchUrl(url);
                                  }
                                } catch (e) {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Failed to lauch url"),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              },
                          ),
                          const TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  decoration: TextDecoration.underline,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                try {
                                  final url = Uri.parse(
                                    'https://policy.opencrafts.io',
                                  );
                                  if (await canLaunchUrl(url)) {
                                    launchUrl(url);
                                  }
                                } catch (e) {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Failed to lauch url"),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              },
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

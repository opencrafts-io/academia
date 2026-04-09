import 'package:academia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';

class InstitutionLinkingPage extends StatefulWidget {
  const InstitutionLinkingPage({super.key});

  @override
  State<InstitutionLinkingPage> createState() => _InstitutionLinkingPageState();
}

class _InstitutionLinkingPageState extends State<InstitutionLinkingPage> {
  final SearchController _searchController = SearchController();
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
      body: SafeArea(
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
                      return [Center(child: LoadingIndicatorM3E())];
                    },
                  ),

                  SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {},
                    child: Text("Add institution"),
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
    );
  }
}

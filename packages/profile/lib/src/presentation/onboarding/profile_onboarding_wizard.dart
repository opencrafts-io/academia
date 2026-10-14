import 'package:flutter/material.dart';

import 'contact_edit_page.dart';
import 'name_edit_page.dart';
import 'onboarding_success_page.dart';
import 'welcome_page.dart';

typedef ProfileInstitutionStepBuilder = Widget Function(
  BuildContext context, {
  required VoidCallback onPrevious,
  required VoidCallback onNext,
});

class ProfileOnboardingWizard extends StatefulWidget {
  const ProfileOnboardingWizard({
    required this.institutionStepBuilder,
    required this.onFinished,
    this.brand,
    this.placeholderAvatar,
    super.key,
  });

  final ProfileInstitutionStepBuilder institutionStepBuilder;
  final VoidCallback onFinished;
  final Widget? brand;
  final Widget? placeholderAvatar;

  @override
  State<ProfileOnboardingWizard> createState() =>
      _ProfileOnboardingWizardState();
}

class _ProfileOnboardingWizardState extends State<ProfileOnboardingWizard> {
  final PageController _pageController = PageController();
  int _page = 0;

  static const _steps = 5;
  static const _stepLabels = [
    'Welcome',
    'Your details',
    'Contact',
    'Your campus',
    'All set',
  ];
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int page) {
    if (page < 0 || page >= _steps) return;
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOutCubicEmphasized,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      if (_page > 0)
                        IconButton(
                          tooltip: 'Go back',
                          onPressed: () => _goTo(_page - 1),
                          style: IconButton.styleFrom(
                            backgroundColor: colors.surfaceContainerLow,
                          ),
                          icon: const Icon(Icons.arrow_back_rounded),
                        )
                      else
                        const SizedBox.square(dimension: 48),
                      const Spacer(),
                      if (widget.brand != null) widget.brand!,
                      const Spacer(),
                      Text(
                        '${(_page + 1).toString().padLeft(2, '0')} / ${_steps.toString().padLeft(2, '0')}',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Semantics(
                    liveRegion: true,
                    label: 'Profile setup progress',
                    value:
                        'Step ${_page + 1} of $_steps: ${_stepLabels[_page]}',
                    child: ExcludeSemantics(
                      child: Row(
                        children: List.generate(_steps, (index) {
                          final active = index <= _page;
                          return Expanded(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 240),
                              curve: Curves.easeOut,
                              height: 5,
                              margin: EdgeInsets.only(
                                right: index == _steps - 1 ? 0 : 6,
                              ),
                              decoration: BoxDecoration(
                                color: active
                                    ? colors.primary
                                    : colors.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    child: Align(
                      key: ValueKey(_page),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _stepLabels[_page],
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (page) => setState(() => _page = page),
                      children: [
                        WelcomePage(
                          onNext: () => _goTo(1),
                          placeholderAvatar: widget.placeholderAvatar,
                        ),
                        NameEditPage(
                          onPrevious: () => _goTo(0),
                          onNext: () => _goTo(2),
                        ),
                        ContactEditPage(
                          onPrevious: () => _goTo(1),
                          onNext: () => _goTo(3),
                        ),
                        widget.institutionStepBuilder(
                          context,
                          onPrevious: () => _goTo(2),
                          onNext: () => _goTo(4),
                        ),
                        OnboardingSuccessPage(onNext: widget.onFinished),
                      ],
                    ),
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

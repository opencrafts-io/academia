import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './welcome_page.dart';
import './name_edit_page.dart';
import './contact_edit_page.dart';
import './school_edit_page.dart';
import './onboarding_success_page.dart';
import './account_recovery_page.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final PageController _pageController = PageController();
  double _progress = 0.0;
  int _initialPage = 0;
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

      if (profile.deletedAt != null) {
        _initialPage = -1;
        _progress = 0.0;
      } else {
        _initialPage = 0;
        _progress = 1 / 5;
      }
    }
  }

  void _updateProgress(int pageIndex) {
    setState(() {
      if (pageIndex >= 0 && pageIndex <= 4) {
        _progress = (pageIndex + 1) / 5;
      }
    });
  }

  void _moveToNextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _moveToPreviousPage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.elasticOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _initialPage == -1
          ? null
          : AppBar(
              centerTitle: true,
              leading: Padding(
                padding: EdgeInsetsGeometry.all(8),
                child: Image.asset("assets/icons/academia.png"),
              ),
              title: Text("Setup your profile"),
            ),
      resizeToAvoidBottomInset: true,
      body: BlocListener<ProfileBloc, ProfileState>(
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
            HomeRoute().go(context);
          }
        },
        child: SafeArea(
          minimum: _initialPage == -1 ? EdgeInsets.zero : EdgeInsets.all(12),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 600,
                maxHeight: _initialPage == -1
                    ? double.infinity
                    : MediaQuery.of(context).size.height * 0.8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_initialPage != -1)
                    LinearProgressIndicator(
                      value: _progress,
                      valueColor: AlwaysStoppedAnimation(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  Expanded(
                    child: _initialPage == -1
                        ? _buildRecoveryPage()
                        : PageView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            controller: _pageController,
                            onPageChanged: _updateProgress,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsetsGeometry.all(12),
                              child: _buildPage(index),
                            ),
                            itemCount: 5,
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

  Widget _buildPage(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return WelcomePage(
          onNext: () {
            _moveToNextPage();
          },
        );
      case 1:
        return NameEditPage(
          onPrevious: () {
            _moveToPreviousPage();
          },
          onNext: () {
            _moveToNextPage();
          },
        );
      case 2:
        return ContactEditPage(
          onPrevious: () {
            _moveToPreviousPage();
          },

          onNext: () {
            _moveToNextPage();
          },
        );
      case 3:
        return SchoolEditPage(
          onPrevious: () {
            _moveToPreviousPage();
          },
          onNext: () {
            _moveToNextPage();
          },
        );
      case 4:
        return OnboardingSuccessPage(
          onNext: () {
            HomeRoute().go(context);
          },
        );

      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Page $pageIndex",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "You shouldn't be here.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
    }
  }
}

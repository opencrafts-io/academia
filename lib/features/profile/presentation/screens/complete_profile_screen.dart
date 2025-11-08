import 'package:academia/config/config.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './welcome_page.dart';
import './name_edit_page.dart';
import './contact_edit_page.dart';
import './school_edit_page.dart';
import './onboarding_success_page.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final PageController _pageController = PageController();
  double _progress = 0.0;

  // Update progress based on the current page index
  void _updateProgress(int pageIndex) {
    setState(() {
      if (pageIndex <= 4) {
        _progress = (pageIndex + 1) / 5; // Since there are 5 pages
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
      appBar: AppBar(
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
            return;
          }
        },
        child: SafeArea(
          minimum: EdgeInsets.all(12),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 600,
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinearProgressIndicator(
                    value: _progress,
                    valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
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

  // Function to return the content of each page
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

import 'package:e_commerce_app/routes/routernames.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'first_splash_screen.dart';
import 'second_splash_screen.dart';
import 'third_splash_screen.dart';

/// PageView that hosts all onboarding splash screens.
class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({
    super.key,
    this.onComplete,
  });

  final VoidCallback? onComplete;

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  final PageController _pageController = PageController();

  void _goToNext() {
    if (_pageController.page! < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onComplete?.call();
    }
  }

  void _goToPrev() {
    if (_pageController.page! > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skip() {
    context.go(RouteNames.signup);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const BouncingScrollPhysics(),
      children: [
        FirstSplashScreen(
          onSkip: _skip,
          onNext: _goToNext,
        ),
        SecondSplashScreen(
          onSkip: _skip,
          onPrev: _goToPrev,
          onNext: _goToNext,
        ),
        ThirdSplashScreen(
          onSkip: _skip,
          onPrev: _goToPrev,
          onGetStarted: widget.onComplete ?? () {
            context.go(RouteNames.signup);
          },
        ),
      ],
    );
  }
}

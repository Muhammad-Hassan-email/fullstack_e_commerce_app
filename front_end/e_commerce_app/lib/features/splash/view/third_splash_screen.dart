import 'package:e_commerce_app/features/splash/content/splash_content.dart';
import 'package:e_commerce_app/features/splash/footer/footerwidget.dart';
import 'package:e_commerce_app/features/splash/header/headerwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Third onboarding splash screen - "Get Your Order"
/// Screen 3 of 3 in the onboarding flow.
class ThirdSplashScreen extends StatelessWidget {
  const ThirdSplashScreen({
    super.key,
    this.onSkip,
    this.onPrev,
    this.onGetStarted,
  });

  final VoidCallback? onSkip;
  final VoidCallback? onPrev;
  final VoidCallback? onGetStarted;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              HeaderWidget(
                step: 3,
                imagePath: 'assets/image_1.png',
                onSkip: onSkip ?? () {
                  print('Skip third screen');
                },
              ),
              const SizedBox(height: 32),
              ContentWidget(
                title: 'Get Your Order',
                description: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
              ),
              const Spacer(),
              FooterWidget(
                currentPage: 0,
                totalPages: 3,
                onPrev: onPrev ?? () {
                  print('Prev tapped');
                },
                onNext: onGetStarted?? () {
                  print('Next tapped');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
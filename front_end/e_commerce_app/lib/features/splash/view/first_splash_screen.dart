import 'package:e_commerce_app/features/splash/content/splash_content.dart';
import 'package:e_commerce_app/features/splash/footer/footerwidget.dart';
import 'package:e_commerce_app/features/splash/header/headerwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// First onboarding splash screen - "Choose Products"
/// Screen 1 of 3 in the onboarding flow.
class FirstSplashScreen extends StatelessWidget {
  const FirstSplashScreen({
    super.key,
    this.onSkip,
    this.onNext,
  });

  final VoidCallback? onSkip;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Header: time, progress, skip
              HeaderWidget(
                step: 1,
                imagePath: 'assets/image_1.png',
                onSkip: () {
                  print('Skip third screen');
                },
              ),
              const SizedBox(height: 25),
              ContentWidget(
                title: 'Choose Products',
                description: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
              ),
              const SizedBox(height: 25),
              FooterWidget(
                currentPage: 0,
                totalPages: 3,
                onPrev: onSkip ?? () {
                  print('Skip tapped');
                },
                onNext: onNext ?? () {
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
import 'package:e_commerce_app/features/splash/content/splash_content.dart';
import 'package:e_commerce_app/features/splash/footer/footerwidget.dart';
import 'package:e_commerce_app/features/splash/header/headerwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Second onboarding splash screen - "Make Payment"
/// Screen 2 of 3 in the onboarding flow.
class SecondSplashScreen extends StatelessWidget {
  const SecondSplashScreen({
    super.key,
    this.onSkip,
    this.onPrev,
    this.onNext,
  });

  final VoidCallback? onSkip;
  final VoidCallback? onPrev;
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
              HeaderWidget(
                step: 2,
                imagePath: 'assets/image_1.png',
                onSkip: onSkip ?? () {
                  print('Skip third screen');
                },
              ),
              const SizedBox(height: 32),
              ContentWidget(
                title: 'Make Payment',
                description: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
              ),
              const Spacer(),
              FooterWidget(
                currentPage: 0,
                totalPages: 3,
                onPrev: onPrev ?? () {},
                onNext: onNext ?? () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
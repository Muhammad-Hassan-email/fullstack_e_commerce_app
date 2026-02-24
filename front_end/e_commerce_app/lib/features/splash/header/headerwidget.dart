import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final int step; // current step number
  final String imagePath; // image for this header
  final VoidCallback? onSkip;

  const HeaderWidget({
    super.key,
    required this.step,
    required this.imagePath,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: '$step',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const TextSpan(
                      text: '/3',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: onSkip ?? () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                ),
                child: const Text('Skip'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
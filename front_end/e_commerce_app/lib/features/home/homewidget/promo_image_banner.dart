import 'package:flutter/material.dart';

class PromoImageBanner extends StatelessWidget {
  final String? title;
  final String assetPath;
  final double height;
  final VoidCallback onTap;

  const PromoImageBanner({
    super.key,
    this.title,
    required this.assetPath,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04, // 4% of screen width
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                assetPath,
                height: height,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8), // space between image and title
            // The title below the image
            if (title != null) ...[
              const SizedBox(height: 8), // space between image and title
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
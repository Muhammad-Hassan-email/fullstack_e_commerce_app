import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final bool showBackButton;
  final bool showProfileIcon;
  final String? title;
  final VoidCallback? onMenuTap;
  final VoidCallback? onProfileTap;
  final String logoPath;

  const CustomSliverAppBar({
    super.key,
    this.showBackButton = false,
    this.showProfileIcon = false,
    this.title,
    this.onMenuTap,
    this.onProfileTap,
    required this.logoPath,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            /// Left Button (Menu OR Back)
            IconButton(
              icon: Icon(
                showBackButton ? Icons.arrow_back : Icons.menu,
              ),
              onPressed: () {
                if (showBackButton) {
                  Navigator.pop(context);
                } else {
                  onMenuTap?.call();
                }
              },
            ),

            /// Center (Logo OR Title)
            Expanded(
              child: Center(
                child: title != null
                    ? Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2196F3),
                        ),
                      )
                    : Image.asset(
                        logoPath,
                        height: 35,
                      ),
              ),
            ),

            /// Right Side (Profile optional)
            showProfileIcon
                ? IconButton(
                    icon: const Icon(Icons.person_outline),
                    onPressed: onProfileTap,
                  )
                : const SizedBox(width: 48), // keeps alignment balanced
          ],
        ),
      ),
    );
  }
}
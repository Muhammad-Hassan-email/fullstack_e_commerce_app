import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final bool showBackButton;
  final bool showProfileIcon;
  final String? title;
  final VoidCallback? onMenuTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onCartTap;  // ✅ add
  final int cartCount;            // ✅ add
  final String logoPath;

  const CustomSliverAppBar({
    super.key,
    this.showBackButton = false,
    this.showProfileIcon = false,
    this.title,
    this.onMenuTap,
    this.onProfileTap,
    this.onCartTap,               // ✅ add
    this.cartCount = 0,           // ✅ add
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
            // ✅ Left - Back or Menu
            IconButton(
              icon: Icon(showBackButton ? Icons.arrow_back : Icons.menu),
              onPressed: () {
                if (showBackButton) {
                  Navigator.pop(context);
                } else {
                  onMenuTap?.call();
                }
              },
            ),

            // ✅ Center - Logo or Title
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
                    : Image.asset(logoPath, height: 35),
              ),
            ),

            // ✅ Right - Cart with badge OR Profile
            if (onCartTap != null)
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: onCartTap,
                  ),
                  if (cartCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE24A69),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$cartCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              )
            else if (showProfileIcon)
              IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: onProfileTap,
              )
            else
              const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }
}
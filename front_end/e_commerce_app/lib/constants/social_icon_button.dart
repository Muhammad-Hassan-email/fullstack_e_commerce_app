import 'package:flutter/material.dart';

class SocialIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Icon(icon, size: 28),
      ),
    );
  }
}
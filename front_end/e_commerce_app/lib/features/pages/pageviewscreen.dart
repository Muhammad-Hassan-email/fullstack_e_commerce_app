import 'package:flutter/material.dart';

class PageViewScreen extends StatelessWidget {
  final String label;
  final IconData icon;

  const PageViewScreen({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 72, color: const Color(0xFFC42D44).withOpacity(0.2)),
            const SizedBox(height: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Color(0xFF222222),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$label Screen',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFFAAAAAA),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
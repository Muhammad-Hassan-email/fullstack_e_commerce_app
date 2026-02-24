import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  final VoidCallback? onPrev;
  final VoidCallback? onNext;
  final int currentPage; // 0-based index
  final int totalPages;

  const FooterWidget({
    super.key,
    this.onPrev,
    this.onNext,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    const accentRed = Color(0xFFE24A69);

    List<Widget> buildDots() {
      return List.generate(totalPages, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: _PageDot(isActive: index == currentPage),
        );
      });
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onPrev ?? () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: const Text('Prev'),
          ),
          Row(mainAxisSize: MainAxisSize.min, children: buildDots()),
          TextButton(
            onPressed: onNext ?? () {},
            style: TextButton.styleFrom(
              foregroundColor: accentRed,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}

class _PageDot extends StatelessWidget {
  const _PageDot({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isActive ? 20 : 8,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isActive
            ? const Color(0xFF1A1A2E)
            : Colors.black.withOpacity(0.2),
      ),
    );
  }
}
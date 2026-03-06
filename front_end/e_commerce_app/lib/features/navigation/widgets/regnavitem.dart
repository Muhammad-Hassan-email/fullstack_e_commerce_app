import 'package:e_commerce_app/features/navigation/navitemmodel.dart';
import 'package:flutter/material.dart';

class RegularNavItem extends StatelessWidget {
  final NavItem item;
  final bool isSelected;

  const RegularNavItem({
    super.key,
    required this.item,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedScale(
            scale: isSelected ? 1.15 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              item.icon,
              size: 26,
              color: isSelected
                  ? const Color(0xFFC42D44)
                  : const Color(0xFF555555),
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 11,
              fontWeight:
                  isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? const Color(0xFFC42D44)
                  : const Color(0xFF888888),
            ),
            child: Text(item.label),
          ),
        ],
      ),
    );
  }
}
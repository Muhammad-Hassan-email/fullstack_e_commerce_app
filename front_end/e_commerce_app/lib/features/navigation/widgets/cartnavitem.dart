import 'package:flutter/material.dart';

class CartNavItem extends StatelessWidget {
  final bool isSelected;

  const CartNavItem({
    super.key,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFC42D44),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFC42D44).withOpacity(0.45),
                blurRadius: isSelected ? 18 : 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    );
  }
}
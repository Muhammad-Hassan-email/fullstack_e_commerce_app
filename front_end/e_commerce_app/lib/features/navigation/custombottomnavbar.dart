import 'package:e_commerce_app/core/provider/bottomnavprovider.dart';
import 'package:e_commerce_app/features/navigation/navitemmodel.dart';
import 'package:e_commerce_app/features/navigation/widgets/cartnavitem.dart';
import 'package:e_commerce_app/features/navigation/widgets/regnavitem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  static const List<NavItem> _items = [
    NavItem(icon: Icons.home_outlined, label: 'Home'),
    NavItem(icon: Icons.favorite_border, label: 'Wishlist'),
    NavItem(icon: Icons.shopping_cart_outlined, label: '', isCart: true),
    NavItem(icon: Icons.search, label: 'Search'),
    NavItem(icon: Icons.settings_outlined, label: 'Setting'),
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<BottomNavProvider>();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
        boxShadow: [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 8,
        top: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          final isSelected = navProvider.currentIndex == index;

          return GestureDetector(
            onTap: () => navProvider.changeTab(index),
            behavior: HitTestBehavior.opaque,
            child: item.isCart
                ? CartNavItem(isSelected: isSelected)
                : RegularNavItem(
                    item: item,
                    isSelected: isSelected,
                  ),
          );
        }),
      ),
    );
  }
}
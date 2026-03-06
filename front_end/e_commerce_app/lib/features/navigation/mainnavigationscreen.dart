import 'package:e_commerce_app/core/provider/bottomnavprovider.dart';
import 'package:e_commerce_app/features/cart/ShoppingBag.dart';
import 'package:e_commerce_app/features/home/view/home_screen.dart';
import 'package:e_commerce_app/features/navigation/custombottomnavbar.dart';
import 'package:e_commerce_app/features/pages/pageviewscreen.dart';
import 'package:e_commerce_app/features/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Widget> _pages = [
    HomeScreen(),
    WishlistScreen(),
    ShoppingBagPage(),
    PageViewScreen(label: 'Search', icon: Icons.search),
    PageViewScreen(label: 'Setting', icon: Icons.settings_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<BottomNavProvider>();

    return Scaffold(
      body: IndexedStack(
      index: navProvider.currentIndex,
      children: _pages,
    ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
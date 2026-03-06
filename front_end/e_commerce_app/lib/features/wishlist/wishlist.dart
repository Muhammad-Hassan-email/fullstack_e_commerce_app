import 'package:e_commerce_app/features/home/product/productcard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'wishlistprovider/wishlistprovider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ No ChangeNotifierProvider wrapper here anymore
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<WishlistProvider>(
          builder: (context, wishlistProvider, _) {
            final wishlist = wishlistProvider.wishlist;

            if (wishlist.isEmpty) {
              return const Center(child: Text('Your wishlist is empty'));
            }

            return ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final product = wishlist[index];
                return ProductCard(product: product); // ✅
              },
            );
          },
        ),
      ),
    );
  }
}
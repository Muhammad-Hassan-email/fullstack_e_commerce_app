import 'package:e_commerce_app/core/provider/bottomnavprovider.dart';
import 'package:e_commerce_app/features/cart/provider/cartprovider.dart';
import 'package:e_commerce_app/features/home/product/productprovider.dart';
import 'package:e_commerce_app/features/wishlist/wishlistprovider/wishlistprovider.dart';
import 'package:e_commerce_app/routes/approuter.dart';
import 'package:e_commerce_app/services/wishlistservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),

        // ✅ Products first — fetches immediately
        ChangeNotifierProvider(
          create: (_) => ProductProvider()..fetchProducts(),
        ),

        // ✅ Cart second — independent
        ChangeNotifierProvider(create: (_) => CartProvider()),

        // ✅ Wishlist last — needs userId from auth
        ChangeNotifierProvider(
          create:
              (_) => WishlistProvider(
                wishlistService: WishlistService(userId: "temp_user_123"),
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Stylish',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE24A69)),
      ),
    );
  }
}

import 'package:e_commerce_app/features/auth/view/signin/signin.dart';
import 'package:e_commerce_app/features/auth/view/signup/signup.dart';
import 'package:e_commerce_app/features/cart/ShoppingBag.dart';
import 'package:e_commerce_app/features/checkout/checkout.dart';
import 'package:e_commerce_app/features/checkout/ordercomplete.dart';
import 'package:e_commerce_app/features/checkout/paymentscreen.dart';
import 'package:e_commerce_app/features/completeproductview/detailscreen.dart';
import 'package:e_commerce_app/features/home/product/productmodel.dart';
import 'package:e_commerce_app/features/home/product/productscreen.dart';
import 'package:e_commerce_app/features/navigation/mainnavigationscreen.dart';
import 'package:e_commerce_app/features/profile/profile.dart';
import 'package:e_commerce_app/features/splash/view/onboarding_page_view.dart';
import 'package:e_commerce_app/features/splash/view/splash_screen.dart';
import 'package:e_commerce_app/routes/routernames.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteNames.splashscreen,
    routes: [
      GoRoute(
        path: RouteNames.splashscreen,
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const OnboardingPageView(),
      ),

      GoRoute(
        path: RouteNames.signup,
        builder: (context, state) => const SignupScreen(),
      ),

      GoRoute(
        path: RouteNames.signin,
        builder: (context, state) => const SigninScreen(),
      ),

      GoRoute(
        path: RouteNames.plistscrn,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final String title = extra['title'] ?? "Products";
          final String type = extra['type'] ?? "all";

          return ProductListScreen(
            // ✅ was Product(), now correct class
            title: title,
            type: type,
          );
        },
      ),
      // In approuter.dart line ~41
      GoRoute(
        path: RouteNames.detailscreen,
        builder: (context, state) {
          // ✅ Safe cast with error handling
          final extra = state.extra;
          if (extra is! Product) {
            // Prevents crash if wrong extra type is passed
            return const Scaffold(
              body: Center(child: Text('Invalid product data')),
            );
          }
          return DetailScreen(product: extra);
        },
      ),

      GoRoute(
        path: RouteNames.profile,
        builder: (context, state) => const ProfileScreen(),
      ),

      GoRoute(
        path: RouteNames.navbar,
        builder: (context, state) => MainScreen(),
      ),

      GoRoute(path: RouteNames.checkout, builder: (context, state) => CheckoutScreen(),),

      GoRoute(path: RouteNames.shoppingbag, builder: (context, state) => ShoppingBagPage(),),

      GoRoute(path: RouteNames.payment, builder: (context, state) => PaymentScreen(),),

      GoRoute(
        path: RouteNames.orderComplete,
        builder: (context, state) => const OrderComplete(),
      ),
    ],
  );
}

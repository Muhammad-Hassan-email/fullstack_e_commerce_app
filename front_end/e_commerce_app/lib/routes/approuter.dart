import 'package:e_commerce_app/features/auth/view/signin/signin.dart';
import 'package:e_commerce_app/features/auth/view/signup/signup.dart';
import 'package:e_commerce_app/features/splash/view/onboarding_page_view.dart';
import 'package:e_commerce_app/features/splash/view/splash_screen.dart';
import 'package:e_commerce_app/routes/routernames.dart';
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
    ],
  );
}
import 'package:e_commerce_app/constants/primary_button.dart';
import 'package:e_commerce_app/constants/social_icon_button.dart';
import 'package:e_commerce_app/features/auth/common_feature/fields.dart';
import 'package:e_commerce_app/features/auth/services/social_auth_service.dart';
import 'package:e_commerce_app/features/auth/view/signup/signup.dart';
import 'package:e_commerce_app/routes/routernames.dart';
import 'package:e_commerce_app/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart'; // for storing token

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final SocialAuthService _socialAuthService = const SocialAuthService();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      try {
        final result = await _authService.loginUser(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        if (result['token'] != null) {
          // Save JWT token locally
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', result['token']);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Successful')),
          );

          if (context.mounted) context.go(RouteNames.navbar);

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'] ?? 'Email or password is incorrect')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }

      setState(() => _isLoading = false);
    }
  }

  Future<void> _onSocialSignIn(SocialProvider provider) async {
    await _socialAuthService.signInWith(provider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Welcome\nBack!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppTextField(
                      controller: _emailController,
                      hintText: 'Username or Email',
                      prefixIcon: Icons.person,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      prefixIcon: Icons.lock,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // TODO: Navigate to forgot password screen.
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFFE24A69),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: _isLoading ? 'Loading...' : 'Login',
                onPressed: _isLoading ? null : _onLogin,
              ),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  '- OR Continue with -',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialIconButton(
                    icon: Icons.g_mobiledata,
                    onTap: () => _onSocialSignIn(SocialProvider.google),
                  ),
                  const SizedBox(width: 16),
                  SocialIconButton(
                    icon: Icons.apple,
                    onTap: () => _onSocialSignIn(SocialProvider.apple),
                  ),
                  const SizedBox(width: 16),
                  SocialIconButton(
                    icon: Icons.facebook,
                    onTap: () => _onSocialSignIn(SocialProvider.facebook),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create An Account ',
                    style: TextStyle(fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFE24A69),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
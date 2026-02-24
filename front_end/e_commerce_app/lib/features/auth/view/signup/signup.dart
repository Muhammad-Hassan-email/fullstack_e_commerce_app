import 'package:e_commerce_app/constants/primary_button.dart';
import 'package:e_commerce_app/constants/social_icon_button.dart';
import 'package:e_commerce_app/features/auth/common_feature/fields.dart';
import 'package:e_commerce_app/features/auth/services/social_auth_service.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final bool _obscurePassword = true;
  final bool _obscureConfirmPassword = true;

  final SocialAuthService _socialAuthService = const SocialAuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onCreateAccount() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Hook up with your backend signup logic.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Create account tapped')),
      );
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
                'Create an\naccount',
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
                      obscureText: _obscurePassword,
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
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      prefixIcon: Icons.lock,
                      obscureText: _obscureConfirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'By clicking the Register button, you agree\n'
                'to the public offer',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Create Account',
                onPressed: _onCreateAccount,
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
                    'I Already Have an Account ',
                    style: TextStyle(fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to login screen.
                    },
                    child: const Text(
                      'Login',
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
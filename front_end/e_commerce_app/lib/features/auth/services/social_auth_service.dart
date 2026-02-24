import 'package:flutter/foundation.dart';

enum SocialProvider { google, apple, facebook }

class SocialAuthService {
  const SocialAuthService();

  Future<void> signInWith(SocialProvider provider) async {
    // TODO: Integrate with real SDKs (e.g. firebase_auth, google_sign_in).
    debugPrint('Signing in with $provider');
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }
}


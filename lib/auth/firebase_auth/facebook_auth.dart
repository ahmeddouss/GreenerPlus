import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

final _facebookAuth = FacebookAuth.instance;

Future<UserCredential?> facebookSignInFunc() async {
  if (kIsWeb) {
    // Handle web-specific Facebook sign-in
    final LoginResult result =
        await _facebookAuth.login(permissions: ['email', 'public_profile']);
    if (result.status == LoginStatus.success) {
      final credential =
          FacebookAuthProvider.credential(result.accessToken!.tokenString);
      return FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      return null;
    }
  }

  // Handle mobile-specific Facebook sign-in
  final result = await _facebookAuth.login();
  print(result.accessToken!.tokenString.toString());
  print(result.message);
  if (result.status == LoginStatus.success) {
    final credential =
        FacebookAuthProvider.credential(result.accessToken!.tokenString);
    print(credential);
    return FirebaseAuth.instance.signInWithCredential(credential);
  } else {
    return null;
  }
}

Future<void> facebookSignOut() async {
  await _facebookAuth.logOut();
}

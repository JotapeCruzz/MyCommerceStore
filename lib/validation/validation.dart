import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email cannot be empty';
  } else if (value.length < 5) {
    return 'Email must be at least 5 characters long';
  } else if (!value.contains("@")) {
    return 'Invalid email format';
  }
  return null;
}

String? validateNickname(String? value) {
  if (value == null || value.isEmpty) {
    return "Nickname cannot be empty";
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  return null;
}

Future<UserCredential?> loginGoogle() async {
  try {
    final googleSignIn = GoogleSignIn(
      clientId: "395467234871-tels7cn4o3i9eqrbdarsmgsjqvndpokb.apps.googleusercontent.com",
    );

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
    print("Erro no login com Google: $e");
    return null;
  }
}




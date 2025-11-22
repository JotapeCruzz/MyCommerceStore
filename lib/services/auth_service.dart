import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_identity_services_web/google_identity_services_web.dart';
import 'dart:js_interop';
import 'dart:async';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> userRegister({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(name);
      return null;
    } on FirebaseAuthException catch (e) {
      print('Failed to register user: $e');
      if (e.code == 'email-already-in-use') {
        return "Já existe uma conta vinculada a este e-mail.";
      } else {
        return "Error: ${e.message}";
      }
    }
  }

  Future<String?> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      print('Failed to login user: $e');
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return "E-mail ou senha incorretos.";
      } else {
        return "Error: ${e.message}";
      }
    }
  }

  Future<UserCredential?> loginGoogle() async {
    try {
      final googleSignIn = GoogleSignIn(
        clientId:
            "395467234871-tels7cn4o3i9eqrbdarsmgsjqvndpokb.apps.googleusercontent.com",
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

  Future<void> userLogout() async {
    await _auth.signOut();
  }
}

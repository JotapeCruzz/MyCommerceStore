import 'package:firebase_auth/firebase_auth.dart';

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
      }
      else{
        return "Error: ${e.message}";
      }
    }
  }
}

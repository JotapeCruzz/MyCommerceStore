import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  userRegister ({
    required String email,
    required String password,
    required String name,
  }) async {
    _auth.createUserWithEmailAndPassword(email: email, password: password,);
  }
}

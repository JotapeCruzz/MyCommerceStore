import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:ecommerce_my_store/pages/home_screen.dart';
import 'package:ecommerce_my_store/pages/login_screen.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Usuário logado → envia para Home via rotas
        if (snapshot.hasData) {
          Future.microtask(() {
            Navigator.pushReplacementNamed(context, Routes.home);
          });
        }
        // Usuário deslogado → envia para Login via rotas
        else {
          Future.microtask(() {
            Navigator.pushReplacementNamed(context, Routes.login);
          });
        }

        // Retorna uma tela vazia temporária
        return const SizedBox();
      },
    );
  }
}
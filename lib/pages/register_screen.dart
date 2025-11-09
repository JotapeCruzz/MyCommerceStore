import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/routes/routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: const Center(
        child: Text('Tela de Registro'),
      ),
    );
  }
}
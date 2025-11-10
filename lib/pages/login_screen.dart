import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:ecommerce_my_store/validation/validation.dart';
import 'package:ecommerce_my_store/widgets/login_field.dart';
import 'package:ecommerce_my_store/widgets/social_button.dart';
import 'package:ecommerce_my_store/widgets/submit_button.dart';
import 'package:ecommerce_my_store/widgets/support_button.dart';
import 'package:ecommerce_my_store/widgets/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onPressedLoginButton() {
    if (_formKey.currentState!.validate()) {
      showSnack(context: context, message: 'Login validado com sucesso!');
    } else {
      showSnack(context: context, message: 'Verifique os campos e tente novamente.', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
      ),
      floatingActionButton: const SupportButton(), // suporte fixo
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // logo
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: Image.asset(
                      'assets/images/e_logo.png',
                      width: 120,
                      height: 120,
                      errorBuilder: (_, __, ___) => const SizedBox(
                        width: 120,
                        height: 120,
                        child: Center(
                          child: Text(
                            'Logo',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // e-mail
                  LoginField(
                    labelText: 'E-mail',
                    controller: _emailController,
                    validator: validateEmail,
                  ),
                  SizedBox(height: 15),

                  // senha
                  LoginField(
                    labelText: 'Senha',
                    controller: _passwordController,
                    isPassword: true,
                    validator: validatePassword,
                  ),

                  SizedBox(height: 20),
                  SubmitButton(
                    buttonText: 'Entrar',
                    onPressed: _onPressedLoginButton,
                  ),

                  SizedBox(height: 10),

                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.register),
                    child: Text(
                      'Ainda não tem conta? Registre-se',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  Column(
                    children: [
                      SocialButton(
                        assetName: 'google_logo',
                        buttonText: 'Entrar com Google',
                        onPressed: () => showSnack(context: context, message: 'Login social em breve'),
                      ),
                      SizedBox(height: 15),
                      SocialButton(
                        assetName: 'meta_logo',
                        buttonText: 'Entrar com Meta',
                        horizontalPadding: 78,
                        onPressed: () => showSnack(context: context, message: 'Login social em breve'),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

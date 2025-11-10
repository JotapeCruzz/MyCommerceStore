import 'package:ecommerce_my_store/colors.dart';
import 'package:ecommerce_my_store/validation/validation.dart';
import 'package:ecommerce_my_store/widgets/login_field.dart';
import 'package:ecommerce_my_store/widgets/social_button.dart';
import 'package:ecommerce_my_store/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/routes/routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.kSecondaryColor,
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/images/e_logo.png',
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.white,
                      child: Text(
                        'Error loading image',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    width: 120,
                    height: 120,
                  ),
                ),
                SizedBox(height: 20),
                SocialButton(
                  assetName: 'google_logo',
                  buttonText: 'Login with Google',
                  onPressed: () {},
                ),
                SizedBox(height: 20),
                SocialButton(
                  assetName: 'meta_logo',
                  buttonText: 'Login with Meta',
                  horizontalPadding: 78,
                  onPressed: () {},
                ),
                SizedBox(height: 15),
                Text(
                  'or',
                  style: TextStyle(
                    fontSize: 17,
                    color: Palette.kSecondaryColor,
                  ),
                ),
                SizedBox(height: 15),
                LoginField(
                  labelText: 'E-mail',
                  controller: _emailController,
                  validator: (String? value) {
                    return validateEmail(value);
                  },
                ),
                SizedBox(height: 15),
                LoginField(
                  labelText: 'Senha',
                  controller: _passwordController,
                  isPassword: true,
                  validator: (String? value) {
                    return validatePassword(value);
                  },
                ),
                SizedBox(height: 20),
                SubmitButton(
                  buttonText: 'Entrar',
                  onPressed: () {
                    onPressedLoginButton();
                  },
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.register);
                  },
                  child: Text(
                    "Ainda não tem uma conta? Registre-se aqui!",
                    style: TextStyle(
                      fontSize: 15,
                      color: Palette.kSecondaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onPressedLoginButton() {
    if (_formKey.currentState!.validate()) {
      print("Validado com sucesso");
    } else {
      print("Erro na validação");
    }
  }
}

import 'package:ecommerce_my_store/colors.dart';
import 'package:ecommerce_my_store/validation/validation.dart';
import 'package:ecommerce_my_store/widgets/login_field.dart';
import 'package:ecommerce_my_store/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/routes/routes.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
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
                    width: 150,
                    height: 150,
                  ),
                ),
                SizedBox(height: 20),
                LoginField(
                  labelText: 'Insira um nome',
                  validator: (String? value) => validateNickname(value),
                ),
                SizedBox(height: 15),
                LoginField(
                  labelText: 'E-mail',
                  validator: (String? value) => validateEmail(value),
                ),
                SizedBox(height: 15),
                LoginField(
                  labelText: 'Senha',
                  isPassword: true,
                  validator: (String? value) => validatePassword(value),
                ),
                SizedBox(height: 15),
                LoginField(
                  labelText: 'Confirme a senha',
                  isPassword: true,
                  validator: (String? value) => validatePwdConfirmation(value),
                ),
                SizedBox(height: 20),
                SubmitButton(
                  buttonText: 'Registrar',
                  size: [360, 55],
                  onPressed: () {
                    onPressedRegisterButton();
                  },
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.login);
                  },
                  child: Text(
                    "Já tem uma conta? Faça login aqui!",
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

  onPressedRegisterButton() {
    if (_formKey.currentState!.validate()) {
      print("Validado com sucesso");
    } else {
      print("Erro na validação");
    }
  }
}

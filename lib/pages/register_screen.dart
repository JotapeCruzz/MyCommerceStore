import 'package:ecommerce_my_store/colors.dart';
import 'package:ecommerce_my_store/services/auth_service.dart';
import 'package:ecommerce_my_store/validation/validation.dart';
import 'package:ecommerce_my_store/widgets/login_field.dart';
import 'package:ecommerce_my_store/widgets/snackbar.dart';
import 'package:ecommerce_my_store/widgets/submit_button.dart';
import 'package:ecommerce_my_store/widgets/support_button.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/routes/routes.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pwdConfirmController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top:70, bottom: 20),
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
                  controller: _nameController,
                  validator: (String? value) => validateNickname(value),
                ),
                SizedBox(height: 15),
                LoginField(
                  labelText: 'E-mail',
                  controller: _emailController,
                  validator: (String? value) => validateEmail(value),
                ),
                SizedBox(height: 15),
                LoginField(
                  labelText: 'Senha',
                  isPassword: true,
                  controller: _passwordController,
                  validator: (String? value) => validatePassword(value),
                ),
                SizedBox(height: 15),
                LoginField(
                  labelText: 'Confirme a senha',
                  isPassword: true,
                  controller: _pwdConfirmController,
                  validator:(String? value) => validatePassword(value),
                ),
                SizedBox(height: 20),
                SubmitButton(
                  buttonText: 'Registrar',
                  size: [315, 55],
                  onPressed: () {
                    onPressedRegisterButton(context);
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

  void onPressedRegisterButton(BuildContext context) {
    String pwd = _passwordController.text;
    String email = _emailController.text;
    String name = _nameController.text;
    if (_formKey.currentState!.validate()) {
      _authService.userRegister(email: email, password: pwd, name: name).then((
        String? error,
      ) {
        if (error != null) {
          print("Erro no registro: $error");
        } else {
          _authService.userLogin(email: email, password: pwd).then((String? erro){
            if (erro != null) {
            showSnack(context: context, message: erro, isError: false);
          } else {
            Navigator.pushNamed(context, Routes.home);
          }
          });
        }
      });
    } else {
      print("Erro na validação");
    }
  }
}

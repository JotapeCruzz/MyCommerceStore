import 'package:ecommerce_my_store/widgets/login_field.dart';
import 'package:ecommerce_my_store/widgets/submit_button.dart';
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/e_logo.png',
                  errorBuilder: (context, error, stackTrace) 
                  => Container(
                    color: Colors.white, 
                    child: Text('Error loading image', style: TextStyle(color: Colors.red)),
                  ),
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 20),
              LoginField(labelText: 'Insert your username'),
              SizedBox(height: 15),
              LoginField(labelText: 'Email'),
              SizedBox(height: 15),
              LoginField(labelText: 'Password', isPassword: true),
              SizedBox(height: 15),
              LoginField(labelText: 'Confirm Password', isPassword: true),
              SizedBox(height: 20),
              SubmitButton(buttonText: 'Register', size: [360, 55], onPressed: () {},),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:ecommerce_my_store/colors.dart';
import 'package:ecommerce_my_store/widgets/login_field.dart';
import 'package:ecommerce_my_store/widgets/social_button.dart';
import 'package:ecommerce_my_store/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/routes/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.kSecondaryColor,
        title: Text('Login'),
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
              SocialButton(
                assetName: 'google_logo',
                buttonText: 'Login with Google',
                onPressed: () {},
              ),
              SizedBox(height: 20),
              SocialButton(
                assetName: 'meta_logo', 
                buttonText: 'Login with Meta', 
                horizontalPadding: 126,
                onPressed: () {},
              ),
              SizedBox(height: 15),
              Text('or', style: TextStyle(fontSize: 17, color: Palette.kSecondaryColor),),
              SizedBox(height: 15),
              LoginField(labelText: 'Email', boxWidth: 410,),
              SizedBox(height: 15),
              LoginField(labelText: 'Password', isPassword: true, boxWidth: 410,),
              SizedBox(height: 20),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SubmitButton(buttonText: 'Login', size: [200, 55],),
                  SubmitButton(buttonText: 'Register', size: [200, 55], onPressed: () {
                    Navigator.pushNamed(context, Routes.register);
                  },),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:ecommerce_my_store/colors.dart';
import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final String? Function(String?)? validator;
  final double boxWidth;
  final String labelText;
  final bool isPassword;
  final TextEditingController? controller;

  const LoginField({
    super.key,
    required this.labelText,
    this.isPassword = false,
    this.boxWidth = 310,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: boxWidth),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Palette.kSecondaryColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.borderColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.borderColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.gradient2, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.gradient2, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          hintStyle: TextStyle(color: Palette.kSecondaryColor),
          hintText: labelText,
        ),
        obscureText: isPassword,
        validator: validator,
      ),
    );
  }
}

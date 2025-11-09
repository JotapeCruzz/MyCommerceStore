import 'package:ecommerce_my_store/colors.dart';
import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final double boxWidth;
  final String labelText;
  final bool isPassword;

  const LoginField({
    super.key,
    required this.labelText,
    this.isPassword = false,
    this.boxWidth = 350
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: boxWidth),
      child: TextFormField(
        style: TextStyle(color: Palette.kSecondaryColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(27),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.borderColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.gradient2, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          hintStyle: TextStyle(color: Palette.kSecondaryColor),
          hintText: labelText,
        ),
        obscureText: isPassword,
      ),
    );
  }
}

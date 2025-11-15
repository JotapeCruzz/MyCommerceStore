import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  final String assetName;
  final String buttonText;
  final VoidCallback onPressed;
  final double horizontalPadding;
  
  const SocialButton({
    super.key,
    required this.assetName,
    required this.buttonText,
    required this.onPressed,
    this.horizontalPadding = 70,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        'assets/svgs/${assetName}.svg',
        width: 25,
        height: 25,
      ),
      label: Text(buttonText,
      style: TextStyle(
        color: Palette.whiteColor, 
        fontSize: 17
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Palette.kSecondaryColor,
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: horizontalPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Palette.borderColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}

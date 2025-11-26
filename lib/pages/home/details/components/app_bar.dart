import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/widgets/colors.dart';
import 'package:ecommerce_my_store/routes/routes.dart';

AppBar buildAppBar(BuildContext context) {
    return AppBar(
          backgroundColor: Palette.appBarColor,
          elevation: 0,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            icon: Icon(Icons.arrow_back_rounded, color: Colors.white,),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.cart);
              },
              icon: Icon(Icons.shopping_cart, color: Colors.white,),
            ),
            SizedBox(width: 10),
          ],
        );
  }
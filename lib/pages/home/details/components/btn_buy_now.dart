import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/product_model.dart';
import '../../../../widgets/colors.dart';

class BtnBuyNow extends StatelessWidget {
  final ProdutoModel product;
  const BtnBuyNow({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.appBarColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            padding: EdgeInsets.symmetric(horizontal: 50),
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.pagamento);
          },
          child: Text(
            "Comprar agora".toUpperCase(),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

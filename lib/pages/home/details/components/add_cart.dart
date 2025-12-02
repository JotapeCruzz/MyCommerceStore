import 'package:ecommerce_my_store/data/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/colors.dart';

class AddToCart extends StatelessWidget {
  final ProdutoModel product;
  const AddToCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      height: 50,
      width: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Palette.appBarColor),
      ),
      child: IconButton(
        onPressed: () {
          // Adicionar ao carrinho
        },
        icon: Icon(Icons.add_shopping_cart_rounded, color: Palette.appBarColor),
      ),
    );
  }
}

import 'package:ecommerce_my_store/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_my_store/providers/cart_provider.dart';

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
          // Adicionar ao carrinho com Provider
          final cart = Provider.of<CartProvider>(context, listen: false);
          cart.addItem(product.title, product.price, product.img.isNotEmpty ? product.img : '');
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Produto adicionado ao carrinho!')),
          );
        },
        icon: Icon(Icons.add_shopping_cart_rounded, color: Palette.appBarColor),
      ),
    );
  }
}

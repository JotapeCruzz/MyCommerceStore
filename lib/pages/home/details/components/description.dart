import 'package:flutter/material.dart';

import '../../../../data/models/product_model.dart';

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.product,
  });

  final ProdutoModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        product.description,
        style: TextStyle(height: 1.5),
      ),
    );
  }
}

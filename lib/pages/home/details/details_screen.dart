import 'package:ecommerce_my_store/data/http/http_client.dart';
import 'package:ecommerce_my_store/data/models/product_model.dart';
import 'package:ecommerce_my_store/data/repositories/product_repository.dart';
import 'package:ecommerce_my_store/pages/home/details/components/app_bar.dart';
import 'package:ecommerce_my_store/pages/home/details/components/body.dart';
import 'package:ecommerce_my_store/pages/stores/product_store.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:ecommerce_my_store/widgets/colors.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final int productId;
  final ProdutoModel product;
  const ProductDetails({super.key, required this.productId, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.appBarColor,
      appBar: buildAppBar(context),
      body: Body(productId: productId, product: product,),
    );
  }
}

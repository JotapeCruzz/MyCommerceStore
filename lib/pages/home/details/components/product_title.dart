import 'package:ecommerce_my_store/data/models/product_model.dart';
import 'package:ecommerce_my_store/widgets/colors.dart';
import 'package:flutter/material.dart';

class ProdcutTitleWithImage extends StatelessWidget {
  const ProdcutTitleWithImage({
    super.key,
    required this.product,
  });

  final ProdutoModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            product.category.toUpperCase(),
            style: TextStyle(color: Palette.whiteColor),
          ),
          Text(
            product.title,
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Preço\n", style: TextStyle(color: Palette.whiteColor)),
                    TextSpan(
                      text: "R\$${product.price.toStringAsFixed(2)}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                
                child: Image.network(product.img, width: 210, height: 210,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
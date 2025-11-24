import 'package:ecommerce_my_store/data/http/http_client.dart';
import 'package:ecommerce_my_store/data/models/product_model.dart';
import 'package:ecommerce_my_store/data/repositories/product_repository.dart';
import 'package:ecommerce_my_store/pages/stores/product_store.dart';
import 'package:ecommerce_my_store/widgets/colors.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  final int productId;
  const Body({super.key, required this.productId});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ProductStore store = ProductStore(
    repository: ProductRepository(client: HttpClient()),
  );

  @override
  void initState() {
    super.initState();
    store.fetchProductsbyId(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: Listenable.merge([
        store.isLoading,
        store.erro,
        store.state,
        store.selectedProduct,
      ]),
      builder: (context, child) {
        if (store.isLoading.value) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (store.erro.value.isNotEmpty) {
          return Scaffold(body: Center(child: Text(store.erro.value)));
        }

        final product = store.selectedProduct.value;

        if (product == null) {
          return Scaffold(body: Center(child: Text("Produto não encontrado")));
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.3),
                      height: 500,
                      decoration: BoxDecoration(
                        color: Palette.whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Categoria - Teste",
                            style: TextStyle(color: Palette.whiteColor),
                          ),
                          Text(
                            product.title,
                            style: TextStyle(color: Palette.whiteColor, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: <Widget>[
                              RichText(text: TextSpan(children: [
                                TextSpan(text: "Preço"),
                                TextSpan(text: "R\$${product.price}"),
                              ],
                              ),),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
                Text(
                  product.title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(product.description),
                SizedBox(height: 20),
                Text(
                  "R\$ ${product.price}",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

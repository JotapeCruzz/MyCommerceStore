import 'package:ecommerce_my_store/data/http/http_client.dart';
import 'package:ecommerce_my_store/data/models/product_model.dart';
import 'package:ecommerce_my_store/data/repositories/product_repository.dart';
import 'package:ecommerce_my_store/pages/home/details/components/product_title.dart';
import 'package:ecommerce_my_store/pages/stores/product_store.dart';
import 'package:ecommerce_my_store/providers/cart_provider.dart';
import 'package:ecommerce_my_store/widgets/colors.dart';
import 'package:ecommerce_my_store/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/favorites_provider.dart';
import '../../../../routes/routes.dart';
import 'add_cart.dart';
import 'btn_buy_now.dart';
import 'cart_counter.dart';
import 'color_and_size.dart';
import 'description.dart';

class Body extends StatefulWidget {
  final ProdutoModel product;
  final int productId;
  const Body({super.key, required this.productId, required this.product});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final user = FirebaseAuth.instance.currentUser!;
  final ProductStore store = ProductStore(
    repository: ProductRepository(client: HttpClient()),
  );
  int selectedQuantity = 1;

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
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: size.height,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.3),
                      padding: EdgeInsets.only(
                        top: size.height * 0.12,
                        left: 20,
                        right: 20,
                      ),
                      // height: 500,
                      decoration: BoxDecoration(
                        color: Palette.whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          ColorAndSize(),
                          SizedBox(height: 20 / 2),
                          Description(product: product),
                          SizedBox(height: 20 / 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CartCounter(
                                onQuantityChanged: (quantity) {
                                  setState(() => selectedQuantity = quantity);
                                },
                              ),
                              //Botão de Favoritos --- Implementar funcionalidade para a tela
                              GestureDetector(
                                onTap: () {
                                  final fav = Provider.of<FavoritesProvider>(context, listen: false);
                                  fav.addFavorite(
                                    product.id.toString(),
                                    product.title,
                                    product.price,
                                    product.img.isNotEmpty ? product.img : '',

                                  );
                                  showSnack(
                                    context: context,
                                    message: 'Produto adicionado aos favoritos!',
                                  );
                                },
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFF6464),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.favorite_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20 / 2),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              children: <Widget>[
                                AddToCart(
                                  product: product,
                                  quantity: selectedQuantity,
                                ),
                                BtnBuyNow(product: product),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ProdcutTitleWithImage(product: product),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

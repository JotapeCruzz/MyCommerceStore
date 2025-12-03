import 'package:ecommerce_my_store/data/models/product_model.dart';
import 'package:ecommerce_my_store/pages/stores/product_store.dart';
import 'package:ecommerce_my_store/data/http/http_client.dart';
import 'package:ecommerce_my_store/data/repositories/product_repository.dart';
import 'package:ecommerce_my_store/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_my_store/providers/cart_provider.dart';

class ProductsView extends StatefulWidget {
  final Function(ProdutoModel product) press;
  const ProductsView({super.key, required this.press});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final ProductStore store = ProductStore(
    repository: ProductRepository(client: HttpClient()),
  );

  @override
  void initState() {
    super.initState();
    store.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([store.isLoading, store.erro, store.state]),
      builder: (context, child) {
        if (store.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (store.erro.value.isNotEmpty) {
          return Center(
            child: Text(
              store.erro.value,
              style: TextStyle(
                color: Palette.blackColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        if (store.state.value.isEmpty) {
          return const Center(
            child: Text(
              'Nenhum item na lista',
              style: TextStyle(
                color: Palette.blackColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: store.state.value.length,
              itemBuilder: (_, index) {
                final item = store.state.value[index];
                return GestureDetector(
                  onTap: () => widget.press(item),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Palette.appBarColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:  ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(
                              item.img,
                              width: 200,
                              height: 200,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          item.title,
                          style: TextStyle(color: Palette.blackColor),
                          maxLines: 1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'R\$ ${item.price.toStringAsFixed(2)}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            tooltip: 'Adicionar ao carrinho',
                            icon: const Icon(Icons.add_shopping_cart_outlined),
                            onPressed: () {
                              final cart = Provider.of<CartProvider>(context, listen: false);
                              cart.addItem(item.title, item.price, item.img.isNotEmpty ? item.img : '');
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Produto adicionado ao carrinho')),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

import 'package:ecommerce_my_store/data/http/http_client.dart';
import 'package:ecommerce_my_store/data/repositories/product_repository.dart';
import 'package:ecommerce_my_store/pages/stores/product_store.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final int productId;
  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
          appBar: AppBar(title: Text(product.title)),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.network(product.img, height: 250)),
                SizedBox(height: 20),
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

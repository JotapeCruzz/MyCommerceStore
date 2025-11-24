import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_my_store/data/http/http_client.dart';
import 'package:ecommerce_my_store/data/repositories/product_repository.dart';
import 'package:ecommerce_my_store/pages/home/components/categories.dart';
import 'package:ecommerce_my_store/pages/home/components/products_view.dart';
import 'package:ecommerce_my_store/pages/home/details/details_screen.dart';
import 'package:ecommerce_my_store/pages/stores/product_store.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_my_store/services/auth_service.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:ecommerce_my_store/widgets/colors.dart';
import 'package:ecommerce_my_store/widgets/custom_drawer.dart';
import 'package:ecommerce_my_store/widgets/bottom_navbar.dart';
import 'package:google_identity_services_web/id.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 5),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.cart);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.support);
              },
              icon: Icon(Icons.forum_rounded),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(user: FirebaseAuth.instance.currentUser!),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Text(
              "Produtos",
              style: TextStyle(
                color: Palette.gradient3,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Categories(),
          Expanded(
            child: ProductsView(
              press: (product) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetails(productId: product.id),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.pushReplacementNamed(context, Routes.favorites);
              break;
            case 2:
              Navigator.pushReplacementNamed(context, Routes.perfilPage);
              break;
          }
        },
      ),
    );
  }
}

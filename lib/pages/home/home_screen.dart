import 'package:ecommerce_my_store/data/http/http_client.dart';
import 'package:ecommerce_my_store/data/repositories/product_repository.dart';
import 'package:ecommerce_my_store/pages/home/components/categories.dart';
import 'package:ecommerce_my_store/pages/stores/product_store.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_my_store/services/auth_service.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:ecommerce_my_store/widgets/colors.dart';
import 'package:ecommerce_my_store/widgets/custom_drawer.dart';
import 'package:ecommerce_my_store/widgets/bottom_navbar.dart';

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
          Expanded(child: ProductsView(store: store),
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

class ProductsView extends StatelessWidget {
  const ProductsView({super.key, required this.store});

  final ProductStore store;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([store.isLoading, store.erro, store.state,]),
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
                crossAxisSpacing: 20
              ),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: store.state.value.length,
              itemBuilder: (_, index) {
                final item = store.state.value[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      height: 180,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.network(item.img,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        item.title,
                        style: TextStyle(color: Palette.blackColor),
                        maxLines: 2,
                      ),
                    ),
                    Text(
                      'R\$ ${item.price}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}

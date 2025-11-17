import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_my_store/services/auth_service.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:ecommerce_my_store/colors.dart';
import 'package:ecommerce_my_store/widgets/custom_drawer.dart';
import 'package:ecommerce_my_store/widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< Updated upstream
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
      body: SingleChildScrollView(),
      // bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
=======
        backgroundColor: Colors.blue,
        title: const Text("Home Screen"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.login);
                  },
                  child: const Text("Login"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.register);
                  },
                  child: const Text("Register"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.cart);
                  },
                  child: const Text("Carrinho"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.formPerfil);
                  },
                  child: const Text("Perfil"),
                ),
                ),
            ],
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // botão de suporte
          FloatingActionButton.extended(
            heroTag: 'fab-support', // heroTag diferente pra não conflitar
            backgroundColor: Colors.blue,
            icon: const Icon(Icons.support_agent),
            label: const Text('Suporte'),
            onPressed: () => Navigator.pushNamed(context, Routes.support),
          ),
          const SizedBox(height: 12),

          // botão de cadastro de produto
          newProduct(),
        ],
      ),
    );
  }
}

class newProduct extends StatelessWidget {
  const newProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: 'fab-product-register', //Sem conflito de heroTag
      backgroundColor: Colors.blue,
      icon: const Icon(Icons.add),
      label: const Text('Cadastrar produto (APENAS PARA VISUALIZAÇÃO!!!)'),
      onPressed: () => Navigator.pushNamed(context, Routes.productRegister),
>>>>>>> Stashed changes
    );
  }
}


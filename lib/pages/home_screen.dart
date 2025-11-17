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
    );
  }
}

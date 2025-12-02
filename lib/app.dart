import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_my_store/providers/cart_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:ecommerce_my_store/widgets/colors.dart';
import 'package:ecommerce_my_store/pages/home/home_screen.dart';
import 'package:ecommerce_my_store/pages/logins/login_screen.dart';


// Define a classe principal do aplicativo, que é um widget sem estado (StatelessWidget)
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Carrega os itens do carrinho persistidos logo após o primeiro frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        Provider.of<CartProvider>(context, listen: false).loadPersistedCart();
      } catch (e) {
        // ignore: avoid_print
        print('Erro ao carregar carrinho persistente: $e');
      }
    });
    // Retorna o widget principal do app: MaterialApp.
    return MaterialApp(
      title: 'MyStore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Palette.gradient3,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      routes: Routes.routeMaps,
      initialRoute: Routes.rooter,
    );
  }
}


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:ecommerce_my_store/colors.dart';
import 'package:ecommerce_my_store/pages/home_screen.dart';
import 'package:ecommerce_my_store/pages/login_screen.dart';


// Define a classe principal do aplicativo, que é um widget sem estado (StatelessWidget)
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Retorna o widget principal do app: MaterialApp.
    return MaterialApp(
      title: 'MyStore',
      debugShowCheckedModeBanner: false,
      routes: Routes.routeMaps,
      initialRoute: Routes.rooter,
    );
  }
}


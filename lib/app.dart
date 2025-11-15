import 'package:ecommerce_my_store/colors.dart';

// Importa o arquivo de rotas, onde estão definidos os caminhos (routes)
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:flutter/material.dart';

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
      initialRoute: Routes.login,
    );
  }
}

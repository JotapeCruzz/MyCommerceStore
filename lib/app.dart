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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 22, 63, 151),
      ),
       // Define o mapa de rotas (telas) do aplicativo
      routes: Routes.routeMaps,
      // Define a rota inicial, ou seja, a primeira tela exibida ao abrir o app
      initialRoute: Routes.home,
    );
  }
}

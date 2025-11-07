import 'package:flutter/material.dart';

// Importa a tela HomeScreen, que será usada como uma das rotas do app.
import 'package:ecommerce_my_store/pages/home.dart';

// Classe responsável por centralizar e gerenciar todas as rotas do aplicativo.
// Isso ajuda a manter a navegação organizada e fácil de manter.
class Routes {
  static const String home = '/';

  // Mapa de rotas do aplicativo: associa um nome de rota (String)
  // Esse mapa é usado dentro do MaterialApp (em app.dart).
  static final Map<String, WidgetBuilder> routeMaps = {
    home: (context) => HomeScreen(),
  };
}

import 'package:flutter/material.dart';

// Importa a tela HomeScreen, que será usada como uma das rotas do app.
import 'package:ecommerce_my_store/pages/home_screen.dart';
import 'package:ecommerce_my_store/pages/login_screen.dart';
import 'package:ecommerce_my_store/pages/register_screen.dart';
import 'package:ecommerce_my_store/pages/support_screen.dart';
import 'package:ecommerce_my_store/pages/product_register.dart';


// Classe responsável por centralizar e gerenciar todas as rotas do aplicativo.
// Isso ajuda a manter a navegação organizada e fácil de manter.
class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String support = '/support'; 
  static const String productRegister = '/productRegister'; 


  // Mapa de rotas do aplicativo: associa um nome de rota (String)
  // Esse mapa é usado dentro do MaterialApp (em app.dart).
  static final Map<String, WidgetBuilder> routeMaps = {
    home: (context) => HomeScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    support: (context) => const SupportScreen(),
    productRegister: (context) => const ProductRegisterScreen(),
  };
}

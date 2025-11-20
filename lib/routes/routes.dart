import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';

// Importa a tela HomeScreen, que será usada como uma das rotas do app.
import 'package:ecommerce_my_store/pages/favorites_screen.dart';
import 'package:ecommerce_my_store/pages/home_screen.dart';
import 'package:ecommerce_my_store/pages/login_screen.dart';
import 'package:ecommerce_my_store/pages/register_screen.dart';
import 'package:ecommerce_my_store/pages/support_screen.dart';
import 'package:ecommerce_my_store/pages/product_register.dart';
import 'package:ecommerce_my_store/pages/kart_screen.dart';
import 'package:ecommerce_my_store/pages/payment_screen.dart';
import 'package:ecommerce_my_store/pages/faq_screen.dart';
import 'rooter.dart';
import 'package:ecommerce_my_store/pages/editpayment_screen.dart';
import 'package:ecommerce_my_store/pages/editadress_screen.dart';
import 'package:ecommerce_my_store/pages/editprofile_screen.dart';  
import 'package:ecommerce_my_store/pages/policyprivace_screen.dart';
import 'package:ecommerce_my_store/pages/profile_screen.dart';
import 'package:ecommerce_my_store/pages/listcard_screen.dart';
import 'package:ecommerce_my_store/pages/listadress_screen.dart';




// Classe responsável por centralizar e gerenciar todas as rotas do aplicativo.
// Isso ajuda a manter a navegação organizada e fácil de manter.
class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String support = '/support';
  static const String productRegister = '/productRegister';
  static const String cart = '/cart';
  static const String pagamento = '/pagamento';
  static const String faq = '/FAQ';
  static const String favorites = '/favorites';
  static const String rooter = '/auth';
  static const String editProfile = '/editProfile'; 
  static const String editPayment = '/editPayment'; 
  static const String policyPrivacy = '/policyPrivacy'; 
  static const String editAdress = '/editAdress';
  static const String perfilPage = '/perfilPage';
  static const String policyPrivace = '/policyPrivace';
  static const String listCard = '/listCard';
  static const String listAdress = '/listAdress';
  

  

  // Mapa de rotas do aplicativo: associa um nome de rota (String)
  // Esse mapa é usado dentro do MaterialApp (em app.dart).
  static final Map<String, WidgetBuilder> routeMaps = {
    home: (context) => HomeScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    support: (context) => const SupportScreen(),
    productRegister: (context) => const ProductRegisterScreen(),
    cart: (context) => const CartScreen(),
    pagamento: (context) => const PagamentoScreen(),
    faq: (context) => const QuestionsScreen(),
    favorites: (context) => const FavoritosPage(),
    rooter: (context) =>const AuthGate(),
    editPayment: (context) => const EditarPagamentoPage(),
    editAdress: (context) => const EditarEnderecoPage(),
    editProfile: (context) => const EditarPerfilPage(),
    policyPrivacy: (context) => const PrivacyPolicyScreen(),
    perfilPage: (context) => PerfilPage(user: FirebaseAuth.instance.currentUser!),
    listCard: (context) => const ListaCartoesPage(),
    listAdress: (context) => const ListaEnderecosPage(),
  };
}

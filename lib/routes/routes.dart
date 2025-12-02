
import 'package:ecommerce_my_store/pages/home/components/products_view.dart';
import 'package:ecommerce_my_store/pages/home/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';

// Importa a tela HomeScreen, que será usada como uma das rotas do app.
import 'package:ecommerce_my_store/pages/wishlist/favorites_screen.dart';
import 'package:ecommerce_my_store/pages/home/home_screen.dart';
import 'package:ecommerce_my_store/pages/logins/login_screen.dart';
import 'package:ecommerce_my_store/pages/logins/register_screen.dart';
import 'package:ecommerce_my_store/pages/others/support_screen.dart';
import 'package:ecommerce_my_store/pages/stores/product_register.dart';
import 'package:ecommerce_my_store/pages/wishlist/kart_screen.dart';
import 'package:ecommerce_my_store/pages/payments/payment_screen.dart';
import 'package:ecommerce_my_store/pages/others/faq_screen.dart';
import 'rooter.dart';
import 'package:ecommerce_my_store/pages/payments/editpayment_screen.dart';
import 'package:ecommerce_my_store/pages/profile/editadress_screen.dart';
import 'package:ecommerce_my_store/pages/profile/editprofile_screen.dart';
import 'package:ecommerce_my_store/pages/others/policyprivace_screen.dart';
import 'package:ecommerce_my_store/pages/profile/profile_screen.dart';
import 'package:ecommerce_my_store/pages/payments/listcard_screen.dart';
import 'package:ecommerce_my_store/pages/profile/listadress_screen.dart';

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
  static const String productDetails = '/product-details';
  

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
    //favorites: (context) => const FavoritosPage(),
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

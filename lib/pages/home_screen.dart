import 'package:ecommerce_my_store/colors.dart';
import 'package:ecommerce_my_store/services/auth_service.dart';
import 'package:ecommerce_my_store/widgets/new_product.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/routes/routes.dart';

// Essa é a tela inicial do app (HomeScreen)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Classe de estado da tela — controla o que aparece e o que muda nela
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Scaffold é a estrutura base da tela (AppBar, body, botões flutuantes, etc.)
    return Scaffold(
      backgroundColor: Palette.whiteColor,
      // O corpo da tela (onde ficam os botões principais)
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center, // centraliza na horizontal
        crossAxisAlignment: CrossAxisAlignment.center, // centraliza na vertical
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center, // centraliza os botões
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // Logo da empresa 
              Padding(
                padding: const EdgeInsets.only(bottom: 30), // espaço abaixo da logo
                child: Image.asset(
                  'assets/images/e_logo.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain, // garante que não deforme
                ),
              ),

              // Botão que leva para a tela de Login
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.login);
                  },
                  child: const Text("Login"),
                ),
              ),

              // Botão que leva para a tela de Registro
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.register);
                  },
                  child: const Text("Register"),
                ),
              ),

              // Botão que leva para a tela do Carrinho
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
                    setState(() {
                      AuthService().userLogout();
                      Navigator.pushNamed(context, Routes.login);
                    });
                  },
                  child: const Text("Logout"),
                ),
              ),
            ],
          ),
        ],
      ),

      // Define onde o botão flutuante vai ficar (no canto inferior direito)
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // Aqui eu coloco vários botões flutuantes (um em cima do outro)
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min, // só ocupa o tamanho necessário
        crossAxisAlignment: CrossAxisAlignment.end, // alinha na direita
        children: [
          // Botão flutuante de suporte
          FloatingActionButton.extended(
            heroTag: 'fab-support', // tag única pra evitar erro de duplicação
            backgroundColor: Colors.blue, // cor do botão
            icon: const Icon(Icons.support_agent), // ícone do botão
            label: const Text('Suporte'), // texto do botão
            onPressed: () =>
                Navigator.pushNamed(context, Routes.support), // vai pra tela de suporte
          ),
          const SizedBox(height: 12), // espaço entre os dois botões

          // Chamo o widget que cria o botão de cadastro de produto
          NewProduct()
        ],
      ),
    );
  }
}
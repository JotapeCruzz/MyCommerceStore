import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/routes/routes.dart';

// Como é um StatefulWidget, ele pode mudar de estado durante a execução do app.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Classe de estado que controla o comportamento e a interface da HomeScreen.
// Aqui ficam as variáveis e métodos que podem mudar o conteúdo da tela.
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Scaffold é uma estrutura básica de layout do Material Design.
    // Ele fornece áreas padrão como AppBar, Body, FloatingActionButton, etc.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, 
        title: Text("Home Screen")
      ),
    );
  }
}

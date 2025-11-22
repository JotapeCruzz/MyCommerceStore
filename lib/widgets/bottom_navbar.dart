import 'package:ecommerce_my_store/colors.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/routes/routes.dart';

// Widget reutilizável da barra de navegação inferior
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap; // indica qual ícone está selecionado

  const CustomBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // ícones fixos
      currentIndex: currentIndex, // índice ativo
      selectedItemColor: Palette.gradient1, // cor do ícone selecionado
      unselectedItemColor: Colors.grey, // cor dos ícones inativos
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favoritos',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.shopping_cart_checkout_rounded), 
        //   label: 'Carrinho'
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded), 
          label: 'Eu'
        ),
      ],
    );
  }
}

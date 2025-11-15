import 'package:flutter/material.dart';
import 'package:ecommerce_my_store/routes/routes.dart';

// Widget reutilizável da barra de navegação inferior
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex; // indica qual ícone está selecionado

  const CustomBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // ícones fixos
      currentIndex: currentIndex, // índice ativo
      selectedItemColor: Colors.blue, // cor do ícone selecionado
      unselectedItemColor: Colors.grey, // cor dos ícones inativos
      onTap: (index) {
        // define pra onde cada botão vai navegar
        switch (index) {
          case 0:
            Navigator.pushNamed(context, Routes.home);
            break;
          case 1:
            Navigator.pushNamed(context, Routes.favorites);
            break;
          case 2:
            Navigator.pushNamed(context, Routes.login);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favoritos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded), 
          label: 'Eu'
        ),
      ],
    );
  }
}

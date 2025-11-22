import 'package:ecommerce_my_store/widgets/colors.dart';
import 'package:ecommerce_my_store/routes/routes.dart';
import 'package:ecommerce_my_store/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

class FavoritosPage extends StatelessWidget {
  const FavoritosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        backgroundColor: Palette.appBarColor,
        title: Text('Meus Favoritos'),
        centerTitle: true,
      ),
      body: const FavoritosContent(),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, Routes.home);
              break;
            case 1:
              break;
            case 2:
              Navigator.pushReplacementNamed(context, Routes.perfilPage);
              break;
          }
        },
      ),
    );
  }
}

class FavoritosContent extends StatelessWidget {
  const FavoritosContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista simulada de produtos favoritos
    final List<Map<String, String>> favoritos = [
      {
        'nome': 'Tênis Esportivo',
        'imagem': 'https://cdn-icons-png.flaticon.com/512/825/825539.png',
        'preco': 'R\$ 299,90',
      },
      {
        'nome': 'Fone de Ouvido Bluetooth',
        'imagem': 'https://cdn-icons-png.flaticon.com/512/3161/3161406.png',
        'preco': 'R\$ 199,00',
      },
      {
        'nome': 'Relógio Digital',
        'imagem': 'https://cdn-icons-png.flaticon.com/512/287/287221.png',
        'preco': 'R\$ 149,90',
      },
    ];

    return favoritos.isEmpty
        ? const Center(
            child: Text(
              'Você ainda não adicionou produtos aos favoritos.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            itemCount: favoritos.length,
            itemBuilder: (context, index) {
              final item = favoritos[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ListTile(
                  leading: Image.network(
                    item['imagem']!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item['nome']!),
                  subtitle: Text(item['preco']!),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      // Aqui você poderia implementar a remoção real do produto
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${item['nome']} removido dos favoritos.',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
  }
}

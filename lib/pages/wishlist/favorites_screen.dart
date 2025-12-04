
import 'package:ecommerce_my_store/widgets/bottom_navbar.dart';
import 'package:ecommerce_my_store/widgets/custom_drawer.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/favorites_provider.dart';
import '../../routes/routes.dart';


import 'package:firebase_auth/firebase_auth.dart';


import 'package:ecommerce_my_store/widgets/colors.dart';


/// ===============================================================
///                     TELA DO CARRINHO
/// ===============================================================
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider escutando mudanças do carrinho.
    // Sempre que cart for alterado, a tela reconstruirá automaticamente.
    //
    final fav = context.watch<FavoritesProvider>();

    return Scaffold(
      backgroundColor: Colors.white,

      /// ===================== APPBAR ===========================
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            // Volta para Home substituindo a rota atual.
            // pushReplacement evita voltar ao carrinho pressionando "voltar".
            Navigator.popAndPushNamed(context, Routes.home);
          },
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
        ),
        backgroundColor: Palette.appBarColor,
        title: const Text(
          'Favoritos',
          style: TextStyle(
            color: Palette.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),

      /// ===================== BODY ===========================
      body: Column(
        children: [
          /// LISTA DOS ITENS DO CARRINHO
          Expanded(
            child: fav.items.isEmpty
                ? const Center(
                    child: Text('Sua lista de favoritos está vazia'),
                  )

                /// LISTA DINÂMICA
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: fav.items.length,
                    itemBuilder: (context, i) {
                      final item = fav.items[i];

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          /// IMAGEM DO PRODUTO
                          leading: item.imageUrl.isNotEmpty
                              ? Image.network(
                                  item.imageUrl,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.contain,
                                )
                              : const SizedBox(width: 56, height: 56),

                          /// TÍTULO DO PRODUTO
                          title: Text(item.title),

                          /// PREÇO DO PRODUTO
                          subtitle: Text(
                            'R\$ ${item.price.toStringAsFixed(2)}',
                          ),

                          /// AÇÕES DO ITEM
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              /// REMOVER ITEM
                              IconButton(
                                icon: const Icon(Icons.delete_outline_rounded),
                                onPressed: () {
                                  context.read<FavoritesProvider>().removeFavorite(
                                        item.id,
                                      );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),     
          const SizedBox(height: 12),
        ],
      ),
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

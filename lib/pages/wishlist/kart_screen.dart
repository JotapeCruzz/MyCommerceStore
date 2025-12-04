// Widgets personalizados do projeto
// TIP: Em provas, é comum pedirem para criar ou modificar widgets próprios
import 'package:ecommerce_my_store/widgets/bottom_navbar.dart';
import 'package:ecommerce_my_store/widgets/custom_drawer.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider responsável pelo estado do carrinho
// TIP: Saber usar Provider, ChangeNotifier e ValueNotifier é parte do tópico 4.2 Estado e Reatividade.
import '../../providers/cart_provider.dart';

// Arquivo contendo as rotas nomeadas do app
// TIP: Navegação com rotas nomeadas é parte do tópico 4.1.
import '../../routes/routes.dart';

// Autenticação (não utilizada aqui, mas importada caso precise)
import 'package:firebase_auth/firebase_auth.dart';

// Paleta de cores personalizada
import 'package:ecommerce_my_store/widgets/colors.dart';


/// ===============================================================
///                     TELA DO CARRINHO
/// ===============================================================
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider escutando mudanças do carrinho.
    // Sempre que cart for alterado, a tela reconstruirá automaticamente.
    //
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: Colors.white,

      /// ===================== APPBAR ===========================
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            // Volta para Home substituindo a rota atual.
            // pushReplacement evita voltar ao carrinho pressionando "voltar".
            Navigator.pushReplacementNamed(context, Routes.home);
          },
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
        ),
        backgroundColor: Palette.appBarColor,
        title: const Text(
          'Carrinho',
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
            child: cart.items.isEmpty
                ? const Center(
                    child: Text('Seu carrinho está vazio'),
                  )

                /// LISTA DINÂMICA
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: cart.items.length,
                    itemBuilder: (context, i) {
                      final item = cart.items[i];

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          /// IMAGEM DO PRODUTO
                          leading: item.imageUrl.isNotEmpty
                              ? Image.network(
                                  item.imageUrl,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox(width: 56, height: 56),

                          /// TÍTULO DO PRODUTO
                          ///
                          /// DICA: ele pode pedir para adicionar
                          /// navegação ao tocar no título → página de detalhes.
                          title: Text(item.title),

                          /// PREÇO DO PRODUTO
                          subtitle: Text(
                            'R\$ ${item.price.toStringAsFixed(2)}',
                          ),

                          /// AÇÕES DO ITEM
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              /// BOTÃO DIMINUIR QUANTIDADE
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  /// Aqui ocorre atualização de estado
                                  /// usando o Provider.
                                  ///
                                  /// DICA (4.2): Sempre estudar updateQuantity
                                  final newQty = item.quantity - 1;
                                  context.read<CartProvider>().updateQuantity(
                                        item.id,
                                        newQty,
                                      );
                                },
                              ),

                              /// QUANTIDADE ATUAL
                              Text('${item.quantity}'),

                              /// BOTÃO AUMENTAR QUANTIDADE
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  final newQty = item.quantity + 1;
                                  context.read<CartProvider>().updateQuantity(
                                        item.id,
                                        newQty,
                                      );
                                },
                              ),

                              /// REMOVER ITEM
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () {
                                  context.read<CartProvider>().removeItem(
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

          /// =============== RODAPÉ: TOTAL + PAGAR =================
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// TOTAL DO CARRINHO
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Palette.appBarColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Palette.appBarColor, width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Palette.gradient3,
                        ),
                      ),
                      Text(
                        'R\$ ${cart.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Palette.appBarColor,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                /// BOTÃO PAGAR
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.appBarColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    /// Desabilita o botão se não houver itens
                    onPressed: cart.items.isEmpty
                        ? null
                        : () {
                            Navigator.of(context).pushNamed(
                              Routes.pagamento,
                            );
                          },

                    child: const Text(
                      'Pagar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

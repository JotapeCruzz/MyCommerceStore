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
    // DICA (4.2): Sempre usar context.watch quando você quer que a UI atualize.
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: Colors.white,

      /// ===================== APPBAR ===========================
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Volta para Home substituindo a rota atual.
            // pushReplacement evita voltar ao carrinho pressionando "voltar".
            Navigator.pushReplacementNamed(context, Routes.home);
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        backgroundColor: Palette.appBarColor,
        title: const Text('Carrinho'),
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
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// TOTAL DO CARRINHO
                ///
                /// DICA (4.2 Reatividade):
                /// cart.total é recalculado sempre que cart.items muda.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$ ${cart.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                /// BOTÃO PAGAR
                ///
                /// DICA (4.1 Navegação):
                /// pushNamed envia para uma rota registrada em routes.dart.
                ///
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA9CBF9),
                    ),

                    /// Desabilita o botão se não houver itens
                    onPressed: cart.items.isEmpty
                        ? null
                        : () {
                            Navigator.of(context).pushNamed(
                              Routes.pagamento,
                              // DICA: professor pode pedir isso ↓
                              // arguments: cart.total,
                            );
                          },

                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Pagar'),
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

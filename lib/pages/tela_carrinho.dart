import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../routes/routes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF574D4F),
        title: Image.asset(
          'assets/images/e_logo.png',
          height: 40,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty
                ? const Center(child: Text('Seu carrinho está vazio'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: cart.items.length,
                    itemBuilder: (context, i) {
                      final item = cart.items[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: item.imageUrl.isNotEmpty
                              ? Image.network(
                                  item.imageUrl,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox(width: 56, height: 56),
                          title: Text(item.title),
                          subtitle: Text('R\$ ${item.price.toStringAsFixed(2)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  final newQty = item.quantity - 1;
                                  context.read<CartProvider>().updateQuantity(item.id, newQty);
                                },
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  final newQty = item.quantity + 1;
                                  context.read<CartProvider>().updateQuantity(item.id, newQty);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () {
                                  context.read<CartProvider>().removeItem(item.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('R\$ ${cart.total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA9CBF9)),
                    onPressed: cart.items.isEmpty ? null : () {
                      Navigator.of(context).pushNamed(Routes.pagamento); // usando rotas
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
      // bottombar com navigator
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.chat_bubble_outline),
              const Icon(Icons.person_outline),
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  // usa rota nomeada se você tiver definida em routes.dart:
                  if (Navigator.canPop(context)) {
                    // evitar empilhar várias telas iguais; você pode ajustar conforme desejar
                    Navigator.pushNamed(context, Routes.cart);
                  } else {
                    Navigator.pushNamed(context, Routes.cart);
                  }
                },
              ),
              const Icon(Icons.favorite_border),
              const Icon(Icons.more_horiz),
            ],
          ),
        ),
      ),
    );
  }
}

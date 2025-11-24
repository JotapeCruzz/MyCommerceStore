import 'package:flutter/foundation.dart';

// Classe que representa um item dentro do carrinho do usuário.
class CartItem {
  // Identificador único do item.
  final String id;

  // Nome ou título do produto.
  final String title;

  // Preço unitário do produto.
  final double price;

  // URL da imagem que representa o produto.
  final String imageUrl;

  // Quantidade do produto adicionada ao carrinho.
  final int quantity;

  // Construtor do item do carrinho recebendo todos os campos obrigatórios.
  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });
}

// Provider responsável por gerenciar o estado do carrinho.
class CartProvider with ChangeNotifier {
  // Lista privada que armazena os itens atuais do carrinho.
  final List<CartItem> _items = [
    // Item de teste para simular um produto 1.
    CartItem(
      id: '1',
      title: 'Produto 1',
      price: 99.99,
      imageUrl: 'https://picsum.photos/200',
      quantity: 1,
    ),

    // Item de teste para simular um produto 2.
    CartItem(
      id: '2',
      title: 'Produto 2',
      price: 149.99,
      imageUrl: 'https://picsum.photos/200',
      quantity: 1,
    ),
  ];

  // Getter que retorna uma cópia da lista de itens do carrinho.
  List<CartItem> get items => [..._items];

  // Getter que calcula o valor total do carrinho somando preço * quantidade.
  double get total {
    return _items.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  // Método que adiciona um novo item ao carrinho.
  void addItem(String title, double price, String imageUrl) {
    // Adiciona um item novo com quantidade padrão igual a 1.
    _items.add(
      CartItem(
        id: DateTime.now().toString(), // Gera ID único baseado no horário.
        title: title,
        price: price,
        imageUrl: imageUrl,
        quantity: 1,
      ),
    );

    // Notifica os listeners que houve alteração no carrinho.
    notifyListeners();
  }

  // Método que remove um item específico com base no seu ID.
  void removeItem(String id) {
    // Remove o item que possuir o mesmo ID informado.
    _items.removeWhere((item) => item.id == id);

    // Notifica que o carrinho foi atualizado.
    notifyListeners();
  }

  // Método que atualiza a quantidade de um item existente.
  void updateQuantity(String id, int quantity) {
    // Busca o índice do item correspondente ao ID.
    final index = _items.indexWhere((item) => item.id == id);

    // Verifica se o item foi encontrado.
    if (index >= 0) {
      // Caso a quantidade seja menor ou igual a zero, remove o item.
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        // Caso contrário, recria o item com a quantidade atualizada.
        _items[index] = CartItem(
          id: _items[index].id,
          title: _items[index].title,
          price: _items[index].price,
          imageUrl: _items[index].imageUrl,
          quantity: quantity,
        );
      }

      // Notifica listeners para atualização da interface.
      notifyListeners();
    }
  }

  // Método que limpa todos os itens do carrinho.
  void clear() {
    // Remove todos os itens da lista interna.
    _items.clear();

    // Notifica que o carrinho foi esvaziado.
    notifyListeners();
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // Serialize to Map for persistence
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'price': price,
        'imageUrl': imageUrl,
        'quantity': quantity,
      };

  // Deserialize from Map
  factory CartItem.fromMap(Map<String, dynamic> map) => CartItem(
        id: map['id'] as String,
        title: map['title'] as String,
        price: (map['price'] as num).toDouble(),
        imageUrl: map['imageUrl'] as String,
        quantity: (map['quantity'] as num).toInt(),
      );
}

// Provider responsável por gerenciar o estado do carrinho.
class CartProvider with ChangeNotifier {
  // Lista privada que armazena os itens atuais do carrinho.
  List<CartItem> _items = [];

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
  void addItem(String title, double price, String imageUrl, {int quantity = 1}) {
    // Caso já exista um item com o mesmo título, apenas incrementa a quantidade
    final existingIndex = _items.indexWhere((p) => p.title == title);
    if (existingIndex >= 0) {
      final existing = _items[existingIndex];
      _items[existingIndex] = CartItem(
        id: existing.id,
        title: existing.title,
        price: existing.price,
        imageUrl: existing.imageUrl,
        quantity: existing.quantity + quantity,
      );
    } else {
      _items.add(
        CartItem(
          id: DateTime.now().toString(), // Gera ID único baseado no horário.
          title: title,
          price: price,
          imageUrl: imageUrl,
          quantity: quantity,
        ),
      );
    }

    // Notifica os listeners que houve alteração no carrinho.
    notifyListeners();
    _saveCart();
  }

  // Método que remove um item específico com base no seu ID.
  void removeItem(String id) {
    // Remove o item que possuir o mesmo ID informado.
    _items.removeWhere((item) => item.id == id);

    // Notifica que o carrinho foi atualizado.
    notifyListeners();
    _saveCart();
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
      _saveCart();
    }
  }

  // Método que limpa todos os itens do carrinho.
  void clear() {
    // Remove todos os itens da lista interna.
    _items.clear();

    // Notifica que o carrinho foi esvaziado.
    notifyListeners();
    _saveCart();
  }

  // ------------------------------------------------------------------
  // Persistence using SharedPreferences
  // ------------------------------------------------------------------
  static const _kPrefsKey = 'cart_items_v1';

  // Loads the cart items from SharedPreferences and notifies listeners.
  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_kPrefsKey);
    if (data != null && data.isNotEmpty) {
      try {
        final decoded = jsonDecode(data) as List<dynamic>;
        _items = decoded
            .map((e) => CartItem.fromMap(Map<String, dynamic>.from(e)))
            .toList();
        notifyListeners();
      } catch (e) {
        // ignore parse errors and keep empty list
      }
    }
  }

  // Saves the cart items into SharedPreferences
  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_items.map((e) => e.toMap()).toList());
    await prefs.setString(_kPrefsKey, encoded);
  }

  // Public method to initialize/load (callable after provider is created)
  void loadPersistedCart() {
    _loadCart();
  }
}

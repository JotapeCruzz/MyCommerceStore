import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [
    // Test items
    CartItem(
      id: '1',
      title: 'Produto 1',
      price: 99.99,
      imageUrl: 'https://picsum.photos/200',
      quantity: 1,
    ),
    CartItem(
      id: '2',
      title: 'Produto 2',
      price: 149.99,
      imageUrl: 'https://picsum.photos/200',
      quantity: 1,
    ),
  ];

  List<CartItem> get items => [..._items];

  double get total {
    return _items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void addItem(String title, double price, String imageUrl) {
    _items.add(
      CartItem(
        id: DateTime.now().toString(),
        title: title,
        price: price,
        imageUrl: imageUrl,
        quantity: 1,
      ),
    );
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void updateQuantity(String id, int quantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = CartItem(
          id: _items[index].id,
          title: _items[index].title,
          price: _items[index].price,
          imageUrl: _items[index].imageUrl,
          quantity: quantity,
        );
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
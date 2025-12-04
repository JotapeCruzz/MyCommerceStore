import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Representa um item favorito.
class FavoriteItem {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  FavoriteItem({required this.id, required this.title, required this.price, required this.imageUrl});

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'price': price,
    'imageUrl': imageUrl,
  };

  factory FavoriteItem.fromMap(Map<String, dynamic> map) => FavoriteItem(
    id: map['id'] as String,
    title: map['title'] as String,
    price: map['price'] as double,
    imageUrl: map['imageUrl'] as String,
  );
}

/// Provider responsável por gerenciar os favoritos do usuário.
class FavoritesProvider with ChangeNotifier {
  List<FavoriteItem> _items = [];

  List<FavoriteItem> get items => [..._items];

  bool isFavorite(String id) {
    return _items.any((item) => item.id == id);
  }

  /// Adiciona um item aos favoritos.
  void addFavorite(String id, String title, double price, String imageUrl) {
    if (!isFavorite(id)) {
      _items.add(FavoriteItem(id: id, title: title, price: price, imageUrl: imageUrl));

      notifyListeners();
      _saveFavorites();
    }
  }

  /// Remove um item dos favoritos.
  void removeFavorite(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
    _saveFavorites();
  }

  /// Alterna entre adicionar ou remover favorito.
  void toggleFavorite(String id, String title, double price, String imageUrl) {
    if (isFavorite(id)) {
      removeFavorite(id);
    } else {
      addFavorite(id, title, price, imageUrl);
    }
  }

  /// Limpa todos os favoritos.
  void clear() {
    _items.clear();
    notifyListeners();
    _saveFavorites();
  }

  // ------------------------------------------------------------------
  // Persistência usando SharedPreferences
  // ------------------------------------------------------------------
  static const _kPrefsKey = 'favorite_items_v1';

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_kPrefsKey);

    if (data != null && data.isNotEmpty) {
      try {
        final decoded = jsonDecode(data) as List<dynamic>;
        _items = decoded
            .map((e) => FavoriteItem.fromMap(Map<String, dynamic>.from(e)))
            .toList();
        notifyListeners();
      } catch (_) {
        // se der erro, ignora e mantém lista vazia
      }
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_items.map((e) => e.toMap()).toList());
    await prefs.setString(_kPrefsKey, encoded);
  }

  void loadPersistedFavorites() {
    _loadFavorites();
  }
}

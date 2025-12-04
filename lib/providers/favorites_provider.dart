import 'package:flutter/material.dart';
import '../services/favorites_service.dart';

class FavoritesProvider extends ChangeNotifier {
  final FavoritesService service;

  FavoritesProvider(this.service) {
    service.favoritesStream().listen((ids) {
      favoriteIds = ids;
      notifyListeners();
    });
  }

  List<String> favoriteIds = [];

  bool isFavorite(String id) => favoriteIds.contains(id);

  Future<void> toggleFavorite(String id) async {
    if (isFavorite(id)) {
      await service.removeFavorite(id);
    } else {
      await service.addFavorite(id);
    }
  }
}

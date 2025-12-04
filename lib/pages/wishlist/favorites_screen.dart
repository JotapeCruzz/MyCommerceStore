import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../providers/favorites_provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> products = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final fav = Provider.of<FavoritesProvider>(context, listen: false);
    final ids = fav.favoriteIds;

    List<Map<String, dynamic>> fetched = [];

    for (final id in ids) {
      final res = await http.get(Uri.parse("https://fakestoreapi.com/products/$id"));
      if (res.statusCode == 200) {
        fetched.add(jsonDecode(res.body));
      }
    }

    setState(() {
      products = fetched;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : products.isEmpty
              ? const Center(child: Text('Nenhum favorito'))
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (_, i) {
                    final p = products[i];
                    return ListTile(
                      title: Text(p['title']),
                      subtitle: Text("\$${p['price']}"),
                      trailing: IconButton(
                        icon: Icon(
                          fav.isFavorite(p['id'].toString())
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          fav.toggleFavorite(p['id'].toString());
                          _loadProducts();
                        },
                      ),
                    );
                  },
                ),
    );
  }
}




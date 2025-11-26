import 'category_model.dart';

class ProdutoModel {
  final int id;
  final String title;
  final String slug;
  final double price;
  final String description;
  final CategoryModel category;
  final List<String> images;
  final String creationAt;
  final String updatedAt;

  ProdutoModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    required this.creationAt,
    required this.updatedAt,
  });

  factory ProdutoModel.fromMap(Map<String, dynamic> mapProduto) {
    return ProdutoModel(
      id: mapProduto['id'],
      title: mapProduto['title'],
      slug: mapProduto['slug'] ?? '',
      price: mapProduto['price'] * 1.0,
      description: mapProduto['description'],
      category: CategoryModel.fromMap(mapProduto['category']),
      images: List<String>.from(mapProduto['images']),
      creationAt: mapProduto['creationAt'],
      updatedAt: mapProduto['updatedAt'],
    );
  }
}

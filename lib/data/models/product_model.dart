class ProdutoModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String img;

  ProdutoModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.img,
  });

  factory ProdutoModel.fromMap(Map<String, dynamic> mapProduto) {
    return ProdutoModel(
      id: mapProduto['id'],
      title: mapProduto['title'],
      price: mapProduto['price'] * 1.0,
      description: mapProduto['description'],
      category: mapProduto['category'],
      img: mapProduto['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': img,
    };
  }
}

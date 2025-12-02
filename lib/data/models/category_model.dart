class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String image;
  final String creationAt;
  final String updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      slug: map['slug'],
      image: map['image'],
      creationAt: map['creationAt'],
      updatedAt: map['updatedAt'],
    );
  }
}

import 'dart:convert';

import 'package:ecommerce_my_store/data/http/exceptions.dart';
import 'package:ecommerce_my_store/data/http/http_client.dart';
import 'package:ecommerce_my_store/data/models/product_model.dart';
import 'package:google_identity_services_web/id.dart';

abstract class IProductRepository {
  Future<List<ProdutoModel>> getProducts();
  Future<ProdutoModel> getProductsbyId(int id);
}

class ProductRepository implements IProductRepository {
  final IHtppClient client;

  ProductRepository({required this.client});

  @override
  Future<List<ProdutoModel>> getProducts() async {
    final response = await client.get(url: 'https://fakestoreapi.com/products');

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);

      final products = body.map((item) {
        return ProdutoModel.fromMap(item);
      }).toList();

      return products;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é válida');
    } else {
      throw Exception('Não foi possível carregar produtos');
    }
  }

  @override
  Future<ProdutoModel> getProductsbyId(int id) async {
    final response = await client.get(
      url: 'https://fakestoreapi.com/products/${id}',
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);

      return ProdutoModel.fromMap(body);

    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é válida');
    } else {
      throw Exception('Não foi possível carregar produto');
    }

  }
}

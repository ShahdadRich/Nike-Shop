import 'package:dio/dio.dart';
import 'package:nike/data/common/http_respons_validator.dart';
import 'package:nike/data/product.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDataSource
    with HttpResponsValidator
    implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDataSource(this.httpClient);

  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    final response = await httpClient.get('product/list?sort=3$sort');
    validateRespons(response);
    final product = <ProductEntity>[];
    (response.data as List).forEach((element) {
      product.add(ProductEntity.fromJson(element));
    });
    return product;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final response = await httpClient.get('product/search?q=3$searchTerm');
    validateRespons(response);
    final product = <ProductEntity>[];
    (response.data as List).forEach((element) {
      product.add(ProductEntity.fromJson(element));
    });
    return product;
  }
}

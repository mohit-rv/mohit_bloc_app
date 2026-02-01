import 'package:bloclearnbyproject/core/network/api_client.dart';
import 'package:bloclearnbyproject/core/network/api_endpoint.dart';
import 'package:bloclearnbyproject/feature/data/model/product_model/prodict_model.dart';


class ProductRepository {
  final ApiClient apiClient;

  ProductRepository({required this.apiClient});

  // GET ALL PRODUCTS
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await apiClient.dio.get(ApiEndpoints.products);

      final List data = response.data;
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to load products");
    }
  }

  // GET SINGLE PRODUCT BY ID
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await apiClient.dio.get(
        "${ApiEndpoints.products}/$id",
      );

      return ProductModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to load product detail");
    }
  }
}


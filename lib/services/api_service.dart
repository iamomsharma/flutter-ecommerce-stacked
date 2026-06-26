import 'package:dio/dio.dart';
import 'package:myshop/models/product_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://fakestoreapi.com"));

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get("/products");

      final List data = response.data;

      return data.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to load products");
    }
  }
}

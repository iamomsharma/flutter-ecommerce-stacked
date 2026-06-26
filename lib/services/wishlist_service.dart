import 'package:myshop/app/app.locator.dart';
import 'package:myshop/models/product_model.dart';
import 'package:myshop/services/hive_service.dart';

class WishlistService {
  final _hiveService = locator<HiveService>();

  /// Add Product
  Future<void> addProduct(ProductModel product) async {
    await _hiveService.getWishlistBox().put(product.id, product.toMap());
  }

  /// Remove Product
  Future<void> removeProduct(int id) async {
    await _hiveService.getWishlistBox().delete(id);
  }

  /// Check Product Exists
  bool isFavourite(int id) {
    return _hiveService.getWishlistBox().containsKey(id);
  }

  /// Get All Products
  List<ProductModel> getProducts() {
    return _hiveService
        .getWishlistBox()
        .values
        .map((e) => ProductModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }
}

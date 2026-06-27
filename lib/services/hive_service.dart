import 'package:hive_flutter/hive_flutter.dart';
import 'package:myshop/models/product_model.dart';

class HiveService {
  static const String wishlistBox = "wishlist";
  static const String cartBox = "cart";
  static const String productsBox = "products";

  Box getWishlistBox() {
    return Hive.box(wishlistBox);
  }

  Box getCartBox() {
    return Hive.box(cartBox);
  }

  Box getProductsBox() {
    return Hive.box(productsBox);
  }

  Future<void> saveProducts(List<ProductModel> products) async {
    final box = getProductsBox();

    await box.clear();

    for (var product in products) {
      await box.put(product.id, product.toMap());
    }
  }

  List<ProductModel> getProducts() {
    final box = getProductsBox();

    return box.values
        .map((e) => ProductModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }
}

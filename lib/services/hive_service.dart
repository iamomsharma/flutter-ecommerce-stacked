import 'package:hive_flutter/hive_flutter.dart';

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
}

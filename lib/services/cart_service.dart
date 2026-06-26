import 'package:myshop/app/app.locator.dart';
import 'package:myshop/models/cart_item_model.dart';
import 'package:myshop/models/product_model.dart';
import 'package:myshop/services/hive_service.dart';

class CartService {
  final _hiveService = locator<HiveService>();

  get _box => _hiveService.getCartBox();

  Future<void> addProduct(ProductModel product) async {
    if (_box.containsKey(product.id)) {
      final map = Map<String, dynamic>.from(_box.get(product.id));

      final item = CartItemModel.fromMap(map);

      item.quantity++;

      await _box.put(product.id, item.toMap());
    } else {
      final item = CartItemModel(product: product);

      await _box.put(product.id, item.toMap());
    }

    print(_box.toMap());
  }

  Future<void> removeProduct(int id) async {
    await _box.delete(id);
  }

  List<CartItemModel> getCartItems() {
    return _box.values.map<CartItemModel>((e) {
      return CartItemModel.fromMap(Map<String, dynamic>.from(e as Map));
    }).toList();
  }

  Future<void> increaseQuantity(CartItemModel item) async {
    item.quantity++;

    await _box.put(item.product.id, item.toMap());
  }

  Future<void> decreaseQuantity(CartItemModel item) async {
    if (item.quantity > 1) {
      item.quantity--;

      await _box.put(item.product.id, item.toMap());
    } else {
      await removeProduct(item.product.id);
    }
  }

  /// Total Price
  double getTotalPrice() {
    double total = 0;

    for (final item in getCartItems()) {
      total += item.totalPrice;
    }

    return total;
  }

  /// Total Items
  int getTotalItems() {
    return getCartItems().length;
  }

  /// Clear Cart
  Future<void> clearCart() async {
    await _box.clear();
  }
}

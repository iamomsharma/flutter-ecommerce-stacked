import 'package:myshop/app/app.locator.dart';
import 'package:myshop/models/cart_item_model.dart';
import 'package:myshop/services/cart_service.dart';
import 'package:stacked/stacked.dart';

class CartViewModel extends BaseViewModel {
  final _cartService = locator<CartService>();

  List<CartItemModel> cartItems = [];

  double totalPrice = 0;

  void loadCart() {
    try {
      final data = _cartService.getCartItems();

      print("Runtime Type: ${data.runtimeType}");
      print(data);

      cartItems = data;
      totalPrice = _cartService.getTotalPrice();

      notifyListeners();
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> increase(CartItemModel item) async {
    await _cartService.increaseQuantity(item);
    loadCart();
  }

  Future<void> decrease(CartItemModel item) async {
    await _cartService.decreaseQuantity(item);
    loadCart();
  }

  Future<void> remove(CartItemModel item) async {
    await _cartService.removeProduct(item.product.id);
    loadCart();
  }
}

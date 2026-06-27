import 'package:myshop/app/app.locator.dart';
import 'package:myshop/models/product_model.dart';
import 'package:myshop/services/cart_service.dart';
import 'package:myshop/services/wishlist_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductDetailViewModel extends BaseViewModel {
  final _wishlistService = locator<WishlistService>();
  final _cartService = locator<CartService>();
  final _snackbarService = locator<SnackbarService>();

  bool isFavourite(ProductModel product) {
    return _wishlistService.isFavourite(product.id);
  }

  Future<void> toggleWishlist(ProductModel product) async {
    if (_wishlistService.isFavourite(product.id)) {
      await _wishlistService.removeProduct(product.id);
    } else {
      await _wishlistService.addProduct(product);
    }

    notifyListeners();
  }

  Future<void> addToCart(ProductModel product) async {
    print("Adding Product : ${product.title}");

    await _cartService.addProduct(product);

    print("Product Added");

    _snackbarService.showSnackbar(
      message: "Product added to cart",
      duration: const Duration(seconds: 1),
    );
  }
}

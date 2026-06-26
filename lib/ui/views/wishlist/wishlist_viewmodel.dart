import 'package:myshop/app/app.locator.dart';
import 'package:myshop/app/app.router.dart';
import 'package:myshop/models/product_model.dart';
import 'package:myshop/services/wishlist_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class WishlistViewModel extends BaseViewModel {
  final _wishlistService = locator<WishlistService>();
  final _navigationService = locator<NavigationService>();

  List<ProductModel> products = [];

  void loadWishlist() {
    products = _wishlistService.getProducts();
    notifyListeners();
  }

  Future<void> remove(ProductModel product) async {
    await _wishlistService.removeProduct(product.id);
    loadWishlist();
  }

  Future<void> openProductDetail(ProductModel product) async {
    await _navigationService.navigateToProductDetailView(product: product);

    loadWishlist();
  }
}

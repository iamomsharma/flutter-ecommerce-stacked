import 'package:flutter/material.dart';
import 'package:myshop/app/app.locator.dart';
import 'package:myshop/app/app.router.dart';
import 'package:myshop/models/product_model.dart';
import 'package:myshop/services/api_service.dart';
import 'package:myshop/services/hive_service.dart';
import 'package:myshop/services/wishlist_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _navigationService = locator<NavigationService>();
  final _wishlistService = locator<WishlistService>();
  final _hiveService = locator<HiveService>();

  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];

  VoidCallback? get logout => null;

  final searchController = TextEditingController();

  Future<void> getProducts() async {
    setBusy(true);

    try {
      products = await _apiService.getProducts();

      filteredProducts = List.from(products);

      /// Save in Hive
      await _hiveService.saveProducts(products);
    } catch (e) {
      /// Read From Hive
      products = _hiveService.getProducts();

      filteredProducts = List.from(products);
    }

    setBusy(false);
  }

  void searchProducts(String value) {
    if (value.isEmpty) {
      filteredProducts = List.from(products);
    } else {
      filteredProducts = products.where((product) {
        return product.title.toLowerCase().contains(value.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }

  void openProduct(ProductModel product) {
    _navigationService.navigateToProductDetailView(product: product);
  }

  Future<void> openProductDetail(ProductModel product) async {
    await _navigationService.navigateToProductDetailView(product: product);

    notifyListeners();
  }

  bool isFavourite(ProductModel product) {
    return _wishlistService.isFavourite(product.id);
  }

  Future<void> toggleFavourite(ProductModel product) async {
    if (_wishlistService.isFavourite(product.id)) {
      await _wishlistService.removeProduct(product.id);
    } else {
      await _wishlistService.addProduct(product);
    }

    notifyListeners();
  }

  Future<void> refreshProducts() async {
    await getProducts();
  }
}

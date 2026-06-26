import 'package:flutter/material.dart';
import 'package:myshop/ui/common/product_card.dart';
import 'package:stacked/stacked.dart';

import 'wishlist_viewmodel.dart';

class WishlistView extends StackedView<WishlistViewModel> {
  const WishlistView({super.key});

  @override
  Widget builder(
    BuildContext context,
    WishlistViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist"), centerTitle: true),

      body: viewModel.products.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 90, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Your Wishlist is Empty",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: viewModel.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.62,
              ),
              itemBuilder: (context, index) {
                final product = viewModel.products[index];

                return ProductCard(
                  product: product,
                  showFavourite: true,
                  isFavourite: true,
                  onFavourite: () {
                    viewModel.remove(product);
                  },
                  onTap: () {
                    viewModel.openProductDetail(product);
                  },
                );
              },
            ),
    );
  }

  @override
  WishlistViewModel viewModelBuilder(BuildContext context) {
    return WishlistViewModel();
  }

  @override
  void onViewModelReady(WishlistViewModel viewModel) {
    viewModel.loadWishlist();
  }
}

import 'package:flutter/material.dart';
import 'package:myshop/ui/common/custom_search_bar.dart';
import 'package:myshop/ui/common/product_card.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    if (viewModel.isBusy) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("MyShop"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomSearchBar(
                controller: viewModel.searchController,
                onChanged: viewModel.searchProducts,
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: viewModel.filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.62,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      viewModel.openProduct(viewModel.filteredProducts[index]);
                    },
                    child: ProductCard(
                      product: viewModel.filteredProducts[index],
                      onTap: () {
                        viewModel.openProductDetail(
                          viewModel.filteredProducts[index],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) {
    return HomeViewModel();
  }

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.getProducts();
  }
}

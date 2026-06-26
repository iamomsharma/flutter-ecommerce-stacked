import 'package:flutter/material.dart';
import 'package:myshop/ui/common/app_colors.dart';
import 'package:myshop/ui/views/home/home.dart';
import 'package:myshop/ui/views/search/search_view.dart';
import 'package:myshop/ui/views/setting/settings_view.dart';
import 'package:myshop/ui/views/wishlist/wishlist_view.dart';
import 'package:stacked/stacked.dart';

import 'dashboard_viewmodel.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  const DashboardView({super.key});

  @override
  Widget builder(
    BuildContext context,
    DashboardViewModel viewModel,
    Widget? child,
  ) {
    final pages = [
      const HomeView(),
      const WishlistView(),
      const SearchView(),
      const SettingsView(),
    ];

    return Scaffold(
      body: pages[viewModel.currentIndex],

      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: AppColors.primary,
          shape: const CircleBorder(),
          onPressed: () {
            viewModel.openCart();
          },
          child: Icon(
            viewModel.currentIndex == 2
                ? Icons.shopping_cart
                : Icons.shopping_cart_outlined,
            color: Colors.white,
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 10,
        child: SizedBox(
          height: 65,
          child: Row(
            children: [
              /// Home
              Expanded(
                child: _NavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  title: "Home",
                  selected: viewModel.currentIndex == 0,
                  onTap: () => viewModel.changeIndex(0),
                ),
              ),

              /// Wishlist
              Expanded(
                child: _NavItem(
                  icon: Icons.favorite_border,
                  activeIcon: Icons.favorite,
                  title: "Wishlist",
                  selected: viewModel.currentIndex == 1,
                  onTap: () => viewModel.changeIndex(1),
                ),
              ),

              const SizedBox(width: 40),

              /// Search
              Expanded(
                child: _NavItem(
                  icon: Icons.search,
                  activeIcon: Icons.search,
                  title: "Search",
                  selected: viewModel.currentIndex == 2,
                  onTap: () => viewModel.changeIndex(2),
                ),
              ),

              /// Settings
              Expanded(
                child: _NavItem(
                  icon: Icons.settings_outlined,
                  activeIcon: Icons.settings,
                  title: "Settings",
                  selected: viewModel.currentIndex == 3,
                  onTap: () => viewModel.changeIndex(3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) {
    return DashboardViewModel();
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : Colors.grey;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(selected ? activeIcon : icon, color: color),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 11, color: color)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myshop/app/app.router.dart';
import 'package:myshop/services/api_service.dart';
import 'package:myshop/services/auth_service.dart';
import 'package:myshop/services/cart_service.dart';
import 'package:myshop/services/hive_service.dart';
import 'package:myshop/services/wishlist_service.dart';
import 'package:myshop/ui/views/cart/cart_view.dart';
import 'package:myshop/ui/views/dashboard/dashboard_view.dart';
import 'package:myshop/ui/views/home/home.dart';
import 'package:myshop/ui/views/login/login_view.dart';
import 'package:myshop/ui/views/product_details/product_detail_view.dart';
import 'package:myshop/ui/views/signup/signup_view.dart';
import 'package:myshop/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: ProductDetailView),
    MaterialRoute(page: DashboardView),
    MaterialRoute(page: CartView),
  ],

  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: HiveService),
    LazySingleton(classType: WishlistService),
    LazySingleton(classType: CartService),
  ],
)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      navigatorKey: StackedService.navigatorKey,

      onGenerateRoute: StackedRouter().onGenerateRoute,

      initialRoute: Routes.loginView,
    );
  }
}

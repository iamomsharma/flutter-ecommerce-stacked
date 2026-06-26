import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myshop/app/app.locator.dart';
import 'package:myshop/app/app.router.dart';
import 'package:myshop/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  final authService = locator<AuthService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  void togglePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void goToSignup() {
    _navigationService.navigateToSignupView();
  }

  Future<void> login() async {
    // Validation
    if (emailController.text.trim().isEmpty) {
      _snackbarService.showSnackbar(message: "Please enter email");
      return;
    }

    if (passwordController.text.trim().isEmpty) {
      _snackbarService.showSnackbar(message: "Please enter password");
      return;
    }

    try {
      setBusy(true);

      await authService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      _navigationService.replaceWithDashboardView();
    } on FirebaseAuthException catch (e) {
      _snackbarService.showSnackbar(message: e.message ?? "Login Failed");
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setBusy(false);
    }
  }
}

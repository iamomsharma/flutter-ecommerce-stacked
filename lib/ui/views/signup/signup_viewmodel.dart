import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myshop/app/app.locator.dart';
import 'package:myshop/app/app.router.dart';
import 'package:myshop/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  void togglePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void goToLogin() {
    _navigationService.back();
  }

  Future<void> register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty) {
      _snackbarService.showSnackbar(message: "Please enter email");
      return;
    }

    if (!email.contains("@")) {
      _snackbarService.showSnackbar(message: "Please enter valid email");
      return;
    }

    if (password.isEmpty) {
      _snackbarService.showSnackbar(message: "Please enter password");
      return;
    }

    if (password.length < 6) {
      _snackbarService.showSnackbar(
        message: "Password must be at least 6 characters",
      );
      return;
    }

    if (password != confirmPassword) {
      _snackbarService.showSnackbar(message: "Passwords do not match");
      return;
    }

    try {
      setBusy(true);

      await _authService.signUp(email, password);

      _snackbarService.showSnackbar(message: "Account created successfully");

      _navigationService.replaceWithDashboardView();
    } on FirebaseAuthException catch (e) {
      _snackbarService.showSnackbar(
        message: e.message ?? "Registration Failed",
      );
    } finally {
      setBusy(false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

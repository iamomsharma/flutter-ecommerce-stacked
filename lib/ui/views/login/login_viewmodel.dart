import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myshop/app/app.locator.dart';
import 'package:myshop/app/app.router.dart';
import 'package:myshop/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

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
    final hasInternet = await InternetConnection().hasInternetAccess;

    if (!hasInternet) {
      _snackbarService.showSnackbar(
        message: "No internet connection",
        duration: const Duration(seconds: 1),
      );
      return;
    }

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Email Empty
    if (email.isEmpty) {
      _snackbarService.showSnackbar(
        message: "Please enter email",
        duration: const Duration(seconds: 1),
      );
      return;
    }

    // Email Format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(email)) {
      _snackbarService.showSnackbar(
        message: "Please enter a valid email",
        duration: const Duration(seconds: 1),
      );
      return;
    }

    if (password.isEmpty) {
      _snackbarService.showSnackbar(
        message: "Please enter password",
        duration: const Duration(seconds: 1),
      );
      return;
    }

    if (password.length < 6) {
      _snackbarService.showSnackbar(
        message: "Password must be at least 6 characters",
        duration: const Duration(seconds: 1),
      );
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
      String message;

      switch (e.code) {
        case 'invalid-credential':
          message = "Invalid email or password";
          break;

        case 'invalid-email':
          message = "Please enter a valid email";
          break;

        case 'network-request-failed':
          message = "No internet connection";
          break;

        case 'too-many-requests':
          message = "Too many attempts. Please try again later.";
          break;

        default:
          message = e.message ?? "Login failed";
      }

      _snackbarService.showSnackbar(
        message: message,
        duration: const Duration(seconds: 1),
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setBusy(false);
    }
  }
}

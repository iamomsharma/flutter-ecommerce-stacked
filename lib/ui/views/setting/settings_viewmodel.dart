import 'package:myshop/app/app.locator.dart';
import 'package:myshop/app/app.router.dart';
import 'package:myshop/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  Future<void> logout() async {
    await _authService.logout();

    _navigationService.replaceWithLoginView();
  }
}

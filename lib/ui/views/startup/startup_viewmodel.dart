import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshop/app/app.locator.dart';
import 'package:myshop/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future<void> runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 1));

    if (FirebaseAuth.instance.currentUser != null) {
      _navigationService.replaceWithDashboardView();
    } else {
      _navigationService.replaceWithLoginView();
    }
  }
}

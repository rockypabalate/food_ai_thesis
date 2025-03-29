import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginregisterViewModel extends AppBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateToLogin() {
    _navigationService
        .navigateTo(Routes.loginView); // Replace with your actual login route
  }

  void navigateToRegister() {
    _navigationService.navigateTo(
        Routes.registerView); // Replace with your actual register route
  }
}

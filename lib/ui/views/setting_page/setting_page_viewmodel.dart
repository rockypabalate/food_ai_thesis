import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/services/api/auth/auth_api_service.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingPageViewModel extends AppBaseViewModel {
  final AuthApiService _authApiService = locator<AuthApiService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();

  
  Future<void> logout() async {
    final response = await _authApiService.logoutUser();

    if (response.statusCode == 200) {
      _navigationService.navigateTo(Routes.loginView);
      _snackbarService.showSnackbar(message: 'Logged out successfully');
    } else {
      _snackbarService.showSnackbar(
          message: 'Logout failed: ${response.data['error']}');
    }
  }

  Future<void> navigateToEditProfile() async {
    _navigationService.navigateTo(Routes.editProfileView);
  }
  
}

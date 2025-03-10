import 'package:dio/dio.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/services/api/auth/auth_api_service.dart';
import 'package:food_ai_thesis/services/api/auth/auth_service_impl.dart';
import 'package:food_ai_thesis/services/api/shared_preferences/shared_preference_service.dart';
import 'package:stacked_services/stacked_services.dart';

class CheckAuthViewModel extends AppBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthApiService _authApiService = AuthServiceImpl();
  final SharedPreferenceService _sharedPreferenceService =
      locator<SharedPreferenceService>();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> authenticate() async {
    try {
      _isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 6));

      // Retrieve the Bearer token instead of session ID
      String? bearerToken = await _sharedPreferenceService.getBearerToken();
      if (bearerToken == null) {
        _navigationService.clearStackAndShow(Routes.loginregisterView);
        return;
      }

      // Call the getCurrentUser API
      Response response = await _authApiService.getCurrentUser();
      if (response.statusCode == 200 && response.data != null) {
        _navigationService.navigateTo(Routes.mainpageView);
      } else {
        _navigationService.clearStackAndShow(Routes.loginregisterView);
      }
    } catch (e) {
      print('Error during authentication: $e');
      _navigationService.clearStackAndShow(Routes.loginregisterView);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

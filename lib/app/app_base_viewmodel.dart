import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/services/api/auth/auth_api_service.dart';
import 'package:food_ai_thesis/services/api/shared_preferences/shared_preference_service.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppBaseViewModel extends BaseViewModel {
  final navigationservice = locator<NavigationService>();
  final snackbarService = locator<SnackbarService>();
  final authService = locator<AuthApiService>();
  final sharedPrefService = locator<SharedPreferenceService>();
  final apiService = locator<ApiServiceService>();
}

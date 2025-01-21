import 'package:dio/dio.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/services/api/auth/auth_api_service.dart';
import 'package:stacked_services/stacked_services.dart';

class MyProfileViewModel extends AppBaseViewModel {
  final AuthApiService _authApiService = locator<AuthApiService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();

  dynamic _currentUser;

  String get username => _currentUser?['username'] ?? 'Guest';
  String get profileImage => _currentUser?['profile_image'] ?? '';
  String get role => _currentUser?['role'] ?? 'User';

  dynamic get currentUser => _currentUser;

  MyProfileViewModel() {
    _getCurrentUser();
  }

  Future<void> logout() async {
    final response = await _authApiService.logoutUser();

    if (response.statusCode == 200) {
      _navigationService.navigateTo(Routes.signInView);
      _snackbarService.showSnackbar(message: 'Logged out successfully');
    } else {
      _snackbarService.showSnackbar(
          message: 'Logout failed: ${response.data['error']}');
    }
  }

  Future<void> _getCurrentUser() async {
    setBusy(true);

    try {
      final response = await _authApiService.getCurrentUser();

      if (response.statusCode == 200) {
        _currentUser = response.data['user'];
      } else {
        _snackbarService.showSnackbar(
            message: 'Failed to retrieve user: ${response.data['error']}');
      }
    } on DioException catch (e) {
      _snackbarService.showSnackbar(
          message: 'Failed to retrieve user: ${e.message}');
    } catch (e) {
      _snackbarService.showSnackbar(
          message: 'An unexpected error occurred: ${e.toString()}');
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }
}

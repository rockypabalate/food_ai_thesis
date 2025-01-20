import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/user/user_auth.dart';
import 'package:food_ai_thesis/services/api/auth/auth_api_service.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends AppBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthApiService _authApiService = locator<AuthApiService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  bool _isLoading = false; // Loading state
  bool get isLoading => _isLoading;

  bool _isPasswordVisible = false; // Password visibility state
  bool get isPasswordVisible => _isPasswordVisible;

  // Toggle the password visibility
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners(); // Notify the UI to rebuild
  }

  void navigateToregister() {
    _navigationService.navigateTo(Routes.registerView);
  }

  // Function to handle login
  Future<void> login(String email, String password) async {
    _isLoading = true; // Start loading state
    notifyListeners(); // Notify listeners to rebuild the UI

    try {
      await Future.delayed(const Duration(seconds: 2));
      User user = User(email: email, password: password);
      final response = await _authApiService.loginUser(user);

      if (response.statusCode == 200) {
        // Login successful
        final responseData = response.data;
        final message = responseData['message'] ?? 'Login successful';
        _snackbarService.showSnackbar(
          message: message,
          title: 'Success',
        );

        _navigationService.navigateTo(Routes.mainpageView);
      } else {
        // Handle API error
        final error = response.data['error'] ?? 'Unknown error occurred';
        _snackbarService.showSnackbar(
          message: 'Login failed: $error',
          title: 'Error',
        );
      }
    } catch (e) {
      // Handle general exceptions
      _snackbarService.showSnackbar(
        message: 'An error occurred during login: $e',
        title: 'Error',
      );
    } finally {
      _isLoading = false; // End loading state
      notifyListeners(); // Notify listeners to rebuild the UI
    }
  }
}

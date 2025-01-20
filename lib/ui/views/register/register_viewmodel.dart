import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/user/user_auth.dart';
import 'package:food_ai_thesis/services/api/auth/auth_api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends AppBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthApiService _authApiService = locator<AuthApiService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? errorMessage;

  bool _isPasswordVisible = false; // Password visibility state
  bool get isPasswordVisible => _isPasswordVisible;

  // Toggle the password visibility
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners(); // Notify the UI to rebuild
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void navigateToLogin() {
    _navigationService.navigateTo(Routes.loginView);
  }

  Future<void> register(String username, String email, String password,
      String confirmPassword) async {
    setLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (password != confirmPassword) {
        errorMessage = 'Passwords do not match';
        setLoading(false);
        return;
      }

      errorMessage = null;

      User user = User(username: username, email: email, password: password);

      final response = await _authApiService.registerUser(user);

      if (response.statusCode == 200) {
        final responseData = response.data;
        final message = responseData['message'] ?? 'Registration successful';
        _snackbarService.showSnackbar(
          message: message,
          title: 'Success',
        );
        navigateToLogin();
      } else {
        final error = response.data['error'] ?? 'Unknown error occurred';
        _snackbarService.showSnackbar(
          message: 'Registration failed: $error',
          title: 'Error',
        );
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'An error occurred during registration: $e',
        title: 'Error',
      );
    } finally {
      setLoading(false);
    }
  }
}

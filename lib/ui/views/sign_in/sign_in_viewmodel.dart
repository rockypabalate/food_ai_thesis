import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/user/user_auth.dart';
import 'package:food_ai_thesis/services/api/auth/auth_api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends AppBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthApiService _authApiService = locator<AuthApiService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  // Controllers for input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(Routes.signUpView);
  }

  Future<void> login(String email, String password) async {
    if (_isLoading) return; // Prevent multiple logins

    if (email.isEmpty || password.isEmpty) {
      _snackbarService.showSnackbar(
        message: 'Please enter both email and password.',
        title: 'Error',
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      User user = User(email: email, password: password);
      final response = await _authApiService.loginUser(user);

      if (response.statusCode == 200) {
        _snackbarService.showSnackbar(
          message: 'Login successful!',
          title: 'Success',
        );
        _navigationService.navigateTo(Routes.mainpageView);
      } else {
        final error = response.data['error'] ?? 'Unknown error occurred';
        _snackbarService.showSnackbar(
          message: 'Login failed: $error',
          title: 'Error',
        );
        passwordController.clear(); // ✅ Clear password after failed login
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'An error occurred during login: $e',
        title: 'Error',
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

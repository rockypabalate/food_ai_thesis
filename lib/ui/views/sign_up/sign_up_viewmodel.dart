import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/user/user_auth.dart';
import 'package:food_ai_thesis/services/api/auth/auth_api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends AppBaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthApiService _authApiService = locator<AuthApiService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  bool _isLoading = false; 
  bool get isLoading => _isLoading;

  bool _isPasswordVisible = false; 
  bool get isPasswordVisible => _isPasswordVisible;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? errorMessage;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void navigateToSignIn() {
    _navigationService.navigateTo(Routes.signInView);
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> register() async {
    setLoading(true);

    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    try {
      if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        errorMessage = 'All fields are required';
        _snackbarService.showSnackbar(
          message: errorMessage!,
          title: 'Error',
        );
        setLoading(false);
        return;
      }

      if (password != confirmPassword) {
        errorMessage = 'Passwords do not match';
        _snackbarService.showSnackbar(
          message: errorMessage!,
          title: 'Error',
        );
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
        navigateToSignIn();
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

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
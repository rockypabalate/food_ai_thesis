import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/user/user_auth.dart';
import 'package:food_ai_thesis/services/api/auth/auth_api_service.dart';
import 'package:food_ai_thesis/services/supabase/supabse_service.dart';
import 'package:stacked_services/stacked_services.dart';

class FeedbackViewModel extends AppBaseViewModel {
  final AuthApiService _authApiService = locator<AuthApiService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final TextEditingController feedbackController = TextEditingController();

  // Confetti controller - now only triggered on successful 5-star submission
  late ConfettiController confettiController;
  bool shouldShowConfetti = false;

  int selectedRating = 5;
  User? user;

  void initConfetti() {
    confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
  }

  Future<void> getCurrentUser() async {
    setBusy(true);
    try {
      Response response = await _authApiService.getCurrentUser();
      if (response.statusCode == 200 && response.data['user'] != null) {
        user = User.fromJson(response.data['user']);
      } else {
        _snackbarService.showSnackbar(
          message: 'Failed to load user data',
          title: 'Error',
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'Error: ${e.toString()}',
        title: 'Error',
        duration: const Duration(seconds: 2),
      );
    }
    setBusy(false);
  }

  Future<void> submitFeedback(BuildContext context) async {
    if (user == null) {
      _snackbarService.showSnackbar(
        message: 'User not found. Please login again.',
        title: 'Error',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    final String username = user!.username ?? 'Anonymous';
    final String email = user!.email;
    final String feedback = feedbackController.text;

    if (feedback.isEmpty) {
      _snackbarService.showSnackbar(
        message: 'Please write your feedback before submitting.',
        title: 'Missing Feedback',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    setBusy(true);
    final result = await SupabaseService.submitFeedback(
      username: username,
      email: email,
      rating: selectedRating,
      feedback: feedback,
    );
    setBusy(false);

    if (result == null) {
      // Success case
      feedbackController.clear();

      // Only play confetti if this was a 5-star rating submission
      if (shouldShowConfetti && selectedRating == 5) {
        confettiController.play();
      }

      _snackbarService.showSnackbar(
        message: selectedRating == 5
            ? 'We\'re thrilled you had an excellent experience!'
            : 'Thank you for your valuable feedback!',
        title: selectedRating == 5 ? '🎉 Awesome!' : 'Feedback Submitted',
        duration: const Duration(seconds: 3),
      );

      // Add a small delay to allow confetti to be seen before dismissing
      if (shouldShowConfetti && selectedRating == 5) {
        await Future.delayed(const Duration(milliseconds: 800));
      }
      await Future.delayed(const Duration(seconds: 3));
      Navigator.of(context).pop();
    } else {
      // Error case
      _snackbarService.showSnackbar(
        message: result,
        title: 'Submission Failed',
        duration: const Duration(seconds: 2),
      );
    }
  }

  @override
  void dispose() {
    feedbackController.dispose();
    confettiController.dispose();
    super.dispose();
  }
}

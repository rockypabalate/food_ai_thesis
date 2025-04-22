import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';
import '../app/app.locator.dart';
import '../app/app.router.dart';

class FeedbackService {
  final _navService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  final List<String> _pageKeys = [
    // 'visited_PostRecipeView',
    // 'visited_MyProfileView',
    // 'visited_ImageProcessingView',
    'visited_DashboardRecipesView',
    // 'visited_WidgetSearchAllrecipesView',
    // 'visited_SeeallFilipinoRecipesView',
    // 'visited_SeeallFeaturedRecipesView',
    // 'visited_SeeallLikedViewedRecipesView',
    'visited_DisplaySingleRecipeView',
    'visited_UserDashboardView',
    // 'visited_EditProfileView',
    'visited_ImageClassificationView',
    // 'visited_SignInView',
    // 'visited_SignUpView',
    // 'visited_CreateRecipeView',
    // 'visited_UploadRecipeImageView',
    // 'visited_SingleViewPageRecipeView',
    // 'visited_AiProcessingView',
    // 'visited_SettingPageView',
  ];

  Future<void> markPageVisited(String pageKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(pageKey, true);
    await _checkIfAllVisited();
  }

  Future<bool> isPageVisited(String pageKey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(pageKey) ?? false;
  }

  Future<void> _checkIfAllVisited() async {
    final prefs = await SharedPreferences.getInstance();
    final allVisited = _pageKeys.every((key) => prefs.getBool(key) == true);

    final feedbackGiven = prefs.getBool('feedback_given') ?? false;

    if (allVisited && !feedbackGiven) {
      // Prevent showing feedback multiple times
      await prefs.setBool('feedback_given', true);

      // Delay for 10 seconds
      await Future.delayed(const Duration(seconds: 10));

      // Show loading dialog for 2 seconds
      await _dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: 'Just a moment...',
        description: 'Redirecting you to feedback...',
        barrierDismissible: false,
      );

      await Future.delayed(const Duration(seconds: 1));

      _dialogService.completeDialog(DialogResponse()); // Close dialog

      // Navigate to FeedbackView
      _navService.navigateToFeedbackView();
    }
  }
}

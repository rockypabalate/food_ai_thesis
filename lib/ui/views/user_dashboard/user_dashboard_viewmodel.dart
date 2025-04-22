import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/display_created_recipe/display_user_recipe.dart';
import 'package:food_ai_thesis/models/saved_recipe_by_user/saved_recipe_by_user.dart';

import 'package:food_ai_thesis/models/user/user_auth.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:food_ai_thesis/services/api/auth/auth_api_service.dart';
import 'package:food_ai_thesis/services/feedback_service.dart';

import 'package:stacked_services/stacked_services.dart';

class UserDashboardViewModel extends AppBaseViewModel {
  final AuthApiService _authApiService = locator<AuthApiService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final ApiServiceService _apiService = locator<ApiServiceService>();
  final NavigationService _navigationService = locator<NavigationService>();

  final _feedbackService = locator<FeedbackService>();

  FocusNode searchFieldFocusNode = FocusNode();

  Timer? _debounce;
  final bool _isTyping = false;
  bool get isTyping => _isTyping;

  User? user;
  List<SavedFood> savedRecipes = [];
  List<SavedFood> _filteredFoodInfos = [];
  List<SavedFood> get filteredFoodInfos => _filteredFoodInfos;

  List<SavedFood> _foodInfos = [];

  // List to store all user recipes
  List<UserRecipe> _userRecipes = [];
  List<UserRecipe> get userRecipes => _filteredUserRecipes;
  List<UserRecipe> get allUserRecipes => _userRecipes;

  List<UserRecipe> _filteredUserRecipes = [];

  // Add selectedTab to manage the active view
  int selectedTab = 0;

  // Function to update selectedTab and notify listeners
  void setSelectedTab(int tab) {
    selectedTab = tab;
    notifyListeners();
  }

  void userfilterRecipes(String query) {
    setBusy(true); // Indicate the view is loading (this will trigger shimmer)

    if (_debounce?.isActive ?? false) {
      _debounce!.cancel(); // Cancel any ongoing debounce timer
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        _filteredUserRecipes =
            List.from(_userRecipes); // Ensure a fresh list copy
      } else {
        _filteredUserRecipes = _userRecipes
            .where((recipe) =>
                recipe.foodName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }

      setBusy(false); // Stop shimmer/loading
      notifyListeners(); // Notify UI of changes
    });
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
        );
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'Error: ${e.toString()}',
      );
    }
    setBusy(false);
  }

  // New function to get saved recipes by the user
  Future<void> getSavedRecipesByUser() async {
    setBusy(true);
    try {
      savedRecipes = await _apiService.getSavedRecipesByUser();
      _foodInfos = savedRecipes; // Initialize _foodInfos with savedRecipes
      _filteredFoodInfos = savedRecipes; // Also set filteredFoodInfos initially
      if (savedRecipes.isEmpty) {}
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'Error fetching saved recipes: ${e.toString()}',
      );
    }
    setBusy(false);
  }

  // Function to fetch all user recipes
  Future<void> getAllUserRecipes() async {
    setBusy(true);
    try {
      final recipes = await _apiService.fetchAllRecipes();
      if (recipes != null) {
        _userRecipes = recipes;
        _filteredUserRecipes = List.from(
            _userRecipes); // Ensure filtered list starts with all recipes
        notifyListeners();
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'Error fetching user recipes: ${e.toString()}',
      );
    }
    setBusy(false);
  }

  void filterRecipes(String query) {
    setBusy(
        true); // Indicate the view is loading (this will trigger the shimmer)

    if (_debounce?.isActive ?? false) {
      _debounce!.cancel(); // Cancel any ongoing debounce timer
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      // After 500ms, filter the recipes
      if (query.isEmpty) {
        _filteredFoodInfos =
            _foodInfos; // Assuming _foodInfos is your original list
      } else {
        _filteredFoodInfos = _foodInfos
            .where((foodInfo) =>
                foodInfo.foodName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }

      setBusy(false); // Set to false after filtering to stop shimmer
    });
  }

  Future<void> deleteFoodById(int foodId) async {
    setBusy(true); // Set the ViewModel state to busy
    try {
      final bool isDeleted = await _apiService.deleteFoodById(foodId);

      if (isDeleted) {
        // If deletion is successful, remove the item from savedRecipes and refresh filtered list
        savedRecipes.removeWhere(
            (food) => food.id == foodId); // Use 'id' instead of 'foodId'
        _filteredFoodInfos = savedRecipes;

        _snackbarService.showSnackbar(
          message: 'Food deleted successfully',
        );
      } else {
        _snackbarService.showSnackbar(
          message: 'Failed to delete food or food not found',
        );
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'Error deleting food: ${e.toString()}',
      );
    } finally {
      setBusy(false); // Set the ViewModel state back to idle
    }
  }

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

  Future<void> navigateToSearchRecipes() async {
    _navigationService.navigateTo(Routes.widgetSearchAllrecipesView);
  }

  void navigateBack() {
    _navigationService
        .navigateTo(Routes.dashboardRecipesView); // Change to the desired route
  }

  Future<void> navigateToSettingsPage() async {
    _navigationService.navigateTo(Routes.settingPageView);
  }

  void markVisitedForFeedback() async {
    const pageKey = 'visited_UserDashboardView';

    final alreadyVisited = await _feedbackService.isPageVisited(pageKey);

    if (!alreadyVisited) {
      await _feedbackService.markPageVisited(pageKey);
      debugPrint('✅ visited_UserDashboardView visited for the first time.');
    } else {
      debugPrint('ℹ️ visited_UserDashboardView was already visited.');
    }
  }
}

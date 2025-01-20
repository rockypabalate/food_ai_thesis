import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/saved_recipe_by_user/saved_recipe_by_user.dart';
import 'package:food_ai_thesis/models/user/user_auth.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:food_ai_thesis/services/api/auth/auth_api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UserDashboardViewModel extends AppBaseViewModel {
  final AuthApiService _authApiService = locator<AuthApiService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final ApiServiceService _apiService = locator<ApiServiceService>();

  FocusNode searchFieldFocusNode = FocusNode();

  Timer? _debounce;
  final bool _isTyping = false;
  bool get isTyping => _isTyping;

  User? user;
  List<SavedFood> savedRecipes = [];
  List<SavedFood> _filteredFoodInfos = [];
  List<SavedFood> get filteredFoodInfos => _filteredFoodInfos;

  List<SavedFood> _foodInfos = [];

  // Add selectedTab to manage the active view
  int selectedTab = 0;

  // Function to update selectedTab and notify listeners
  void setSelectedTab(int tab) {
    selectedTab = tab;
    notifyListeners();
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
}

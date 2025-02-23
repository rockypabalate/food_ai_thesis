import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/list_recipes/list_recipes.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:food_ai_thesis/services/api/auth/auth_api_service.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardRecipesViewModel extends AppBaseViewModel {
  final AuthApiService _authApiService = locator<AuthApiService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ApiServiceService _apiService = locator<ApiServiceService>();

  FocusNode searchFieldFocusNode = FocusNode();

  dynamic _currentUser;

  String get username => _currentUser?['username'] ?? 'Guest';
  String get profileImage => _currentUser?['profile_image'] ?? '';

  dynamic get currentUser => _currentUser;

  List<FoodInfo> _foodInfos = [];
  List<FoodInfo> _filteredFoodInfos = []; // To store the filtered data
  List<FoodInfo> get foodInfos =>
      _filteredFoodInfos.isEmpty ? _foodInfos : _filteredFoodInfos;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successMessage;
  String? get successMessage => _successMessage;

  DashboardRecipesViewModel() {
    getCurrentUser();
  }

  @override
  void dispose() {
    searchFieldFocusNode.dispose();

    super.dispose();
  }

  /// Retrieve featured recipes based on current filters
  List<FoodInfo> get featuredRecipes {
    final baseList =
        _filteredFoodInfos.isEmpty ? _foodInfos : _filteredFoodInfos;
    return baseList.where((food) => food.recipeFeatured == 1).toList();
  }

  /// Retrieve unique categories from the food list
  Set<String> get uniqueCategories {
    return _foodInfos
        .where((food) => food.category != null)
        .map((food) => food.category!)
        .toSet();
  }

  /// Retrieve recipes sorted by most viewed and liked
  List<FoodInfo> get mostViewedAndLikedRecipes {
    final baseList =
        _filteredFoodInfos.isEmpty ? _foodInfos : _filteredFoodInfos;
    return baseList.where((food) => food.views > 0 && food.likes > 0).toList()
      ..sort((a, b) => (b.views + b.likes).compareTo(a.views + a.likes));
  }

  /// Retrieve unique categories from featured recipes
  Set<String> get uniqueFeaturedCategories {
    return featuredRecipes
        .where((food) => food.category != null)
        .map((food) => food.category!)
        .toSet();
  }

  /// Retrieve all food information
  Future<void> getAllFoodInfo() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final foodInfoList = await _apiService.getAllFoodInfo();

      if (foodInfoList.isNotEmpty) {
        _foodInfos = foodInfoList;
        _filteredFoodInfos = []; // Reset filtered list to show all foods

        // Log the response to the debug console
        for (var food in _foodInfos) {
          print(
              'Food Name: ${food.foodName}, Description: ${food.description}');
        }

        print('Number of food infos: ${_foodInfos.length}');
      } else {
        _errorMessage = 'No food information available';
        print(_errorMessage); // Log the error message
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch food information: $e';
      print(_errorMessage); // Log the error message
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Filter food items by category
  void filterByCategory(String category) {
    _filteredFoodInfos =
        _foodInfos.where((food) => food.category == category).toList();
    notifyListeners();
  }

  /// Filter featured recipes by category
  void filterFeaturedByCategory(String category) {
    _filteredFoodInfos =
        featuredRecipes.where((food) => food.category == category).toList();
    notifyListeners();
  }

  /// Show all recipes
  void showAllRecipes() {
    _filteredFoodInfos = _foodInfos; // Reset to all recipes
    notifyListeners();
  }

  /// Clear the filter to display all food items
  void clearCategoryFilter() {
    _filteredFoodInfos = [];
    notifyListeners();
  }

  /// Retrieve the current user information
  Future<void> getCurrentUser() async {
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

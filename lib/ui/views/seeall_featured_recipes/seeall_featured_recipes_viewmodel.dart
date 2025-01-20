import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/list_recipes/list_recipes.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:stacked_services/stacked_services.dart';

class SeeallFeaturedRecipesViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = locator<ApiServiceService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  List<FoodInfo> _foodInfos = [];
  List<FoodInfo> _filteredFeaturedRecipes = [];
  List<FoodInfo> get featuredRecipes => _filteredFeaturedRecipes;

  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();

  Timer? _debounce;
  bool _isTyping = false;
  bool get isTyping => _isTyping;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  /// Filter featured recipes by category
  void filterByCategory(String category) {
    _selectedCategory = category;
    _filteredFeaturedRecipes = _foodInfos
        .where((food) => food.recipeFeatured == 1 && food.category == category)
        .toList();
    notifyListeners();
  }

  /// Retrieve unique categories from featured recipes
  Set<String> get uniqueCategories {
    return _foodInfos
        .where((food) => food.recipeFeatured == 1 && food.category != null)
        .map((food) => food.category!)
        .toSet();
  }

  /// Clear category filter
  void clearCategoryFilter() {
    _selectedCategory = null;
    _filteredFeaturedRecipes =
        _foodInfos.where((food) => food.recipeFeatured == 1).toList();
    notifyListeners();
  }

  /// Retrieve all food information and filter featured recipes
  Future<void> getAllFoodInfo() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final foodInfoList = await _apiService.getAllFoodInfo();

      if (foodInfoList.isNotEmpty) {
        _foodInfos = foodInfoList;
        // Filter only featured recipes during initialization
        _filteredFeaturedRecipes =
            _foodInfos.where((food) => food.recipeFeatured == 1).toList();
      } else {
        _errorMessage = 'No food information available';
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch food information: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Filter featured recipes by search query
  void filterRecipes(String query) {
    _isTyping = true;
    notifyListeners();

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final baseList =
          _foodInfos.where((food) => food.recipeFeatured == 1).toList();

      _filteredFeaturedRecipes = query.isEmpty
          ? baseList
          : baseList
              .where((food) =>
                  food.foodName.toLowerCase().contains(query.toLowerCase()))
              .toList();

      _isTyping = false;
      notifyListeners();
    });
  }
}

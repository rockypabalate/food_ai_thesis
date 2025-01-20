import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/list_recipes/list_recipes.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:stacked_services/stacked_services.dart';

class SeeallLikedViewedRecipesViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = locator<ApiServiceService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  List<FoodInfo> _foodInfos = [];
  List<FoodInfo> _filteredFoodInfos = [];
  List<FoodInfo> get mostViewedAndLikedRecipes {
    return _filteredFoodInfos
        .where((food) => food.views > 0 && food.likes > 0)
        .toList()
      ..sort((a, b) => (b.views + b.likes).compareTo(a.views + a.likes));
  }

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

  /// Retrieve all food information
  Future<void> getAllFoodInfo() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final foodInfoList = await _apiService.getAllFoodInfo();

      if (foodInfoList.isNotEmpty) {
        _foodInfos = foodInfoList;
        applyFilters();
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

  void applyFilters() {
    // Start with all recipes
    var filtered = _foodInfos;

    // Apply category filter
    if (_selectedCategory != null) {
      filtered =
          filtered.where((food) => food.category == _selectedCategory).toList();
    }

    // Apply search query filter
    final query = searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      filtered = filtered
          .where((food) => food.foodName.toLowerCase().contains(query))
          .toList();
    }

    // Update the filtered list
    _filteredFoodInfos = filtered;

    notifyListeners();
  }

  /// Set the selected category and reapply filters
  void filterByCategory(String category) {
    _selectedCategory = category;
    applyFilters();
  }

  /// Retrieve unique categories from most viewed and liked recipes
  Set<String> get uniqueCategories {
    return mostViewedAndLikedRecipes
        .where((food) => food.category != null)
        .map((food) => food.category!)
        .toSet();
  }

  /// Clear category filter and reapply filters
  void clearCategoryFilter() {
    _selectedCategory = null;
    applyFilters();
  }

  /// Filter recipes based on search query
  void filterRecipes(String query) {
    _isTyping = true;
    notifyListeners();

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _isTyping = false;
      applyFilters();
    });
  }
}

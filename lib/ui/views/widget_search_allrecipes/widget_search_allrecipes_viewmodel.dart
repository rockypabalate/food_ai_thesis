import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/list_recipes/list_recipes.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:stacked_services/stacked_services.dart';

class WidgetSearchAllrecipesViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = locator<ApiServiceService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  List<FoodInfo> _foodInfos = [];
  List<FoodInfo> _filteredFoodInfos = [];
  List<FoodInfo> get foodInfos =>
      _filteredFoodInfos.isEmpty ? _foodInfos : _filteredFoodInfos;
  List<FoodInfo> get filteredFoodInfos => _filteredFoodInfos;

  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();

  Timer? _debounce;
  bool _isTyping = false;
  bool get isTyping => _isTyping;
  bool _showCategories = true;
  bool get showCategories => _showCategories;

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

  void showCategoryList() {
    _showCategories = true;
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    _filteredFoodInfos =
        _foodInfos.where((foodInfo) => foodInfo.category == category).toList();
    _showCategories = false;
    notifyListeners();
  }

  /// Filter recipes based on the selected category
  void filterByCategory(String category) {
    _selectedCategory = category; // ✅ Add this line!
    _filteredFoodInfos =
        _foodInfos.where((foodInfo) => foodInfo.category == category).toList();
    notifyListeners();
  }

  /// Retrieve unique categories from the food list
  Set<String> get uniqueCategories {
    return _foodInfos
        .where((food) => food.category != null)
        .map((food) => food.category!)
        .toSet();
  }

  /// Clear category filter
  void clearCategoryFilter() {
    _selectedCategory = null;
    _filteredFoodInfos = _foodInfos;
    notifyListeners();
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
        _filteredFoodInfos = _foodInfos;
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

  /// Filter recipes based on the search query within the selected category
  void filterRecipes(String query) {
    _isTyping = true;
    notifyListeners();

    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 300), () {
      // Base list should be the already filtered list if a category is selected
      List<FoodInfo> baseList = _selectedCategory == null
          ? _foodInfos
          : _foodInfos
              .where((foodInfo) => foodInfo.category == _selectedCategory)
              .toList();

      if (query.isEmpty) {
        _filteredFoodInfos = baseList;
      } else {
        _filteredFoodInfos = baseList
            .where((foodInfo) =>
                foodInfo.foodName.toLowerCase().contains(query.toLowerCase()))
            .toList();

        // Ensure _filteredFoodInfos is empty if no matches are found
        if (_filteredFoodInfos.isEmpty) {
          _filteredFoodInfos = [];
        }
      }

      _isTyping = false;
      notifyListeners();
    });
  }

  Map<String, List<FoodInfo>> get categoryRecipesMap {
    final Map<String, List<FoodInfo>> map = {};
    for (final food in _foodInfos) {
      if (food.category != null) {
        map.putIfAbsent(food.category!, () => []).add(food);
      }
    }
    return map;
  }
}

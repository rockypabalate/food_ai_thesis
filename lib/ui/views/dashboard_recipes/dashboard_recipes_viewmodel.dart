import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/list_recipes/featured_recipe_model.dart';
import 'package:food_ai_thesis/models/list_recipes/list_recipes.dart';
import 'package:food_ai_thesis/models/list_recipes/popular_recipe_model.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:food_ai_thesis/services/api/auth/auth_api_service.dart';
import 'package:food_ai_thesis/services/feedback_service.dart';
import 'package:stacked_services/stacked_services.dart';

// Define the enum at the top level
enum RecipeSection {
  featured,
  mostLikedViewed,
}

class DashboardRecipesViewModel extends AppBaseViewModel {
  final AuthApiService _authApiService = locator<AuthApiService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ApiServiceService _apiService = locator<ApiServiceService>();

  final _feedbackService = locator<FeedbackService>();

  FocusNode searchFieldFocusNode = FocusNode();

  dynamic _currentUser;
  List<FeaturedRecipe> _featuredRecipes = [];
  List<PopularRecipe> _popularRecipes = [];
  List<FoodInfo> _foodInfos = [];

  bool _isFeaturedLoading = false;
  bool _isPopularLoading = false;
  bool _isLoading = false;

  String? _featuredErrorMessage;
  String? _popularErrorMessage;

  // Track selected recipe section
  RecipeSection _selectedRecipeSection = RecipeSection.featured;
  
  bool get isFeaturedLoading => _isFeaturedLoading;
  bool get isPopularLoading => _isPopularLoading;
  bool get isLoading => _isLoading;
  RecipeSection get selectedRecipeSection => _selectedRecipeSection;

  String? _errorMessage;
  String? get featuredErrorMessage => _featuredErrorMessage;
  String? get popularErrorMessage => _popularErrorMessage;
  String? get errorMessage => _errorMessage;

  String get username => _currentUser?['username'] ?? 'Guest';
  String get profileImage => _currentUser?['profile_image'] ?? '';

  DashboardRecipesViewModel() {
    getCurrentUser();
    getFeaturedRecipes();
    getPopularRecipes(); // Uncommented this so both recipe types load on init
    getAllFoodInfo();
  }

  @override
  void dispose() {
    searchFieldFocusNode.dispose();
    super.dispose();
  }

  // Get a variable number of items based on selected section
  List<FoodInfo> get foodInfos => _foodInfos.take(3).toList();
  List<FeaturedRecipe> get featuredRecipes {
    // Return more items if featured section is selected
    final count = _selectedRecipeSection == RecipeSection.featured ? 6 : 3;
    return _featuredRecipes.take(count).toList();
  }
  
  List<PopularRecipe> get popularRecipes {
    // Return more items if most liked & viewed section is selected
    final count = _selectedRecipeSection == RecipeSection.mostLikedViewed ? 6 : 3;
    return _popularRecipes.take(count).toList();
  }

  Future<void> getAllFoodInfo() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final foodInfoList = await _apiService.getAllFoodInfo();
      if (foodInfoList.isNotEmpty) {
        _foodInfos = foodInfoList;
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

  Future<void> getFeaturedRecipes() async {
    _isFeaturedLoading = true;
    _featuredErrorMessage = null;
    notifyListeners();

    try {
      final featuredList = await _apiService.getFeaturedRecipes();
      if (featuredList.isNotEmpty) {
        _featuredRecipes = featuredList;
        print("Featured Recipes Loaded: ${_featuredRecipes.length}");
      } else {
        _featuredErrorMessage = 'No featured recipes available';
      }
    } catch (e) {
      _featuredErrorMessage = 'Failed to fetch featured recipes: $e';
    } finally {
      _isFeaturedLoading = false;
      notifyListeners();
    }
  }

  Future<void> getPopularRecipes() async {
    _isPopularLoading = true;
    _popularErrorMessage = null;
    notifyListeners();

    try {
      final popularList = await _apiService.getPopularRecipes();
      if (popularList.isNotEmpty) {
        _popularRecipes = popularList.take(10).toList();
      } else {
        _popularErrorMessage = 'No popular recipes available';
      }
    } catch (e) {
      _popularErrorMessage = 'Failed to fetch popular recipes: $e';
    } finally {
      _isPopularLoading = false;
      notifyListeners();
    }
  }

  Future<void> getCurrentUser() async {
    setBusy(true);
    try {
      final response = await _authApiService.getCurrentUser();
      if (response.statusCode == 200) {
        _currentUser = response.data['user'];
      } else {
        _snackbarService.showSnackbar(
          message: 'Failed to retrieve user: ${response.data['error']}',
        );
      }
    } on DioException catch (e) {
      _snackbarService.showSnackbar(
        message: 'Failed to retrieve user: ${e.message}',
      );
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  void navigateToProfile() {
    _navigationService.navigateTo(Routes.userDashboardView);
  }

  void navigateToImageProcessing() {
    _navigationService.navigateTo(Routes.imageProcessingView);
  }

  void markVisitedForFeedback() async {
    const pageKey = 'visited_DashboardRecipesView';

    final alreadyVisited = await _feedbackService.isPageVisited(pageKey);

    if (!alreadyVisited) {
      await _feedbackService.markPageVisited(pageKey);
      debugPrint('✅ visited_DashboardRecipesView visited for the first time.');
    } else {
      debugPrint('ℹ️ visited_DashboardRecipesView was already visited.');
    }
  }

  // Add this method to change the selected section
  void setSelectedRecipeSection(RecipeSection section) {
    _selectedRecipeSection = section;
    notifyListeners(); // Update the UI when selection changes
  }
}
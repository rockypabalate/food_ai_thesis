import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/list_recipes/single_display_recipe.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:food_ai_thesis/services/feedback_service.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/export_pdf_recipe.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked_services/stacked_services.dart';

class DisplaySingleRecipeViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = locator<ApiServiceService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  final _feedbackService = locator<FeedbackService>();

  FoodInfoById? _foodInfoById;
  FoodInfoById? get foodInfoById => _foodInfoById;

  bool _isBusy = false;
  @override
  bool get isBusy => _isBusy;

  int _selectedImageIndex = 0;
  int get selectedImageIndex => _selectedImageIndex;

  void setSelectedImageIndex(int index) {
    _selectedImageIndex = index;
    notifyListeners();
  }

  bool _isSaved = false;
  bool get isSaved => _isSaved;

  bool _isLiked = false;
  bool get isLiked => _isLiked;

  Future<void> fetchFoodInfoById(int foodId) async {
    _isBusy = true;
    notifyListeners();

    try {
      // Step 1: Fetch recipe details first
      final fetchedRecipe = await _apiService.getFoodInfoById(foodId);
      if (fetchedRecipe != null) {
        _foodInfoById = fetchedRecipe;
      } else {
        throw Exception('Recipe not found');
      }

      // Step 2: Increment view count
      await incrementViewCount(foodId);

      // Step 3: Check if liked and saved
      await checkLikedAndSavedStatus(foodId);
    } catch (e) {
      print('Error during sequential fetch: $e');
      _snackbarService.showSnackbar(
        title: 'Error',
        message: 'Something went wrong while loading the recipe.',
      );
    } finally {
      _isBusy = false;
      notifyListeners(); // Notify once after all API calls are done
    }
  }

  // Save food by id
  Future<void> saveFoodById(int foodId) async {
    try {
      final success = await _apiService.saveFoodById(foodId);

      if (success) {
        _snackbarService.showSnackbar(
          title: 'Success',
          message: 'Recipe saved successfully',
        );
        _isSaved = true; // Update saved status
      } else {
        _snackbarService.showSnackbar(
          title: 'Failed',
          message: 'Recipe already saved',
        );
      }
      notifyListeners();
    } catch (e) {
      _snackbarService.showSnackbar(
        title: 'Error',
        message: 'An error occurred while saving the recipe',
      );
      print('Error saving recipe: $e');
    }
  }

  // Like food by id
  Future<void> likeFoodById(int foodId) async {
    try {
      final success = await _apiService.incrementLike(foodId);

      if (success) {
        _isLiked = true; // Update liked status
        notifyListeners();

        _snackbarService.showSnackbar(
          title: 'Success',
          message: 'You liked this recipe',
        );
      } else {
        _snackbarService.showSnackbar(
          title: 'Failed',
          message: 'You already liked this recipe',
        );
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        title: 'Error',
        message: 'An error occurred while liking the recipe',
      );
      print('Error liking recipe: $e');
    }
  }

  // Increment view count
  Future<void> incrementViewCount(int foodId) async {
    try {
      final success = await _apiService.incrementView(foodId);

      if (success) {
        notifyListeners();
        print('View count incremented for recipe ID $foodId');
      }
    } catch (e) {
      print('Error incrementing view count: $e');
    }
  }

  // Request storage permission for export PDF
  Future<void> requestStoragePermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.request();

      if (!status.isGranted) {
        _snackbarService.showSnackbar(
          title: 'Permission Denied',
          message:
              'Storage permission not granted. Please enable it in settings.',
        );
        throw Exception("Storage permission not granted");
      }
    }
  }

  // Export the recipe as a PDF
  Future<void> exportRecipeAsPDF() async {
    if (_foodInfoById == null) return;

    try {
      await requestStoragePermission();

      final file = await PdfExportService.generateRecipePDF(_foodInfoById!);

      _snackbarService.showSnackbar(
        title: 'Success',
        message: 'PDF exported: ${file.path}',
      );
    } catch (e) {
      _snackbarService.showSnackbar(
        title: 'Error',
        message: 'Failed to export PDF.',
      );
      print('PDF Export Error: $e');
    }
  }

  // Check if the recipe is liked and saved
  Future<void> checkLikedAndSavedStatus(int foodId) async {
    try {
      final savedResult = await _apiService.isRecipeSaved(foodId);
      final likedResult = await _apiService.isRecipeLiked(foodId);

      _isSaved = savedResult;
      _isLiked = likedResult;

      debugPrint('Recipe is ${_isSaved ? 'saved' : 'not saved'}');
      debugPrint('Recipe is ${_isLiked ? 'liked' : 'not liked'}');

      notifyListeners();
    } catch (e) {
      debugPrint('Error checking liked/saved status: $e');
    }
  }

  void markVisitedForFeedback() async {
    const pageKey = 'visited_DisplaySingleRecipeView';

    final alreadyVisited = await _feedbackService.isPageVisited(pageKey);

    if (!alreadyVisited) {
      await _feedbackService.markPageVisited(pageKey);
      debugPrint('✅ DisplaySingleRecipeView visited for the first time.');
    } else {
      debugPrint('ℹ️ DisplaySingleRecipeView was already visited.');
    }
  }
  
}

import 'dart:io';

import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/list_recipes/single_display_recipe.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/export_pdf_recipe.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked_services/stacked_services.dart';

class DisplaySingleRecipeViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = locator<ApiServiceService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  

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

  Future<void> fetchFoodInfoById(int foodId) async {
    _isBusy = true;
    notifyListeners();

    try {
      _foodInfoById = await _apiService.getFoodInfoById(foodId);
      _foodInfoById ??= null;
    } catch (e) {
      print('Error fetching food info: $e');
    } finally {
      _isBusy = false;
      notifyListeners();
    }
  }

  Future<void> saveFoodById(int foodId) async {
    // Removed _isBusy handling
    try {
      final success = await _apiService.saveFoodById(foodId);

      if (success) {
        _snackbarService.showSnackbar(
          title: 'Success',
          message: 'Recipe saved successfully',
        );
      } else {
        _snackbarService.showSnackbar(
          title: 'Failed',
          message: 'Recipe already saved',
        );
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        title: 'Error',
        message: 'An error occurred while saving the recipe',
      );
      print('Error saving recipe: $e');
    }
  }

  Future<void> likeFoodById(int foodId) async {
    try {
      final success = await _apiService.incrementLike(foodId);

      if (success) {
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

   // Add a function to request storage permission
  Future<void> requestStoragePermission() async {
    if (Platform.isAndroid) {
      // Requesting storage permissions for Android
      var status = await Permission.storage.request();

      if (!status.isGranted) {
        // If permission is not granted, show an error
        _snackbarService.showSnackbar(
          title: 'Permission Denied',
          message:
              'Storage permission not granted. Please enable it in settings.',
        );
        throw Exception("Storage permission not granted");
      }
    }
  }

  Future<void> exportRecipeAsPDF() async {
    if (_foodInfoById == null) return;

    try {
      // Ensure we have storage permission before proceeding
      await requestStoragePermission();

      final file = await PdfExportService.generateRecipePDF(_foodInfoById!);

      _snackbarService.showSnackbar(
        title: 'Success',
        message: 'PDF exported: ${file.path}',
      );

      // Optional: Share the PDF
      // await Share.shareXFiles([XFile(file.path)], text: 'Check out this recipe!');
    } catch (e) {
      _snackbarService.showSnackbar(
        title: 'Error',
        message: 'Failed to export PDF.',
      );
      print('PDF Export Error: $e');
    }
  }
}

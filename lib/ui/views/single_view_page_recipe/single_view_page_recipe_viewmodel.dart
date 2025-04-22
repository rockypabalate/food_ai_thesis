import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/single_view_created_recipe/single_view_created_recipe.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:food_ai_thesis/ui/views/single_view_page_recipe/recipe_export_pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked_services/stacked_services.dart';

class SingleViewPageRecipeViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = locator<ApiServiceService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  SingleDisplayRecipe? singleRecipe;

  bool isDeleting = false;

  void navigateToUploadImage(String recipeId) {
    if (recipeId.isEmpty) {
      _snackbarService.showSnackbar(
        message: 'Recipe ID is empty.',
      );
      return;
    }

    int? parsedRecipeId = int.tryParse(recipeId);
    if (parsedRecipeId == null || parsedRecipeId <= 0) {
      _snackbarService.showSnackbar(
        message: 'Invalid recipe ID. Please try again.',
      );
      return;
    }

    _navigationService.navigateTo(
      Routes.uploadRecipeImageView,
      arguments: UploadRecipeImageViewArguments(recipeId: parsedRecipeId),
    );
  }

  // Method to fetch a single recipe by ID
  Future<void> fetchSingleRecipe(String recipeId) async {
    setBusy(true);
    try {
      final fetchedRecipe = await _apiService.fetchSingleRecipe(recipeId);
      if (fetchedRecipe != null) {
        singleRecipe = fetchedRecipe;
      } else {
        _snackbarService.showSnackbar(
          message: 'Failed to fetch the recipe. Please try again.',
        );
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'Error fetching recipe: ${e.toString()}',
      );
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> deleteRecipe(String recipeId) async {
    isDeleting = true; // Set deleting state to true
    setBusy(true); // Show busy state for spinner
    notifyListeners();

    // Show confirmation dialog
    var response = await _dialogService.showConfirmationDialog(
      title: 'Delete Recipe',
      description: 'Are you sure you want to delete this recipe?',
      confirmationTitle: 'Delete',
      cancelTitle: 'Cancel',
    );

    if (response?.confirmed == true) {
      try {
        bool success = await _apiService.deleteRecipe(recipeId);
        if (success) {
          _snackbarService.showSnackbar(
              message: 'Recipe deleted successfully.');
          _navigationService.clearStackAndShow(Routes.userDashboardView);
        } else {
          _snackbarService.showSnackbar(message: 'Failed to delete recipe.');
        }
      } catch (e) {
        _snackbarService.showSnackbar(
            message: 'Error deleting recipe: ${e.toString()}');
      }
    }

    isDeleting = false; // Reset deleting state
    setBusy(false); // Hide busy state
    notifyListeners();
  }

  // Method to export recipe as PDF
  Future<void> exportRecipeAsPDF() async {
    if (singleRecipe == null) return;

    try {
      // Ensure we have storage permission before proceeding
      await requestStoragePermission();

      final file = await RecipeExportPdf.generateRecipePDF(singleRecipe!);

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

  // Request storage permission (assuming you have a method for it)
  Future<void> requestStoragePermission() async {
    // You can add logic to request permissions here using the permission_handler package
    // Example:
    final status = await Permission.manageExternalStorage.request();
    if (!status.isGranted) {
      throw Exception("Storage permission not granted");
    }
  }
}

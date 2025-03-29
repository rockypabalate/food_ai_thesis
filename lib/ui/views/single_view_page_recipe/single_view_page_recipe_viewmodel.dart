import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/single_view_created_recipe/single_view_created_recipe.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:stacked_services/stacked_services.dart';

class SingleViewPageRecipeViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = locator<ApiServiceService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  SingleDisplayRecipe? singleRecipe;

  void navigateToUploadImage(String recipeId) {
    int parsedRecipeId =
        int.tryParse(recipeId) ?? 0; // Convert String to int safely
    if (parsedRecipeId == 0) {
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
    var response = await _dialogService.showConfirmationDialog(
      title: 'Delete Recipe',
      description: 'Are you sure you want to delete this recipe?',
      confirmationTitle: 'Delete',
      cancelTitle: 'Cancel',
    );

    if (response?.confirmed == true) {
      setBusy(true);
      try {
        bool success = await _apiService.deleteRecipe(recipeId);
        if (success) {
          _snackbarService.showSnackbar(
            message: 'Recipe deleted successfully.',
          );

          // Clears the navigation stack and replaces it with UserDashboardView
          _navigationService.clearStackAndShow(Routes.userDashboardView);
        } else {
          _snackbarService.showSnackbar(
            message: 'Failed to delete recipe. Try again.',
          );
        }
      } catch (e) {
        _snackbarService.showSnackbar(
          message: 'Error deleting recipe: ${e.toString()}',
        );
      }
      setBusy(false);
    }
  }
}

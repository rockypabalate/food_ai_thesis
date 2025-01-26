import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/created_recipe/create_recipe.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateRecipeViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = locator<ApiServiceService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  // Dynamic lists for ingredients, quantities, and instructions
  List<String> ingredients = [];
  List<String> quantities = [];
  List<String> instructions = [];

  // Method to add an ingredient and quantity
  void addIngredient() {
    ingredients.add('');
    quantities.add('');
    notifyListeners();
  }

  // Method to update an ingredient
  void updateIngredient(int index, String value) {
    ingredients[index] = value;
    notifyListeners();
  }

  // Method to update a quantity
  void updateQuantity(int index, String value) {
    quantities[index] = value;
    notifyListeners();
  }

  // Method to remove an ingredient and its corresponding quantity
  void removeIngredient(int index) {
    ingredients.removeAt(index);
    quantities.removeAt(index);
    notifyListeners();
  }

  // Method to add an instruction
  void addInstruction() {
    instructions.add('');
    notifyListeners();
  }

  // Method to update an instruction
  void updateInstruction(int index, String value) {
    instructions[index] = value;
    notifyListeners();
  }

  // Method to remove an instruction
  void removeInstruction(int index) {
    instructions.removeAt(index);
    notifyListeners();
  }

  // Method to create a recipe
  Future<void> createRecipe({
    required String foodName,
    required String description,
    required int servings,
    required String category,
    required List<String> ingredients,
    required List<String> quantities,
    required List<String> instructions,
    required List<NutritionalContent> nutritionalContent,
    required String totalCookTime,
    required String difficulty,
    required String preparationTips,
    required String nutritionalParagraph,
  }) async {
    setBusy(true); // Indicates the ViewModel is busy

    // Create a recipe object
    final recipe = Recipe(
      foodName: foodName,
      description: description,
      servings: servings,
      category: category,
      ingredients: ingredients,
      quantities: quantities,
      instructions: instructions,
      nutritionalContent: nutritionalContent,
      totalCookTime: totalCookTime,
      difficulty: difficulty,
      preparationTips: preparationTips,
      nutritionalParagraph: nutritionalParagraph,
    );

    try {
      // Call the API to create the recipe
      final recipeResponse = await _apiService.createRecipe(recipe);

      if (recipeResponse != null) {
        _snackbarService.showSnackbar(
          message: 'Recipe created successfully!',
          duration: const Duration(seconds: 3),
        );
        // You can add navigation or other actions here if needed
      } else {
        _snackbarService.showSnackbar(
          message: 'Failed to create recipe. Please try again.',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'An error occurred: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false); // Indicates the ViewModel is no longer busy
    }
  }
}

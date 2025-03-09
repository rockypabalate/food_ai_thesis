import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/created_recipe/create_recipe.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateRecipeViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = locator<ApiServiceService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();

  // Controllers for input fields
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController servingsController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController totalCookTimeController = TextEditingController();
  final TextEditingController preparationTipsController =
      TextEditingController();
  final TextEditingController nutritionalParagraphController =
      TextEditingController(); // Added

  // Dynamic lists for ingredients, quantities, and instructions
  List<String> ingredients = [""];
  List<String> quantities = [""];
  List<String> instructions = [""];

  // Dropdown values
  String cookTimeUnit = "Minutes"; // Default value
  String difficultyLevel = "Easy"; // Default value

  void updateCookTimeUnit(String? value) {
    if (value != null) {
      cookTimeUnit = value;
      notifyListeners();
    }
  }

  void updateDifficultyLevel(String? value) {
    if (value != null) {
      difficultyLevel = value;
      notifyListeners();
    }
  }

  void addIngredient() {
    ingredients.add("");
    quantities.add("");
    notifyListeners();
  }

  void updateIngredient(int index, String value) {
    if (index < ingredients.length) {
      ingredients[index] = value;
      notifyListeners();
    }
  }

  void updateQuantity(int index, String value) {
    if (index < quantities.length) {
      quantities[index] = value;
      notifyListeners();
    }
  }

  void removeIngredient(int index) {
    if (index < ingredients.length) {
      ingredients.removeAt(index);
      quantities.removeAt(index);
      notifyListeners();
    }
  }

  void addInstruction() {
    instructions.add("");
    notifyListeners();
  }

  void updateInstruction(int index, String value) {
    if (index < instructions.length) {
      instructions[index] = value;
      notifyListeners();
    }
  }

  void removeInstruction(int index) {
    if (index < instructions.length) {
      instructions.removeAt(index);
      notifyListeners();
    }
  }

  bool validateInputs() {
    if (foodNameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        categoryController.text.isEmpty ||
        totalCookTimeController.text.isEmpty ||
        preparationTipsController.text.isEmpty ||
        ingredients.isEmpty ||
        quantities.isEmpty ||
        instructions.isEmpty) {
      _snackbarService.showSnackbar(
        message: "All fields are required!",
        duration: const Duration(seconds: 3),
      );
      return false;
    }
    return true;
  }

  Future<void> createRecipe() async {
    if (!validateInputs()) return;

    setBusy(true);

    final recipe = Recipe(
      id: 0, // Temporary ID
      foodName: foodNameController.text,
      description: descriptionController.text,
      servings: int.tryParse(servingsController.text) ?? 1,
      category: categoryController.text,
      ingredients: ingredients,
      quantities: quantities,
      instructions: instructions,
      totalCookTime: "${totalCookTimeController.text} $cookTimeUnit",
      difficulty: difficultyLevel,
      preparationTips: preparationTipsController.text,
      nutritionalParagraph: nutritionalParagraphController.text.isNotEmpty
          ? nutritionalParagraphController.text
          : null, // Optional
    );

    try {
      final recipeResponse = await _apiService.createRecipe(recipe);

      if (recipeResponse != null) {
        final createdRecipeId = recipeResponse.recipe.id;

        _snackbarService.showSnackbar(
          message: 'Recipe created successfully! Recipe ID: $createdRecipeId',
          duration: const Duration(seconds: 3),
        );

        _navigationService.navigateTo(
          Routes.uploadRecipeImageView,
          arguments: UploadRecipeImageViewArguments(recipeId: createdRecipeId),
        );

        resetForm();
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
      setBusy(false);
    }
  }

  void resetForm() {
    foodNameController.clear();
    descriptionController.clear();
    servingsController.clear();
    categoryController.clear();
    totalCookTimeController.clear();
    preparationTipsController.clear();
    nutritionalParagraphController.clear(); // Added

    ingredients = [""];
    quantities = [""];
    instructions = [""];

    cookTimeUnit = "Minutes";
    difficultyLevel = "Easy";

    notifyListeners();
  }

  @override
  void dispose() {
    foodNameController.dispose();
    descriptionController.dispose();
    servingsController.dispose();
    categoryController.dispose();
    totalCookTimeController.dispose();
    preparationTipsController.dispose();
    nutritionalParagraphController.dispose(); // Added
    super.dispose();
  }
}

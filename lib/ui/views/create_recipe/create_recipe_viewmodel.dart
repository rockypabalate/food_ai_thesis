import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/created_recipe/create_recipe.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateRecipeViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = locator<ApiServiceService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  // Controllers for input fields
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController servingsController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController totalCookTimeController = TextEditingController();
  final TextEditingController preparationTipsController =
      TextEditingController();
  final TextEditingController nutritionalParagraphController =
      TextEditingController();

  // Dynamic lists for ingredients, quantities, and instructions
  List<String> ingredients = [""];
  List<String> quantities = [""];
  List<String> instructions = [""];

  // Dropdown values
  String cookTimeUnit = "Minutes"; // Default value
  String difficultyLevel = "Easy"; // Default value

  // Nutritional Content List
  List<NutritionalContent> nutritionalContent = [];

  /// Method to update the cook time unit when dropdown is changed
  void updateCookTimeUnit(String? value) {
    if (value != null) {
      cookTimeUnit = value;
      notifyListeners();
    }
  }

  /// Method to update the difficulty level when dropdown is changed
  void updateDifficultyLevel(String? value) {
    if (value != null) {
      difficultyLevel = value;
      notifyListeners();
    }
  }

  /// Adds an ingredient and a corresponding quantity field
  void addIngredient() {
    ingredients.add("");
    quantities.add("");
    notifyListeners();
  }

  /// Updates an ingredient
  void updateIngredient(int index, String value) {
    if (index < ingredients.length) {
      ingredients[index] = value;
      notifyListeners();
    }
  }

  /// Updates a quantity
  void updateQuantity(int index, String value) {
    if (index < quantities.length) {
      quantities[index] = value;
      notifyListeners();
    }
  }

  /// Removes an ingredient and its corresponding quantity
  void removeIngredient(int index) {
    if (index < ingredients.length) {
      ingredients.removeAt(index);
      quantities.removeAt(index);
      notifyListeners();
    }
  }

  /// Adds a new instruction step
  void addInstruction() {
    instructions.add("");
    notifyListeners();
  }

  /// Updates an instruction
  void updateInstruction(int index, String value) {
    if (index < instructions.length) {
      instructions[index] = value;
      notifyListeners();
    }
  }

  /// Removes an instruction step
  void removeInstruction(int index) {
    if (index < instructions.length) {
      instructions.removeAt(index);
      notifyListeners();
    }
  }

  // Adds a new nutritional content field
  void addNutritionalContent() {
    nutritionalContent
        .add(NutritionalContent(name: "", amount: "")); // Add "amount"
    notifyListeners();
  }

  void updateNutritionalContent(int index, String name, String amount) {
    if (index < nutritionalContent.length) {
      nutritionalContent[index] =
          NutritionalContent(name: name, amount: amount);
      notifyListeners();
    }
  }

// Removes a nutritional content field
  void removeNutritionalContent(int index) {
    if (index < nutritionalContent.length) {
      nutritionalContent.removeAt(index);
      notifyListeners();
    }
  }

  /// Validates input fields before creating a recipe
  bool validateInputs() {
    print("Validating inputs...");

    // Print all field values for debugging
    print("Food Name: ${foodNameController.text}");
    print("Description: ${descriptionController.text}");
    print("Category: ${categoryController.text}");
    print("Total Cook Time: ${totalCookTimeController.text}");
    print("Preparation Tips: ${preparationTipsController.text}");
    print("Nutritional Paragraph: ${nutritionalParagraphController.text}");
    print(
        "Ingredients: ${ingredients.isNotEmpty ? ingredients.join(', ') : 'Empty'}");
    print(
        "Quantities: ${quantities.isNotEmpty ? quantities.join(', ') : 'Empty'}");
    print(
        "Instructions: ${instructions.isNotEmpty ? instructions.join(', ') : 'Empty'}");
    print(
        "Nutritional Content: ${nutritionalContent.isNotEmpty ? nutritionalContent.length.toString() : 'Empty'}");

    // Check for empty fields
    if (foodNameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        categoryController.text.isEmpty ||
        totalCookTimeController.text.isEmpty ||
        preparationTipsController.text.isEmpty ||
        nutritionalParagraphController.text.isEmpty ||
        ingredients.isEmpty ||
        quantities.isEmpty ||
        instructions.isEmpty ||
        nutritionalContent.isEmpty) {
      print("Validation failed: Some fields are empty!");

      _snackbarService.showSnackbar(
        message: "All fields are required!",
        duration: const Duration(seconds: 3),
      );
      return false;
    }

    print("Validation passed: All fields are filled.");
    return true;
  }

  /// Creates a recipe by sending data to the API
  Future<void> createRecipe() async {
    if (!validateInputs()) return; // Stop if validation fails

    setBusy(true); // Show loading state

    // Constructing the recipe object
    final recipe = Recipe(
      foodName: foodNameController.text,
      description: descriptionController.text,
      servings: int.tryParse(servingsController.text) ?? 1,
      category: categoryController.text,
      ingredients: ingredients,
      quantities: quantities,
      instructions: instructions,
      nutritionalContent: nutritionalContent,
      totalCookTime: "${totalCookTimeController.text} $cookTimeUnit",
      difficulty: difficultyLevel,
      preparationTips: preparationTipsController.text,
      nutritionalParagraph: nutritionalParagraphController.text,
    );

    try {
      final recipeResponse = await _apiService.createRecipe(recipe);

      if (recipeResponse != null) {
        _snackbarService.showSnackbar(
          message: 'Recipe created successfully!',
          duration: const Duration(seconds: 3),
        );

        // Optionally, clear all fields after successful creation
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

  /// Resets all form fields after successful recipe creation
  void resetForm() {
    foodNameController.clear();
    descriptionController.clear();
    servingsController.clear();
    categoryController.clear();
    totalCookTimeController.clear();
    preparationTipsController.clear();
    nutritionalParagraphController.clear();

    ingredients = [""];
    quantities = [""];
    instructions = [""];
    nutritionalContent = [];

    cookTimeUnit = "Minutes";
    difficultyLevel = "Easy";

    notifyListeners();
  }

  /// Dispose controllers when ViewModel is destroyed
  @override
  void dispose() {
    foodNameController.dispose();
    descriptionController.dispose();
    servingsController.dispose();
    categoryController.dispose();
    totalCookTimeController.dispose();
    preparationTipsController.dispose();
    nutritionalParagraphController.dispose();
    super.dispose();
  }
}

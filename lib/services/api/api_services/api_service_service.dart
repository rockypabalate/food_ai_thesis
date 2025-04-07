import 'dart:io';

import 'package:food_ai_thesis/models/created_recipe/create_recipe.dart';
import 'package:food_ai_thesis/models/display_created_recipe/display_user_recipe.dart';
import 'package:food_ai_thesis/models/list_recipes/featured_recipe_model.dart';
import 'package:food_ai_thesis/models/list_recipes/list_recipes.dart';
import 'package:food_ai_thesis/models/list_recipes/popular_recipe_model.dart';
import 'package:food_ai_thesis/models/list_recipes/single_display_recipe.dart';
import 'package:food_ai_thesis/models/saved_recipe_by_user/saved_recipe_by_user.dart';
import 'package:food_ai_thesis/models/search_recipe_name/food_description.dart';
import 'package:food_ai_thesis/models/single_view_created_recipe/single_view_created_recipe.dart';

abstract class ApiServiceService {
  Future<List<FoodInfo>> getAllFoodInfo();
  Future<FoodInfoById?> getFoodInfoById(int foodId);
  Future<bool> saveFoodById(int foodId);
  Future<bool> incrementLike(int foodId);
  Future<bool> incrementView(int foodId);
  Future<List<SavedFood>> getSavedRecipesByUser();
  Future<bool> deleteFoodById(int foodId);
  Future<List<FoodInformation>> searchRecipesByName(String foodName);
  Future<RecipeResponse?> createRecipe(Recipe recipe);
  Future<String?> uploadRecipeImage(int recipeId, File imageFile);
  Future<List<UserRecipe>?> fetchAllRecipes();
  Future<SingleDisplayRecipe?> fetchSingleRecipe(String recipeId);
  Future<bool> deleteRecipe(String recipeId);
  Future<List<FeaturedRecipe>> getFeaturedRecipes();
  Future<List<PopularRecipe>> getPopularRecipes();
  Future<String?> classifyFood(File imageFile);
  Future<bool> isRecipeLiked(int foodId);
  Future<bool> isRecipeSaved(int foodId);
}

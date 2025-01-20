import 'package:food_ai_thesis/models/list_recipes/list_recipes.dart';
import 'package:food_ai_thesis/models/list_recipes/single_display_recipe.dart';
import 'package:food_ai_thesis/models/saved_recipe_by_user/saved_recipe_by_user.dart';
import 'package:food_ai_thesis/models/search_recipe_name/food_description.dart';

abstract class ApiServiceService {
  Future<List<FoodInfo>> getAllFoodInfo();
  Future<FoodInfoById?> getFoodInfoById(int foodId);
  Future<bool> saveFoodById(int foodId);
  Future<bool> incrementLike(int foodId);
  Future<bool> incrementView(int foodId);
  Future<List<SavedFood>> getSavedRecipesByUser();
  Future<bool> deleteFoodById(int foodId);
  Future<List<FoodInformation>> searchRecipesByName(String foodName);
}

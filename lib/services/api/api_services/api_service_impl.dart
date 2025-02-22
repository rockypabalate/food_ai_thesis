import 'dart:io';

import 'package:dio/dio.dart';
import 'package:food_ai_thesis/models/created_recipe/create_recipe.dart';
import 'package:food_ai_thesis/models/display_created_recipe/display_user_recipe.dart';
import 'package:food_ai_thesis/models/list_recipes/list_recipes.dart';
import 'package:food_ai_thesis/models/list_recipes/single_display_recipe.dart';
import 'package:food_ai_thesis/models/saved_recipe_by_user/saved_recipe_by_user.dart';
import 'package:food_ai_thesis/models/search_recipe_name/food_description.dart';
import 'package:food_ai_thesis/models/single_view_created_recipe/single_view_created_recipe.dart';
import 'package:food_ai_thesis/services/api/helpers/dio_client.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServiceImpl implements ApiServiceService {
  ApiServiceImpl({
    Dio? dio,
  }) : _dio = dio ?? DioClient().instance;

  final Dio _dio;

  static const String bearerTokenKey = 'bearerToken';

  @override
  Future<List<FoodInfo>> getAllFoodInfo() async {
    try {
      final response = await _dio.get(
        '/recipes/all',
        options: Options(
          headers: {
            'accept': 'application/json',
          },
        ),
      );

      List<dynamic> data = response.data;
      List<FoodInfo> foodInfoList =
          data.map((json) => FoodInfo.fromJson(json)).toList();

      return foodInfoList;
    } on DioException catch (e) {
      if (e.response != null) {
        // Log error details with server response
        print('Dio Error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        // Log Dio error without server response
        print('Dio Error: ${e.message}');
      }
      return [];
    } catch (e) {
      print('Unexpected Error: ${e.toString()}');
      return [];
    }
  }

  @override
  Future<bool> saveFoodById(int foodId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(bearerTokenKey);

      if (token == null) {
        print('Unauthorized: No Bearer token');
        return false;
      }

      // Make POST request to save the recipe
      final response = await _dio.post(
        '/recipes/save-recipe',
        queryParameters: {
          'foodId': foodId,
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer $token', // Include 'Bearer' prefix for the token
            'accept': 'application/json',
          },
        ),
      );

      switch (response.statusCode) {
        case 201: // Food saved successfully
          print('Food saved successfully');
          return true;
        case 409: // Recipe already saved
          print('Recipe already saved');
          return false;
        case 404: // Food not found
          print('Food not found');
          return false;
        default: // Other errors
          print('Error saving food: ${response.statusCode} - ${response.data}');
          return false;
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.response != null) {
        print('Dio Error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        print('Dio Error: ${e.message}');
      }
      return false;
    } catch (e) {
      // Handle unexpected errors
      print('Unexpected Error: ${e.toString()}');
      return false;
    }
  }

  @override
  Future<bool> incrementLike(int foodId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(bearerTokenKey);

      if (token == null) {
        print('Unauthorized: No Bearer token');
        return false;
      }

      // Make PUT request to increment likes
      final response = await _dio.put(
        '/recipes/increment-likes/$foodId',
        options: Options(
          headers: {
            'Authorization':
                'Bearer $token', // Include 'Bearer' prefix for the token
            'accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Likes incremented successfully');
        return true;
      } else if (response.statusCode == 400) {
        print('Already liked');
        return false; // User already liked
      } else {
        print(
            'Error incrementing likes: ${response.statusCode} - ${response.data}');
        return false;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio Error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        print('Dio Error: ${e.message}');
      }
      return false;
    } catch (e) {
      print('Unexpected Error: ${e.toString()}');
      return false;
    }
  }

  @override
  Future<FoodInfoById?> getFoodInfoById(int foodId) async {
    try {
      // Fetch the food details
      final response = await _dio.get(
        '/recipes/get-recipe/$foodId',
        options: Options(
          headers: {
            'accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Response Data: ${response.data}');

        // Increment view count after successfully fetching the food info
        final incrementSuccess = await incrementView(foodId);
        if (!incrementSuccess) {
          print('View increment skipped (already viewed or error).');
        }

        // Deserialize the JSON into a Dart object
        return FoodInfoById.fromJson(response.data);
      } else {
        print('Error fetching food info: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('Dio Error: ${e.message}');
      return null;
    } catch (e) {
      print('Unexpected Error: ${e.toString()}');
      return null;
    }
  }

  @override
  Future<bool> incrementView(int foodId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(bearerTokenKey);

      if (token == null) {
        print('Unauthorized: No Bearer token');
        return false;
      }

      // Make PUT request to increment views
      final response = await _dio.put(
        '/recipes/increment-views/$foodId',
        options: Options(
          headers: {
            'Authorization':
                'Bearer $token', // Include 'Bearer' prefix for the token
            'accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Views incremented successfully');
        return true;
      } else if (response.statusCode == 400) {
        print('Already viewed');
        return false; // User already viewed
      } else {
        print(
            'Error incrementing views: ${response.statusCode} - ${response.data}');
        return false;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio Error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        print('Dio Error: ${e.message}');
      }
      return false;
    } catch (e) {
      print('Unexpected Error: ${e.toString()}');
      return false;
    }
  }

  @override
  Future<List<SavedFood>> getSavedRecipesByUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(bearerTokenKey);

      if (token == null) {
        throw Exception('Unauthorized: No Bearer token');
      }

      final response = await _dio.get(
        '/recipes/saved-by-user',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': 'application/json',
          },
        ),
      );

      // Check if response status is successful
      if (response.statusCode == 200) {
        // Parsing the response data to a List of SavedFood
        List<dynamic> data = response.data;
        List<SavedFood> savedFoodsList =
            data.map((json) => SavedFood.fromJson(json)).toList();
        return savedFoodsList;
      } else if (response.statusCode == 404) {
        print('No saved recipes found for the user');
        return [];
      } else {
        print('Error fetching saved recipes: ${response.statusCode}');
        return [];
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio Error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        print('Dio Error: ${e.message}');
      }
      return [];
    } catch (e) {
      print('Unexpected Error: ${e.toString()}');
      return [];
    }
  }

  @override
  Future<bool> deleteFoodById(int foodId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(bearerTokenKey);

      if (token == null) {
        print('Unauthorized: No Bearer token');
        return false;
      }

      // Perform the DELETE request
      final response = await _dio.delete(
        '/recipes/delete', // Updated endpoint to match backend
        queryParameters: {
          'foodId': foodId, // Pass foodId as a query parameter
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer $token', // Ensure 'Bearer' prefix is included
            'accept': 'application/json',
          },
        ),
      );

      // Handle response status codes
      if (response.statusCode == 200) {
        print('Food deleted successfully');
        return true;
      } else if (response.statusCode == 404) {
        print('Food not found in saved recipes');
        return false;
      } else {
        print('Error deleting food: ${response.statusCode}');
        return false;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio Error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        print('Dio Error: ${e.message}');
      }
      return false;
    } catch (e) {
      print('Unexpected Error: ${e.toString()}');
      return false;
    }
  }

  @override
  Future<List<FoodInformation>> searchRecipesByName(String foodName) async {
    try {
      final response = await _dio.get(
        '/recipes/recipe-name-search',
        queryParameters: {'food_name': foodName},
        options: Options(
          headers: {
            'accept': 'application/json',
          },
        ),
      );

      List<dynamic> data = response.data;
      List<FoodInformation> foodInfoList =
          data.map((json) => FoodInformation.fromJson(json)).toList();

      return foodInfoList;
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio Error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        print('Dio Error: ${e.message}');
      }
      return [];
    } catch (e) {
      print('Unexpected Error: ${e.toString()}');
      return [];
    }
  }

  @override
  Future<RecipeResponse?> createRecipe(Recipe recipe) async {
    try {
      // Get the user authentication token
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(bearerTokenKey);

      if (token == null) {
        print('Unauthorized: No Bearer token');
        return null;
      }

      // Prepare the payload for the request
      final data = {
        "food_name": recipe.foodName,
        "description": recipe.description,
        "servings": recipe.servings,
        "category": recipe.category,
        "ingredients": recipe.ingredients,
        "quantities": recipe.quantities,
        "instructions": recipe.instructions,
        "nutritional_content": recipe.nutritionalContent
            .map((e) => {
                  "name": e.name,
                  "amount": e.amount,
                })
            .toList(),
        "total_cook_time": recipe.totalCookTime,
        "difficulty": recipe.difficulty,
        "preparation_tips": recipe.preparationTips,
        "nutritional_paragraph": recipe.nutritionalParagraph,
      };

      // Debugging the payload
      print('Creating recipe with data: $data');

      // Make the POST request
      final response = await _dio.post(
        '/recipes/user-recipe/create-recipe',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': 'application/json',
          },
        ),
      );

      // Debugging the response
      print('API Response Status Code: ${response.statusCode}');
      print('API Response Data: ${response.data}');

      // Parse the response
      if (response.statusCode == 200) {
        final recipeResponse = RecipeResponse.fromJson(response.data);

        // Debugging the parsed response
        print('Parsed Recipe Response: ${recipeResponse.toJson()}');
        print('Extracted Recipe ID: ${recipeResponse.recipe.id}');

        return recipeResponse;
      } else {
        print(
            'Failed to create recipe: ${response.statusCode} - ${response.data}');
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio Error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        print('Dio Error: ${e.message}');
      }
      return null;
    } catch (e) {
      print('Unexpected Error: ${e.toString()}');
      return null;
    }
  }

  Future<String?> uploadRecipeImage(int recipeId, File imageFile) async {
    try {
      // Get the user authentication token
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(bearerTokenKey);

      if (token == null) {
        print('Unauthorized: No Bearer token');
        return null;
      }

      // Prepare the form data for the image upload
      final formData = FormData.fromMap({
        'recipeImage': await MultipartFile.fromFile(imageFile.path,
            filename: imageFile.path.split('/').last),
      });

      // Make the POST request to upload the image
      final response = await _dio.post(
        '/images/upload/recipe/$recipeId',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': 'application/json',
          },
        ),
      );

      // Parse the response
      if (response.statusCode == 200) {
        return response.data['image_url']; // Return the uploaded image URL
      } else {
        print(
            'Failed to upload recipe image: ${response.statusCode} - ${response.data}');
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio Error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        print('Dio Error: ${e.message}');
      }
      return null;
    } catch (e) {
      print('Unexpected Error: ${e.toString()}');
      return null;
    }
  }

  @override
  Future<List<UserRecipe>?> fetchAllRecipes() async {
    try {
      // Get the user authentication token
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(bearerTokenKey);

      if (token == null) {
        print('Unauthorized: No Bearer token');
        return null;
      }

      // Make the GET request
      final response = await _dio.get(
        '/recipes/user-recipe/all',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': 'application/json',
          },
        ),
      );

      // Debugging response
      print('API Response Status Code: ${response.statusCode}');
      print('API Response Data: ${response.data}');

      // Parse the response
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<UserRecipe> recipes =
            data.map((json) => UserRecipe.fromJson(json)).toList();

        // Debugging parsed data
        print('Fetched Recipes Count: ${recipes.length}');

        return recipes;
      } else {
        print(
            'Failed to fetch recipes: ${response.statusCode} - ${response.data}');
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio Error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        print('Dio Error: ${e.message}');
      }
      return null;
    } catch (e) {
      print('Unexpected Error: ${e.toString()}');
      return null;
    }
  }

  @override
  Future<SingleDisplayRecipe?> fetchSingleRecipe(String recipeId) async {
    try {
      // Get the user authentication token
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(bearerTokenKey);

      if (token == null) {
        print('Unauthorized: No Bearer token');
        return null;
      }

      // Make the GET request
      final response = await _dio.get(
        '/recipes/user-recipe/single-recipe/$recipeId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': 'application/json',
          },
        ),
      );

      // Debugging response
      print('API Response Status Code: ${response.statusCode}');
      print('API Response Data: ${response.data}');

      // Parse the response
      if (response.statusCode == 200) {
        final data = response.data;
        final singleRecipe = SingleDisplayRecipe.fromJson(data);

        // Debugging parsed data
        print('Fetched Recipe: ${singleRecipe.foodName}');

        return singleRecipe;
      } else {
        print(
            'Failed to fetch recipe: ${response.statusCode} - ${response.data}');
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio Error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        print('Dio Error: ${e.message}');
      }
      return null;
    } catch (e) {
      print('Unexpected Error: ${e.toString()}');
      return null;
    }
  }

  @override
  Future<bool> deleteRecipe(String recipeId) async {
    try {
      // Get the user authentication token
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(bearerTokenKey);

      if (token == null) {
        print('Unauthorized: No Bearer token');
        return false;
      }

      // Make the DELETE request
      final response = await _dio.delete(
        '/recipes/user-recipe/delete-recipe/$recipeId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': 'application/json',
          },
        ),
      );

      // Debugging response
      print('API Response Status Code: ${response.statusCode}');
      print('API Response Data: ${response.data}');

      // Check if the deletion was successful
      if (response.statusCode == 200) {
        print('Recipe deleted successfully');
        return true;
      } else {
        print(
            'Failed to delete recipe: ${response.statusCode} - ${response.data}');
        return false;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio Error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        print('Dio Error: ${e.message}');
      }
      return false;
    } catch (e) {
      print('Unexpected Error: ${e.toString()}');
      return false;
    }
  }
}

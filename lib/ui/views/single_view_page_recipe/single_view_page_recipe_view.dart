import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import SpinKit package
import 'package:food_ai_thesis/ui/views/display_single_recipe/export_pdf_UI.dart';
import 'package:food_ai_thesis/ui/views/single_view_page_recipe/created_recipe_export.dart';
import 'package:food_ai_thesis/utils/widgets_fade_effect.dart';
import 'package:stacked/stacked.dart';
import 'recipe_details.dart'; // Import the new UI design file
import 'single_view_page_recipe_viewmodel.dart';

class SingleViewPageRecipeView
    extends StackedView<SingleViewPageRecipeViewModel> {
  final String recipeId;

  const SingleViewPageRecipeView({Key? key, required this.recipeId})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SingleViewPageRecipeViewModel viewModel,
    Widget? child,
  ) {
    // Show loading spinner and message based on the viewModel's busy state
    if (viewModel.isBusy) {
      return Scaffold(
        backgroundColor:
            Colors.white, // Set the background of the scaffold to white
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SpinKitThreeBounce(
                color: Colors.orange, // Change the spinner color to orange
                size: 40.0,
              ),
              const SizedBox(height: 16),
              // Display dynamic message based on delete status
              Text(
                viewModel.isDeleting
                    ? 'Deleting Recipe...'
                    : 'Fetching Recipe...',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final recipe = viewModel.singleRecipe;

    // If recipe is null, show error message
    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Recipe Details')),
        body: const Center(child: Text('Failed to load recipe details.')),
      );
    }

    return Scaffold(
      backgroundColor:
          Colors.white, // Set the background of the scaffold to white
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          recipe.foodName,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
            onPressed: () {
              Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePdfExportPage(recipe: viewModel.singleRecipe!),
      ),
    );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              viewModel.deleteRecipe(recipe.id);
            },
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeEffectRecipe(
              delay: 200,
              child: SizedBox(
                height: 200,
                child: recipe.images.isNotEmpty
                    ? PageView(
                        children: recipe.images.map((imageUrl) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image_not_supported,
                                        size: 100, color: Colors.grey),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    : GestureDetector(
                        onTap: () {
                          viewModel.navigateToUploadImage(recipe.id);
                        },
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: const Center(
                            child: Icon(Icons.add,
                                size: 50, color: Colors.black54),
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            FadeEffectRecipe(
              delay: 300,
              child: Text(
                recipe.foodName,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            FadeEffectRecipe(
              delay: 400,
              child: Text(
                recipe.description,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),

            // Recipe Details
            FadeEffectRecipe(
              delay: 500,
              child: _buildDetailRow('Category', recipe.category),
            ),
            FadeEffectRecipe(
              delay: 600,
              child: _buildDetailRow('Servings', recipe.servings.toString()),
            ),
            FadeEffectRecipe(
              delay: 600,
              child: _buildDetailRow('Cook Time', recipe.totalCookTime),
            ),
            FadeEffectRecipe(
              delay: 800,
              child: _buildDetailRow('Difficulty', recipe.difficulty),
            ),
            const SizedBox(height: 16),

            // Ingredient, Preparation Tips, Instructions, and Nutritional Information
            RecipeDetailsSection(
              ingredients: recipe.ingredients,
              quantities: recipe.quantities,
              preparationTips: recipe.preparationTips,
              instructions: recipe.instructions,
              nutritionalParagraph: recipe.nutritionalParagraph,
            ),
          ],
        ),
      ),
    );
  }

  @override
  SingleViewPageRecipeViewModel viewModelBuilder(BuildContext context) =>
      SingleViewPageRecipeViewModel();

  @override
  void onViewModelReady(SingleViewPageRecipeViewModel viewModel) {
    viewModel.fetchSingleRecipe(recipeId);
    super.onViewModelReady(viewModel);
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
    if (viewModel.isBusy) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final recipe = viewModel.singleRecipe;

    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Recipe Details')),
        body: const Center(child: Text('Failed to load recipe details.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          recipe.foodName,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              // TODO: Implement edit functionality
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
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
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
                          child:
                              Icon(Icons.add, size: 50, color: Colors.black54),
                        ),
                      ),
                    ),
            ),

            const SizedBox(height: 12),
            // Recipe Title and Description
            Text(
              recipe.foodName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              recipe.description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Recipe Details
            _buildDetailRow('Category', recipe.category),
            _buildDetailRow('Servings', recipe.servings.toString()),
            _buildDetailRow('Cook Time', recipe.totalCookTime),
            _buildDetailRow('Difficulty', recipe.difficulty),
            const SizedBox(height: 16),

            // Ingredients Section
            // Ingredients Section
            _buildSectionTitle('Ingredients'),
            ...List.generate(recipe.ingredients.length, (index) {
              String ingredient = recipe.ingredients[index];
              String quantity = (index < recipe.quantities.length)
                  ? recipe.quantities[index]
                  : 'N/A'; // Default to "N/A" instead of "Unknown"

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  '- $ingredient: $quantity',
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }),

            const SizedBox(height: 16),

            // Preparation Tips
            if (recipe.preparationTips.isNotEmpty)
              _buildSectionWithContent(
                  'Preparation Tips', recipe.preparationTips),
            const SizedBox(height: 16),

            // Instructions Section
            _buildSectionTitle('Instructions'),
            ..._buildListItems(
              recipe.instructions
                  .map((instruction) => ' $instruction')
                  .toList(),
            ),
            const SizedBox(height: 16),

            // Nutritional Paragraph
            if (recipe.nutritionalParagraph.isNotEmpty)
              _buildSectionWithContent(
                  'Nutritional Information', recipe.nutritionalParagraph),
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

  // Helper to build a detail row
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

  // Helper to build section title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  // Helper to build a section with content
  Widget _buildSectionWithContent(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Helper to build a list of items
  List<Widget> _buildListItems(List<String> items) {
    return items
        .map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                item,
                style: const TextStyle(fontSize: 16),
              ),
            ))
        .toList();
  }
}

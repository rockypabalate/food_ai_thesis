import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/export_pdf_UI.dart';
import 'package:food_ai_thesis/ui/views/single_view_page_recipe/created_recipe_export.dart';
import 'package:food_ai_thesis/utils/widgets_fade_effect.dart';
import 'package:stacked/stacked.dart';
import 'recipe_details.dart';
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
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SpinKitThreeBounce(
                color: Colors.orange,
                size: 40.0,
              ),
              const SizedBox(height: 16),
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
        appBar: AppBar(
          title: const Text('Recipe Details'),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.orange.withOpacity(0.7),
              ),
              const SizedBox(height: 16),
              const Text(
                'Failed to load recipe details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => viewModel.fetchSingleRecipe(recipeId),
                child: const Text('Try Again'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Modern SliverAppBar with recipe image as background
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.orange,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Recipe image or placeholder
                  recipe.images.isNotEmpty
                      ? Image.network(
                          recipe.images[0],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.orange.withOpacity(0.2),
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 64,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            viewModel.navigateToUploadImage(recipe.id);
                          },
                          child: Container(
                            color: Colors.orange.withOpacity(0.2),
                            child: const Icon(
                              Icons.add_photo_alternate,
                              size: 64,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  // Gradient overlay for better text visibility
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.6, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                recipe.foodName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              collapseMode: CollapseMode.pin,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                tooltip: 'Export as PDF',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatePdfExportPage(recipe: recipe),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.white),
                tooltip: 'Delete Recipe',
                onPressed: () {
                  // Show confirmation dialog before deleting
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Delete Recipe'),
                        content: const Text(
                            'Are you sure you want to delete this recipe?'),
                        actions: [
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              viewModel.deleteRecipe(recipe.id);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),

          // Recipe Info - Quick Stats
          SliverToBoxAdapter(
            child: FadeEffectRecipe(
              delay: 300,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoChip(Icons.category_outlined, recipe.category),
                    _buildInfoChip(Icons.people_alt_outlined,
                        "${recipe.servings} servings"),
                    _buildInfoChip(Icons.timer_outlined, recipe.totalCookTime),
                    _buildInfoChip(Icons.bar_chart, recipe.difficulty),
                  ],
                ),
              ),
            ),
          ),

          // Recipe Description
          if (recipe.description.isNotEmpty)
            SliverToBoxAdapter(
              child: FadeEffectRecipe(
                delay: 400,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.restaurant, color: Colors.orange),
                            SizedBox(width: 8),
                            Text(
                              'About This Recipe',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          recipe.description,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Recipe carousel for multiple images
          if (recipe.images.length > 1)
            SliverToBoxAdapter(
              child: FadeEffectRecipe(
                delay: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.photo_library, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(
                            'Photos (${recipe.images.length})',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: recipe.images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                recipe.images[index],
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 120,
                                  height: 120,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image_not_supported,
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

          // Recipe Details Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: RecipeDetailsSection(
                ingredients: recipe.ingredients,
                quantities: recipe.quantities,
                preparationTips: recipe.preparationTips,
                instructions: recipe.instructions,
                nutritionalParagraph: recipe.nutritionalParagraph,
              ),
            ),
          ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // You can add functionality here, like sharing the recipe
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Feature coming soon!')),
          );
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.share, color: Colors.white),
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

  Widget _buildInfoChip(IconData icon, String text) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.orange,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

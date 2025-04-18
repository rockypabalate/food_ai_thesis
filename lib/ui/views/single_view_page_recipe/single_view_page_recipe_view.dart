import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/export_pdf_UI.dart';
import 'package:food_ai_thesis/ui/views/single_view_page_recipe/created_recipe_export.dart';
import 'package:food_ai_thesis/utils/widgets_fade_effect.dart';
import 'package:stacked/stacked.dart';
import 'recipe_details.dart';
import 'single_view_page_recipe_viewmodel.dart';

// Modern color scheme
class AppColors {
  static const Color primary = Colors.orange; // Deep purple primary
  static const Color secondary = Colors.orange; // Teal secondary
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF5F5F5); // Light gray surface
  static const Color error = Color(0xFFB00020); // Error red
  static const Color onPrimary = Colors.white;
  static const Color onBackground = Color(0xFF121212); // Near black text
  static const Color cardBackground = Color(0xFFFAFAFA); // Slightly off-white
}

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
    final recipe = viewModel.singleRecipe;

    // Show loading screen only for fetching
    if (viewModel.isBusy && !viewModel.isDeleting) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitThreeBounce(
                color: AppColors.primary,
                size: 40.0,
              ),
              SizedBox(height: 16),
              Text(
                'Fetching Recipe...',
                style: TextStyle(
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

    // If recipe is null, show error message
    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Recipe Details'),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.error.withOpacity(0.7),
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
                  foregroundColor: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                backgroundColor: AppColors.primary,
                leading: IconButton(
                  icon:
                      const Icon(Icons.arrow_back, color: AppColors.onPrimary),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: GestureDetector(
                    onTap: () {
                      if (recipe.images.isEmpty) {
                        viewModel.navigateToUploadImage(recipe.id);
                      }
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        recipe.images.isNotEmpty
                            ? Image.network(
                                recipe.images[0],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  color: AppColors.primary.withOpacity(0.2),
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    size: 64,
                                    color: AppColors.onPrimary,
                                  ),
                                ),
                              )
                            : Container(
                                color: AppColors.primary.withOpacity(0.2),
                                child: const Icon(
                                  Icons.add_photo_alternate,
                                  size: 64,
                                  color: AppColors.onPrimary,
                                ),
                              ),
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
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.picture_as_pdf,
                        color: AppColors.onPrimary),
                    tooltip: 'Export as PDF',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CreatePdfExportPage(recipe: recipe),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: AppColors.onPrimary),
                    tooltip: 'Delete Recipe',
                    onPressed: () {
                      viewModel.deleteRecipe(recipe.id);
                    },
                  ),
                ],
              ),
              // New: Recipe title outside of AppBar
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.transparent, // Set to transparent
                  padding: const EdgeInsets.fromLTRB(16, 20, 20, 16),
                  child: Text(
                    recipe.foodName,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: FadeEffectRecipe(
                  delay: 300,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0), // Add spacing on left and right
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildInfoChip(
                              Icons.category_outlined, recipe.category),
                          _buildInfoChip(Icons.people_alt_outlined,
                              "${recipe.servings} servings"),
                          _buildInfoChip(
                              Icons.timer_outlined, recipe.totalCookTime),
                          _buildInfoChip(Icons.bar_chart, recipe.difficulty),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (recipe.description.isNotEmpty)
                SliverToBoxAdapter(
                  child: FadeEffectRecipe(
                    delay: 400,
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 16.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.restaurant,
                                    color: AppColors.primary),
                                SizedBox(width: 8),
                                Text(
                                  'About This Recipe',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              recipe.description,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: AppColors.onBackground,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (recipe.images.length > 1)
                SliverToBoxAdapter(
                  child: FadeEffectRecipe(
                    delay: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(18.0, 0, 18.0, 12.0),
                          child: Row(
                            children: [
                              const Icon(Icons.photo_library,
                                  color: AppColors.primary),
                              const SizedBox(width: 8),
                              Text(
                                'Photos (${recipe.images.length})',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 140,
                          child: ListView.builder(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            scrollDirection: Axis.horizontal,
                            itemCount: recipe.images.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Image.network(
                                      recipe.images[index],
                                      width: 140,
                                      height: 140,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                        width: 140,
                                        height: 140,
                                        color: Colors.grey[300],
                                        child: const Icon(
                                            Icons.image_not_supported,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
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
              const SliverToBoxAdapter(
                child: SizedBox(height: 80),
              ),
            ],
          ),

          // Deletion Overlay
          if (viewModel.isDeleting)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SpinKitThreeBounce(
                      color: AppColors.secondary,
                      size: 40.0,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Deleting Recipe...',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Feature coming soon!')),
          );
        },
        backgroundColor: AppColors.secondary,
        icon: const Icon(Icons.share, color: Colors.black87),
        label: const Text('Share', style: TextStyle(color: Colors.black87)),
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
          color: AppColors.primary,
          size: 24,
        ),
        const SizedBox(height: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.onBackground.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

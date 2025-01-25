import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/dashboard_recipes/widget_categories.dart';
import 'package:food_ai_thesis/ui/views/dashboard_recipes/widget_dashboard_header.dart';
import 'package:food_ai_thesis/ui/views/dashboard_recipes/widget_featured_recipe.dart';
import 'package:food_ai_thesis/ui/views/dashboard_recipes/widget_filipino_recipe.dart';
import 'package:food_ai_thesis/ui/views/dashboard_recipes/widget_liked_viewed_recipes.dart';
import 'package:food_ai_thesis/ui/views/seeall_featured_recipes/seeall_featured_recipes_view.dart';
import 'package:food_ai_thesis/ui/views/seeall_liked_viewed_recipes/seeall_liked_viewed_recipes_view.dart';
import 'package:stacked/stacked.dart';

import 'dashboard_recipes_viewmodel.dart';

class DashboardRecipesView extends StackedView<DashboardRecipesViewModel> {
  const DashboardRecipesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DashboardRecipesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          DashboardHeader(
            profileImage: viewModel.profileImage,
            username: viewModel.username,
          ),
          const SizedBox(height: 8),
          // Main Scrollable Content
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0),
              children: [
                _SectionTitle(
                  title: 'Filipino Recipes',
                  onSeeAllTap: () {
                    // Add navigation logic here
                  },
                ),
                FilipinoRecipeListWidget(
                  foodInfos: viewModel.foodInfos,
                  isLoading: viewModel.isLoading,
                ),
                const SizedBox(height: 12),
                _SectionTitle(
                  title: 'Most Liked & Viewed Recipes',
                  onSeeAllTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SeeallLikedViewedRecipesView(),
                      ),
                    );
                  },
                ),
                MostViewedAndLikedRecipesWidget(
                  mostViewedAndLikedRecipes:
                      viewModel.mostViewedAndLikedRecipes,
                  isLoading: viewModel.isLoading,
                ),
                const SizedBox(height: 12),
                _SectionTitle(
                  title: 'Featured Recipes',
                  onSeeAllTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SeeallFeaturedRecipesView(),
                      ),
                    );
                  },
                ),
                FeaturedRecipeListWidget(
                  featuredRecipes: viewModel.featuredRecipes,
                  isLoading: viewModel.isLoading,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  DashboardRecipesViewModel viewModelBuilder(BuildContext context) =>
      DashboardRecipesViewModel();

  @override
  void onViewModelReady(DashboardRecipesViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.getAllFoodInfo(); // Fetch food information when the view is ready
  }
}

// Custom Widget for Section Titles with See All Button
class _SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllTap;

  const _SectionTitle({
    Key? key,
    required this.title,
    required this.onSeeAllTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: onSeeAllTap,
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 0), // Adjust the space
                  child: Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.orange,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 1.0, // Thickness of the underline
                      color: Colors.orange, // Color of the underline
                      margin:
                          const EdgeInsets.only(top: 0.0), // Adjust the spacing
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

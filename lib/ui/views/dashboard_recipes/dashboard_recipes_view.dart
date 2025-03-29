import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_ai_thesis/ui/views/dashboard_recipes/tilt.dart';
import 'package:food_ai_thesis/ui/views/dashboard_recipes/widget_dashboard_header.dart';
import 'package:food_ai_thesis/ui/views/dashboard_recipes/widget_featured_recipe.dart';
import 'package:food_ai_thesis/ui/views/dashboard_recipes/widget_filipino_recipe.dart';
import 'package:food_ai_thesis/ui/views/dashboard_recipes/widget_liked_viewed_recipes.dart';

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
    return WillPopScope(
      onWillPop: () async {
        // Prevent back navigation
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: TiltingFab(
          onPressed: () {
            viewModel.navigateToImageProcessing();
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section (No animation)
            DashboardHeader(
              profileImage: viewModel.profileImage,
              username: viewModel.username,
            ),
            const SizedBox(height: 8),
            // Main Scrollable Content
            Expanded(
              child: viewModel.isLoading
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SpinKitThreeBounce(
                            color: Colors.orange,
                            size: 30.0,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Fetching recipes...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      children: [
                        _SectionTitle(
                            title: 'Filipino Recipes', onSeeAllTap: () {}),
                        FilipinoRecipeListWidget(
                          foodInfos: viewModel.foodInfos,
                          isLoading: viewModel.isLoading,
                        ),
                        const SizedBox(height: 5),
                        _SectionTitle(
                            title: 'Featured Recipes', onSeeAllTap: () {}),
                        FeaturedRecipeListWidget(
                          featuredRecipes: viewModel.featuredRecipes,
                          isLoading: viewModel.isLoading,
                        ),
                        const SizedBox(height: 5),
                        _SectionTitle(
                            title: 'Most Liked & Viewed Recipes',
                            onSeeAllTap: () {}),
                        MostViewedAndLikedRecipesWidget(
                          mostViewedAndLikedRecipes:
                              viewModel.mostViewedAndLikedRecipes,
                          isLoading: viewModel.isLoading,
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
            ),
          ],
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

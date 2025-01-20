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
          // Display the dashboard header with user info
          DashboardHeader(
            profileImage: viewModel.profileImage,
            username: viewModel.username,
          ),
          // Category section
          const CategoriesWidget(),
          const SizedBox(height: 0),
          // Scrollable content below the header
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe list section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filipino Recipes',
                          style: TextStyle(
                            fontSize: 21.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FilipinoRecipeListWidget(
                    foodInfos: viewModel.foodInfos,
                    isLoading: viewModel.isLoading,
                  ),
                  // Recipe list section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Featured Recipes',
                              style: TextStyle(
                                fontSize: 21.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SeeallFeaturedRecipesView(),
                                  ),
                                );
                              },
                              child: const Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FeaturedRecipeListWidget(
                        featuredRecipes: viewModel.featuredRecipes,
                        isLoading: viewModel.isLoading,
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Most Liked & Viewed Recipes',
                              style: TextStyle(
                                fontSize: 21.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SeeallLikedViewedRecipesView(),
                                  ),
                                );
                              },
                              child: const Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      MostViewedAndLikedRecipesWidget(
                        mostViewedAndLikedRecipes:
                            viewModel.mostViewedAndLikedRecipes,
                        isLoading: viewModel.isLoading,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
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

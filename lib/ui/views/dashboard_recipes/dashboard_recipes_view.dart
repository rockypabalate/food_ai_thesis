import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:food_ai_thesis/ui/views/dashboard_recipes/tilt.dart';
import 'package:food_ai_thesis/ui/views/dashboard_recipes/widget_dashboard_header.dart';
import 'package:food_ai_thesis/ui/views/dashboard_recipes/widget_featured_recipe.dart';
import 'package:food_ai_thesis/ui/views/dashboard_recipes/widget_filipino_recipe.dart';
import 'package:food_ai_thesis/ui/views/dashboard_recipes/widget_liked_viewed_recipes.dart';
import 'package:food_ai_thesis/utils/constants.dart';
import 'package:stacked/stacked.dart';
import 'dashboard_recipes_viewmodel.dart';

class DashboardRecipesView extends StackedView<DashboardRecipesViewModel> {
  const DashboardRecipesView({super.key});

  @override
  Widget builder(
    BuildContext context,
    DashboardRecipesViewModel viewModel,
    Widget? child,
  ) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: TiltingFab(
          onPressed: viewModel.navigateToImageProcessing,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardHeader(
                  profileImage: viewModel.profileImage,
                  username: viewModel.username,
                ),
                const SizedBox(height: AppSpacing.sm),
                Expanded(
                  child: _buildMainContent(context, viewModel,
                      constraints.maxWidth, constraints.maxHeight),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(
    BuildContext context,
    DashboardRecipesViewModel viewModel,
    double width,
    double height,
  ) {
    final bool isDataEmpty = viewModel.foodInfos.isEmpty &&
        viewModel.featuredRecipes.isEmpty &&
        viewModel.popularRecipes.isEmpty;

    if (viewModel.isLoading && isDataEmpty) {
      return _buildLoadingState(context, width);
    } else {
      return _buildContentState(context, viewModel, width, height);
    }
  }

  Widget _buildLoadingState(BuildContext context, double width) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitFadingCube(
            color: Colors.orange,
            size: width * 0.08,
          ),
          const SizedBox(height: 25),
          Text(
            'Fetching recipes...',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentState(
    BuildContext context,
    DashboardRecipesViewModel viewModel,
    double width,
    double height,
  ) {
    // Calculate responsive padding based on screen width
    final double horizontalPadding = width * 0.04;

    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          viewModel.getAllFoodInfo(),
          viewModel.getFeaturedRecipes(),
          viewModel.getPopularRecipes(),
        ]);
      },
      color: Theme.of(context).colorScheme.primary,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          SectionTitle(
            title: 'Featured Recipes',
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          ),
          FeaturedRecipeListWidget(
            featuredRecipes: viewModel.featuredRecipes,
            isFeaturedLoading: viewModel.isFeaturedLoading,
          ),
          const SizedBox(height: AppSpacing.sm),

          SectionTitle(
            title: 'Filipino Recipes',
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          ),
          FilipinoRecipeListWidget(
            foodInfos: viewModel.foodInfos,
            isLoading: viewModel.isLoading,
          ),
          const SizedBox(height: AppSpacing.sm),

          SectionTitle(
            title: 'Most Liked & Viewed Recipes',
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          ),
          MostViewedAndLikedRecipesWidget(
            popularRecipes: viewModel.popularRecipes,
            isPopularLoading: viewModel.isPopularLoading,
          ),

          // Space for FAB and bottom navigation
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.getAllFoodInfo();
      viewModel.getFeaturedRecipes();
      viewModel.getPopularRecipes();
      viewModel.markVisitedForFeedback();
    });
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onSeeAllPressed;

  const SectionTitle({
    super.key,
    required this.title,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.onSeeAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Adaptive text sizing based on screen width
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final titleSize = textScaleFactor * 18.0;

    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (onSeeAllPressed != null)
            TextButton(
              onPressed: onSeeAllPressed,
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'See all',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

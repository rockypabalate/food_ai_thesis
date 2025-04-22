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
          // Modern section selector
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              'Discover Recipes',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Section selector containers
          SectionSelector(
            selectedSection: viewModel.selectedRecipeSection,
            onSectionChanged: viewModel.setSelectedRecipeSection,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          ),
          const SizedBox(height: AppSpacing.md),

          // Show content based on selected section
          if (viewModel.selectedRecipeSection == RecipeSection.featured)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Text(
                    'Featured Recipes',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                FeaturedRecipeListWidget(
                  featuredRecipes: viewModel.featuredRecipes,
                  isFeaturedLoading: viewModel.isFeaturedLoading,
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Text(
                    'Most Liked & Viewed Recipes',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                MostViewedAndLikedRecipesWidget(
                  popularRecipes: viewModel.popularRecipes,
                  isPopularLoading: viewModel.isPopularLoading,
                ),
              ],
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.getAllFoodInfo();
      viewModel.getFeaturedRecipes();
      viewModel.getPopularRecipes();
      viewModel.markVisitedForFeedback();
    });
  }
}

class SectionSelector extends StatelessWidget {
  final RecipeSection selectedSection;
  final Function(RecipeSection) onSectionChanged;
  final EdgeInsetsGeometry padding;

  const SectionSelector({
    super.key,
    required this.selectedSection,
    required this.onSectionChanged,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSectionContainer(
            context,
            'Featured',
            RecipeSection.featured,
            Icons.star_rounded,
          ),
          const SizedBox(width: 12),
          _buildSectionContainer(
            context,
            'Most Liked & Viewed',
            RecipeSection.mostLikedViewed,
            Icons.favorite_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContainer(
    BuildContext context,
    String title,
    RecipeSection section,
    IconData icon,
  ) {
    final bool isSelected = selectedSection == section;
    final theme = Theme.of(context);

    // Define orange gradient colors for a more modern look
    final gradient = isSelected
        ? LinearGradient(
            colors: [
              Colors.orange.shade600,
              Colors.deepOrange.shade700,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : null;

    // Define orange color for unselected icons
    final iconColor = isSelected ? Colors.white : Colors.orange;

    return Expanded(
      child: GestureDetector(
        onTap: () => onSectionChanged(section),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
          decoration: BoxDecoration(
            gradient: gradient,
            color: isSelected ? null : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : Colors.orange.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

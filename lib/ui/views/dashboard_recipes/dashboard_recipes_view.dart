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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: TiltingFab(
          onPressed: viewModel.navigateToImageProcessing,
        ),

        //           floatingActionButton: TiltingFab(
        // onPressed: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const QRCodePage()),
        //   );
        // },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(
              profileImage: viewModel.profileImage,
              username: viewModel.username,
            ),
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: viewModel.isLoading
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SpinKitThreeBounce(
                            color: Colors.orange,
                            size: screenWidth * 0.08,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            'Fetching recipes...',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w600,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      physics: const BouncingScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.00),
                      children: [
                        _SectionTitle(
                            title: 'Filipino Recipes', onSeeAllTap: () {}),
                        FilipinoRecipeListWidget(
                          foodInfos: viewModel.foodInfos,
                          isLoading: viewModel.isLoading,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        _SectionTitle(
                            title: 'Featured Recipes', onSeeAllTap: () {}),
                        FeaturedRecipeListWidget(
                          featuredRecipes: viewModel.featuredRecipes,
                          isFeaturedLoading: viewModel.isFeaturedLoading,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // _SectionTitle(
                        //     title: 'Most Liked & Viewed Recipes',
                        //     onSeeAllTap: () {}),
                        // MostViewedAndLikedRecipesWidget(
                        //   popularRecipes: viewModel.popularRecipes,
                        //   isPopularLoading: viewModel.isPopularLoading,
                        // ),
                        SizedBox(height: screenHeight * 0.015),
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
    viewModel.getAllFoodInfo();
    viewModel.getFeaturedRecipes();
    viewModel.getPopularRecipes();
  }
}

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
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

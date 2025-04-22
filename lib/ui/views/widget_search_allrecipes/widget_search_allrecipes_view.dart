import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/models/list_recipes/list_recipes.dart';
import 'package:food_ai_thesis/ui/views/widget_search_allrecipes/animated_category_tile.dart';
import 'package:food_ai_thesis/ui/views/widget_search_allrecipes/wg_all_recipes.dart';
import 'package:food_ai_thesis/utils/shimmer_loading_widget.dart';
import 'package:food_ai_thesis/utils/widgets_fade_effect.dart';
import 'package:stacked/stacked.dart';
import 'widget_search_allrecipes_viewmodel.dart';

class WidgetSearchAllrecipesView
    extends StackedView<WidgetSearchAllrecipesViewModel> {
  const WidgetSearchAllrecipesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    WidgetSearchAllrecipesViewModel viewModel,
    Widget? child,
  ) {
    final screenSize = MediaQuery.of(context).size;
    final contentPadding = screenSize.width * 0.02;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (!viewModel.showCategories) {
              viewModel.showCategoryList();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: viewModel.isSearching
            ? TextField(
                autofocus: true,
                onChanged: viewModel.onSearchChanged,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search recipes...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
              )
            : Text(
                viewModel.showCategories
                    ? 'Search Recipes'
                    : viewModel.selectedCategory ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenSize.width * 0.055,
                  fontWeight: FontWeight.bold,
                ),
              ),
        actions: [
          if (!viewModel.showCategories)
            IconButton(
              icon: Icon(
                viewModel.isSearching ? Icons.close : Icons.search,
                color: Colors.white,
              ),
              onPressed: () => viewModel.toggleSearch(),
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: contentPadding),
        child: viewModel.isLoading
            ? ListView.builder(
                itemCount: 5,
                itemBuilder: (_, __) => const ShimmerLoadingWidget(),
              )
            : viewModel.showCategories
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.builder(
                          padding: const EdgeInsets.only(top: 14),
                          itemCount: viewModel.categoryRecipesMap.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.55,
                          ),
                          itemBuilder: (context, index) {
                            final category = viewModel.categoryRecipesMap.keys
                                .elementAt(index);
                            final recipes =
                                viewModel.categoryRecipesMap[category]!;

                            return AnimatedCategoryTile(
                              category: category,
                              recipes: recipes,
                              onTap: () => viewModel.selectCategory(category),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.all(contentPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Removed TextField from here
                        const SizedBox(height: 12),
                        FadeEffectRecipe(
                          delay: 200,
                          child: AllRecipesWidget(
                            foodInfos: viewModel.filteredFoodInfos,
                            isLoading: viewModel.isTyping,
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  @override
  WidgetSearchAllrecipesViewModel viewModelBuilder(BuildContext context) =>
      WidgetSearchAllrecipesViewModel();

  @override
  void onViewModelReady(WidgetSearchAllrecipesViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.getAllFoodInfo();
  }
}

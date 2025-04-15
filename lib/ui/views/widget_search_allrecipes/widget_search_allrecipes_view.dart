import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/widget_search_allrecipes/category_modal.dart';
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
    final searchController = viewModel.searchController;
    final screenSize = MediaQuery.of(context).size;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    // Calculate relative sizes based on screen dimensions
    final headerPadding = screenSize.height * 0.01;
    final headerBottomRadius = screenSize.width * 0.03;
    final titleFontSize = screenSize.width * 0.055; // 5% of screen width
    final searchBarHeight = screenSize.height * 0.060;
    final contentPadding = screenSize.width * 0.03;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: headerPadding),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(headerBottomRadius),
                bottomRight: Radius.circular(headerBottomRadius),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: statusBarHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          padding: EdgeInsets.all(screenSize.width * 0.02),
                          iconSize: screenSize.width * 0.06,
                          onPressed: () {
                            viewModel.searchFocusNode.unfocus();
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          'Search Recipes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.white),
                      padding: EdgeInsets.all(screenSize.width * 0.02),
                      iconSize: screenSize.width * 0.07,
                      onPressed: () {
                        // Hide keyboard before opening modal
                        FocusScope.of(context).unfocus();

                        showCategoryFilterModal(
                          context: context,
                          categories: viewModel.uniqueCategories.toList(),
                          selectedCategory: viewModel.selectedCategory,
                          onCategorySelected: viewModel.filterByCategory,
                          onClearFilter: viewModel.clearCategoryFilter,
                        );
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: contentPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: searchBarHeight,
                          child: TextField(
                            controller: searchController,
                            focusNode: viewModel.searchFocusNode,
                            style:
                                TextStyle(fontSize: screenSize.width * 0.035),
                            decoration: InputDecoration(
                              hintText: 'Search recipes...',
                              hintStyle:
                                  TextStyle(fontSize: screenSize.width * 0.035),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: searchBarHeight * 0.2,
                                horizontal: contentPadding * 0.75,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: screenSize.width * 0.05,
                              ),
                              suffixIcon:
                                  ValueListenableBuilder<TextEditingValue>(
                                valueListenable: searchController,
                                builder: (context, value, child) {
                                  return value.text.isNotEmpty
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.clear,
                                            color: Colors.grey,
                                            size: screenSize.width * 0.05,
                                          ),
                                          onPressed: () {
                                            searchController.clear();
                                            viewModel.filterRecipes('');
                                            FocusScope.of(context).unfocus();
                                          },
                                        )
                                      : const SizedBox.shrink();
                                },
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    screenSize.width * 0.03),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: viewModel.filterRecipes,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: headerPadding * 0.5),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: contentPadding,
                  vertical: headerPadding,
                ),
                child: viewModel.isLoading
                    ? Column(
                        children: List.generate(
                          5,
                          (_) => const ShimmerLoadingWidget(),
                        ),
                      )
                    : viewModel.filteredFoodInfos.isEmpty
                        ? Center(
                            child: Text(
                              'No recipes found.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: screenSize.width * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : FadeEffectRecipe(
                            delay: 200,
                            child: AllRecipesWidget(
                              foodInfos: viewModel.filteredFoodInfos,
                              isLoading: viewModel.isTyping,
                            ),
                          ),
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
        ],
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

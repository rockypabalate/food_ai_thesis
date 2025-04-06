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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
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
                const SizedBox(height: 35.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            viewModel.searchFocusNode.unfocus();
                            Navigator.pop(context);
                          },
                        ),
                        const Text(
                          'Search Recipes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.white),
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
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          focusNode: viewModel.searchFocusNode,
                          style: const TextStyle(fontSize: 14.0),
                          decoration: InputDecoration(
                            hintText: 'Search recipes...',
                            hintStyle: const TextStyle(fontSize: 14.0),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.grey),
                            suffixIcon:
                                ValueListenableBuilder<TextEditingValue>(
                              valueListenable: searchController,
                              builder: (context, value, child) {
                                return value.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear,
                                            color: Colors.grey),
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
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: viewModel.filterRecipes,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 1.0),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: viewModel.isLoading
                    ? Column(
                        children: List.generate(
                            5, (_) => const ShimmerLoadingWidget()),
                      )
                    : viewModel.filteredFoodInfos.isEmpty
                        ? const Center(
                            child: Text(
                              'No recipes found.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600),
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
          const SizedBox(height: 8.0),
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

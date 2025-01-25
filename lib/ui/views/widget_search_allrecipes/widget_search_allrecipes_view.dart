import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/widget_search_allrecipes/wg_all_recipes.dart';
import 'package:food_ai_thesis/utils/shimmer_loading_widget.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom header with back icon, title, search bar, and filter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        // Back navigation icon
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            viewModel.searchFocusNode.unfocus();
                            Navigator.pop(context);
                          },
                        ),
                        // Title header
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
                    // Filter icon with dropdown
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.filter_list, color: Colors.white),
                      onSelected: (String selectedCategory) {
                        if (selectedCategory == 'Clear Filter') {
                          viewModel.clearCategoryFilter();
                        } else {
                          viewModel.filterByCategory(selectedCategory);
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem<String>(
                            value: 'Clear Filter',
                            child: Text('Clear Filter'),
                          ),
                          ...viewModel.uniqueCategories.map(
                            (category) => PopupMenuItem<String>(
                              value: category,
                              child: Text(category),
                            ),
                          ),
                        ];
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 12.0),
                // Adding horizontal padding for search bar and filter
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0), // Add horizontal padding
                  child: Row(
                    children: [
                      // Search bar
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
                                // Show the clear icon only if there's text
                                return value.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear,
                                            color: Colors.grey),
                                        onPressed: () {
                                          searchController
                                              .clear(); // Clear the text
                                          viewModel.filterRecipes('');
                                          FocusScope.of(context)
                                              .unfocus(); // Optionally reset filters
                                        },
                                      )
                                    : const SizedBox
                                        .shrink(); // Empty widget if no text
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

          // Scrollable content with shimmer loader
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: viewModel.isLoading
                    ? Column(
                        children: List.generate(
                          5, // Number of shimmer placeholders
                          (index) => const ShimmerLoadingWidget(),
                        ),
                      )
                    : viewModel.filteredFoodInfos.isEmpty
                        ? const Center(
                            child: Text(
                              'No recipes found.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : AllRecipesWidget(
                            foodInfos: viewModel.filteredFoodInfos,
                            isLoading: viewModel.isTyping,
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

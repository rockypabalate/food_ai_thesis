import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/seeall_liked_viewed_recipes/wg_liked_viewed.dart';
import 'package:food_ai_thesis/utils/shimmer_loading_widget.dart';
import 'package:stacked/stacked.dart';

import 'seeall_liked_viewed_recipes_viewmodel.dart';

class SeeallLikedViewedRecipesView
    extends StackedView<SeeallLikedViewedRecipesViewModel> {
  const SeeallLikedViewedRecipesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SeeallLikedViewedRecipesViewModel viewModel,
    Widget? child,
  ) {
    final searchController = viewModel.searchController;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 4.0,
        shadowColor: Colors.black.withOpacity(0.5),
        title: const Text(
          'Search Popular Recipes',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            viewModel.searchFocusNode.unfocus();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar and filter options
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Row(
              children: [
                // Search bar
                Expanded(
                  child: TextField(
                    controller: searchController,
                    focusNode: viewModel.searchFocusNode,
                    style: const TextStyle(fontSize: 14.0),
                    decoration: InputDecoration(
                      hintText: 'Search popular recipes...',
                      hintStyle: const TextStyle(fontSize: 14.0),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                    ),
                    onChanged: viewModel.filterRecipes,
                  ),
                ),
                const SizedBox(width: 8.0),
                // Filter dropdown
                PopupMenuButton<String>(
                  icon: const Icon(Icons.filter_list, color: Colors.grey),
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
          ),

          // Display featured recipes or a message
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: viewModel.isLoading
                    ? Column(
                        children: List.generate(
                          5, // Number of shimmer placeholders
                          (index) => const ShimmerLoadingWidget(),
                        ),
                      )
                    : viewModel.mostViewedAndLikedRecipes.isEmpty
                        ? const Center(
                            child: Text(
                              'No featured recipes found.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : LikedViewedRecipesWidget(
                            mostViewedAndLikedRecipes:
                                viewModel.mostViewedAndLikedRecipes,
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
  SeeallLikedViewedRecipesViewModel viewModelBuilder(BuildContext context) =>
      SeeallLikedViewedRecipesViewModel();

  @override
  void onViewModelReady(SeeallLikedViewedRecipesViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.getAllFoodInfo();
  }
}

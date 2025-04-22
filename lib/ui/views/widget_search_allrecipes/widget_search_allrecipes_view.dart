import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/models/list_recipes/list_recipes.dart';
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
    final screenSize = MediaQuery.of(context).size;
    final contentPadding = screenSize.width * 0.01;

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
        title: Text(
          viewModel.showCategories
              ? 'Search Recipes'
              : viewModel.selectedCategory ?? '',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenSize.width * 0.055,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                          padding: const EdgeInsets.only(top: 12),
                          itemCount: viewModel.categoryRecipesMap.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.2,
                          ),
                          itemBuilder: (context, index) {
                            final category = viewModel.categoryRecipesMap.keys
                                .elementAt(index);
                            final recipes =
                                viewModel.categoryRecipesMap[category]!;

                            return _AnimatedCategoryTile(
                              category: category,
                              recipes: recipes,
                              onTap: () => viewModel.selectCategory(category),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.all(contentPadding),
                    child: FadeEffectRecipe(
                      delay: 200,
                      child: AllRecipesWidget(
                        foodInfos: viewModel.filteredFoodInfos,
                        isLoading: viewModel.isTyping,
                      ),
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

class _AnimatedCategoryTile extends StatefulWidget {
  final String category;
  final List<FoodInfo> recipes;
  final VoidCallback onTap;

  const _AnimatedCategoryTile({
    required this.category,
    required this.recipes,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<_AnimatedCategoryTile> createState() => _AnimatedCategoryTileState();
}

class _AnimatedCategoryTileState extends State<_AnimatedCategoryTile> {
  int _currentImageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.recipes.isNotEmpty) {
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        setState(() {
          _currentImageIndex =
              (_currentImageIndex + 1) % widget.recipes.length;
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.recipes.isNotEmpty &&
            widget.recipes[_currentImageIndex].imageUrls.isNotEmpty
        ? widget.recipes[_currentImageIndex].imageUrls.first
        : '';

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        key: ValueKey(imageUrl),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Container(
                        key: const ValueKey('empty'),
                        color: Colors.grey[300],
                      ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${widget.recipes.length} recipes',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



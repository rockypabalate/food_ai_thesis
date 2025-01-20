import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'dashboard_recipes_viewmodel.dart';

class CategoriesWidget extends ViewModelWidget<DashboardRecipesViewModel> {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DashboardRecipesViewModel viewModel) {
    if (viewModel.uniqueCategories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Row(
            children: [
              // "All" container with shadow
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                child: GestureDetector(
                  onTap: () => viewModel.showAllRecipes(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 1.0,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      'All',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              // Other category containers with shadow
              ...viewModel.uniqueCategories.map(
                (category) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                  child: GestureDetector(
                    onTap: () => viewModel.filterByCategory(category),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 1.0,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 11.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

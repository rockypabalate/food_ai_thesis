import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/create_recipe/create_recipe_view.dart';
import 'package:stacked/stacked.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/user_dashboard_viewmodel.dart';
// Import CreateRecipeView

class BookmarkedRecipesTab extends StatelessWidget {
  const BookmarkedRecipesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserDashboardViewModel>.reactive(
      viewModelBuilder: () => UserDashboardViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor:
              Colors.white, // Set the scaffold background color to white
          body: const Center(
            child: Text(
              "Your bookmarked recipes will appear here.",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigate to the CreateRecipeView page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateRecipeView(),
                ),
              );
            },
            backgroundColor: Colors.orange,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              size: 28,
              color: Colors.white, // Icon color
            ), // Ensures the button is circular
          ),
        );
      },
    );
  }
}

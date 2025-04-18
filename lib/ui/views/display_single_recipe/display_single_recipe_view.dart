import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/widgest_delayed_fadein.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/widgets_single_view_page_compenents.dart';
import 'package:stacked/stacked.dart';
import 'display_single_recipe_viewmodel.dart';

class DisplaySingleRecipeView
    extends StackedView<DisplaySingleRecipeViewModel> {
  final int foodId;

  const DisplaySingleRecipeView({Key? key, required this.foodId})
      : super(key: key);

  @override
  Widget builder(BuildContext context, DisplaySingleRecipeViewModel viewModel,
      Widget? child) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF9F9F9), // Light background color for modern look
      body: _buildBody(context, viewModel),
    );
  }

  Widget _buildBody(
      BuildContext context, DisplaySingleRecipeViewModel viewModel) {
    if (viewModel.isBusy) {
      return _buildLoadingState();
    } else if (viewModel.foodInfoById != null) {
      return _buildRecipeContent(context, viewModel);
    } else {
      return _buildErrorState();
    }
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SpinKitThreeBounce(
            color: Colors.orange,
            size: 40.0,
          ),
          const SizedBox(height: 15),
          Text(
            'Loading your recipe...',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Recipe not found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We couldn\'t find the recipe you\'re looking for.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeContent(
      BuildContext context, DisplaySingleRecipeViewModel viewModel) {
    return ModernRecipeWidgets.buildRecipeScreen(viewModel, context);

  }

  @override
  DisplaySingleRecipeViewModel viewModelBuilder(BuildContext context) =>
      DisplaySingleRecipeViewModel();

  @override
  void onViewModelReady(DisplaySingleRecipeViewModel viewModel) {
    super.onViewModelReady(viewModel);
    fetchRecipeData(viewModel);
      viewModel.markVisitedForFeedback();
  }

  void fetchRecipeData(DisplaySingleRecipeViewModel viewModel) async {
    viewModel.fetchFoodInfoById(foodId);
  }
}

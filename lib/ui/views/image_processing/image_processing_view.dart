import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/display_single_recipe_view.dart';
import 'package:food_ai_thesis/ui/views/image_processing/widgets_front_page.dart';
import 'package:stacked/stacked.dart';
import 'package:lottie/lottie.dart'; // Import Lottie
import 'image_processing_viewmodel.dart';

class ImageProcessingView extends StackedView<ImageProcessingViewModel> {
  const ImageProcessingView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ImageProcessingViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: viewModel.isBusy
            ? _buildLoadingView()
            : viewModel.isFrontPageVisible
                ? FrontPage(viewModel: viewModel)
                : _buildResultsView(context, viewModel),
      ),
    );
  }

  /// Loading Animation View
  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SpinKitThreeBounce(
            color: Colors.orange,
            size: 40.0, // Adjust size if needed
          ),
          const SizedBox(height: 10),
          Text(
            'Processing...',
            style: GoogleFonts.poppins(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsView(
      BuildContext context, ImageProcessingViewModel viewModel) {
    return Column(
      children: [
        // Back Arrow & Header
        if (viewModel.selectedImage != null) _buildHeader(context, viewModel),
        const SizedBox(height: 16.0),
        // Display Image (Keep at the top)
        if (viewModel.selectedImage != null) _buildImage(viewModel),

        if (viewModel.result != null && viewModel.searchResults.isEmpty)
          Center(child: _buildNoRecipeFound()),

        // Display Search Results
        if (viewModel.searchResults.isNotEmpty)
          Expanded(
            child: _buildSearchResults(context, viewModel),
          ),
      ],
    );
  }

  /// Header with Back Button & Title
  Widget _buildHeader(
      BuildContext context, ImageProcessingViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, top: 45.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28.0),
            onPressed: () {
              viewModel.resetViewState();
              viewModel.isFrontPageVisible = true;
              viewModel.notifyListeners();
            },
          ),
          const SizedBox(width: 8.0),
          Text(
            'Identified Food',
            style: GoogleFonts.poppins(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange, // Changed text color to orange
            ),
          ),
        ],
      ),
    );
  }

  /// Displays Selected Image
  Widget _buildImage(ImageProcessingViewModel viewModel) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0.0),
      child: Image.file(
        viewModel.selectedImage!,
        height: 270,
        width: double.infinity, // Ensures full width
        fit: BoxFit.fitWidth, // Ensures it only expands left & right
      ),
    );
  }

  /// Displays Search Results
  Widget _buildSearchResults(
      BuildContext context, ImageProcessingViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
        itemCount: viewModel.searchResults.length,
        itemBuilder: (context, index) {
          final food = viewModel.searchResults[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.foodName,
                  style: GoogleFonts.poppins(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Text(
                      'Category: ',
                      style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      food.category ?? 'Unknown',
                      style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  food.description,
                  style: GoogleFonts.poppins(),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DisplaySingleRecipeView(foodId: food.id),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'See Details',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// No Recipe Found View (Lottie Animation)
  Widget _buildNoRecipeFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'lib/assets/not_found.json',
            height: 250,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'No recipe found',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Due to the dataset limit, it may not have found the Filipino recipes.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  ImageProcessingViewModel viewModelBuilder(BuildContext context) =>
      ImageProcessingViewModel();
}

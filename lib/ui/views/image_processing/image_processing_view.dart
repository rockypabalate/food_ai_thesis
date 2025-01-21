import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/display_single_recipe_view.dart';
import 'package:food_ai_thesis/ui/views/image_processing/widgets_front_page.dart';
import 'package:stacked/stacked.dart';
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
      body: viewModel.isBusy
          ? const Center(
              child: CircularProgressIndicator(), // Show only the loader
            )
          : viewModel.isFrontPageVisible
              ? FrontPage(viewModel: viewModel) // Display the FrontPage
              : Column(
                  children: [
                    // Display Selected or Captured Image with a back button
                    if (viewModel.selectedImage != null)
                      Stack(
                        children: [
                          Image.file(
                            viewModel.selectedImage!,
                            height: 270,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 24.0, // Adjust as needed
                            left: 6.0, // Adjust as needed
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                viewModel.resetViewState(); // Reset view state
                                viewModel.isFrontPageVisible =
                                    true; // Return to FrontPage
                                viewModel.notifyListeners();
                              },
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: .0),

                    // Display Search Results
                    if (viewModel.searchResults.isNotEmpty)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                                      style: const TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(food.description),
                                    const SizedBox(height: 16.0),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DisplaySingleRecipeView(
                                                foodId: food.id,
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orange,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text('See Details'),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                    // No Results Found
                    if (viewModel.result != null &&
                        viewModel.searchResults.isEmpty)
                      const Center(
                        child: Text(
                          'No recipes found...',
                          style: TextStyle(fontSize: 16.0),
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

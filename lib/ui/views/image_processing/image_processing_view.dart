import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                    // Back Arrow with "Identified Food" Header
                    if (viewModel.selectedImage != null)
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 5.0,
                            top: 36.0, // Adjust padding to position the arrow
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 28.0,
                                ),
                                onPressed: () {
                                  viewModel
                                      .resetViewState(); // Reset view state
                                  viewModel.isFrontPageVisible =
                                      true; // Return to FrontPage
                                  viewModel.notifyListeners();
                                },
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                'Identified Food',
                                style: GoogleFonts.poppins(
                                  fontSize: 22.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Display Selected or Captured Image
                    if (viewModel.selectedImage != null)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.file(
                            viewModel.selectedImage!,
                            height: 270,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

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
                                      style: GoogleFonts.poppins(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .orange, // Set the color to orange
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
                                            fontWeight: FontWeight.normal,
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
                        ),
                      ),

                    // No Results Found
                    if (viewModel.result != null &&
                        viewModel.searchResults.isEmpty)
                      Center(
                        child: Text(
                          'No recipes found...',
                          style: GoogleFonts.poppins(
                            fontSize: 16.0,
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

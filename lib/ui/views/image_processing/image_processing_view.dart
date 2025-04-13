import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/display_single_recipe_view.dart';
import 'package:food_ai_thesis/ui/views/image_processing/widgets_front_page.dart';
import 'package:stacked/stacked.dart';
import 'package:lottie/lottie.dart';
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
        color: Colors.grey[50],
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
            size: 40.0,
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
    if (viewModel.result != null && viewModel.searchResults.isEmpty) {
      return _buildNoRecipeFound(viewModel);
    }

    return Column(
      children: [
        // Hero Image with gradient overlay and buttons
        if (viewModel.selectedImage != null)
          _buildHeroImage(context, viewModel),

        // Expanded list to show food details
        if (viewModel.searchResults.isNotEmpty)
          Expanded(
            child: _buildFoodDetails(context, viewModel),
          ),
      ],
    );
  }

  /// Hero Image with gradient overlay and navigation buttons
  Widget _buildHeroImage(
      BuildContext context, ImageProcessingViewModel viewModel) {
    return Stack(
      children: [
        // Image
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          child: Container(
            height: 280,
            width: double.infinity,
            child: Image.file(
              viewModel.selectedImage!,
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Gradient overlay
        Container(
          height: 280,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.4),
              ],
            ),
          ),
        ),

        // Top navigation buttons
        Positioned(
          top: 45,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      viewModel.resetViewState();
                      viewModel.isFrontPageVisible = true;
                      viewModel.notifyListeners();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Displays Food Details with modern UI
  Widget _buildFoodDetails(
      BuildContext context, ImageProcessingViewModel viewModel) {
    final food =
        viewModel.searchResults[0]; // Assuming we're showing the first result

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Name Card - overlapping with the image
            Transform.translate(
              offset: const Offset(0, -25),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Food name and rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),
                              Text(
                                food.foodName,
                                style: GoogleFonts.poppins(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                food.category ?? 'Filipino Cuisine',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '-',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // Quick info row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildInfoItem(Icons.access_time, '-'),
                        const SizedBox(width: 20),
                        _buildInfoItem(Icons.person_outline, '-'),
                        const SizedBox(width: 20),
                        _buildInfoItem(
                            Icons.local_fire_department_outlined, '-'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Description Section
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    food.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // See Details Button
            Row(
              children: [
                Expanded(
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
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      'See Full Recipe',
                      style: GoogleFonts.poppins(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon:
                        const Icon(Icons.share_outlined, color: Colors.black87),
                    onPressed: () {
                      // Implement share functionality
                    },
                    iconSize: 24,
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method to build info items
  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.orange,
          size: 18,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  /// No Recipe Found View (Lottie Animation)
  Widget _buildNoRecipeFound(ImageProcessingViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 10, top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              // Go back to front page view
              viewModel.resetViewState();
              viewModel.isFrontPageVisible = true;
              viewModel.notifyListeners();
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
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
        ),
      ),
    );
  }

  @override
  ImageProcessingViewModel viewModelBuilder(BuildContext context) =>
      ImageProcessingViewModel();
}

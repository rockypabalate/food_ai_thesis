import 'package:flutter/material.dart';
import 'package:food_ai_thesis/models/list_recipes/single_display_recipe.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/display_single_recipe_viewmodel.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/export_pdf_UI.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/youtube_play.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeWidgets {
  static Widget buildSectionTitle(String title) {
    return const Row(
      children: [],
    );
  }

  static Widget buildSliverAppBar(
      DisplaySingleRecipeViewModel viewModel, BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 250.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        collapseMode: CollapseMode.parallax,
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            viewModel.foodInfoById!.images.isNotEmpty
                ? Hero(
                    tag: 'food_image_${viewModel.foodInfoById!.id}',
                    child: Image.network(
                      viewModel.foodInfoById!
                          .images[viewModel.selectedImageIndex].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  static Widget buildPlayVideoButton(
      DisplaySingleRecipeViewModel viewModel, BuildContext context) {
    final youtubeLink = viewModel.foodInfoById?.link;

    if (youtubeLink == null || youtubeLink.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 0.0), // for spacing from screen edges
      child: SizedBox(
        width: double.infinity, // full-width button
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    YoutubeVideoPlayerView(youtubeUrl: youtubeLink),
              ),
            );
          },
          icon: const Icon(Icons.play_circle_fill, color: Colors.white),
          label: const Text(
            "Play Video",
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildFoodImagesSection(DisplaySingleRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipe Images',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 80, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.foodInfoById!.images.length,
            itemBuilder: (context, index) {
              final image = viewModel.foodInfoById!.images[index];
              return GestureDetector(
                onTap: () {
                  viewModel.setSelectedImageIndex(index);
                },
                child: Row(
                  children: [
                    if (index > 0) const SizedBox(width: 12.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                        border: Border.all(
                          color: viewModel.selectedImageIndex == index
                              ? Colors.orange
                              : Colors.transparent,
                          width: 2.0,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            offset: Offset(0, .1),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(8), // Apply border radius
                        child: Image.network(
                          image.imageUrl,
                          height: 80,
                          width: 90, // Fixed width for each image container
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  static Widget buildFavoriteAndBookmarkIcons(
    BuildContext context,
    DisplaySingleRecipeViewModel viewModel,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Favorite Icon
        GestureDetector(
          onTap: viewModel.isLiked
              ? null
              : () {
                  viewModel.likeFoodById(viewModel.foodInfoById!.id);
                },
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.favorite,
              size: 22,
              color: viewModel.isLiked ? Colors.red : Colors.grey,
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Bookmark Icon
        GestureDetector(
          onTap: viewModel.isSaved
              ? null
              : () {
                  viewModel.saveFoodById(viewModel.foodInfoById!.id);
                },
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.bookmark,
              size: 22,
              color: viewModel.isSaved ? Colors.orange : Colors.grey,
            ),
          ),
        ),
        const SizedBox(width: 10),

        // PDF Export Icon
        GestureDetector(
          onTap: () {
            final recipe = viewModel.foodInfoById;
            if (recipe != null) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PdfExportPage(recipe: recipe),
              ));
            }
          },
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.picture_as_pdf,
              size: 22,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  static Widget buildFoodTitle(String foodName) {
    return Text(
      foodName,
      style: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  static Widget buildViewsAndLikes(int views, int likes) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.favorite, size: 14, color: Colors.red),
              const SizedBox(width: 4),
              Text(
                '$likes Likes',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Row(
            children: [
              const Icon(Icons.visibility_outlined,
                  size: 14, color: Colors.green),
              const SizedBox(width: 4),
              Text(
                '$views Views',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget buildAuthor(String? author) {
    if (author == null) {
      return const SizedBox.shrink(); // Return an empty widget if no author
    }
    return Row(
      children: [
        // const Icon(
        //   Icons.person,
        //   color: Colors.orange,
        //   size: 20,
        // ),
        // const SizedBox(width: 8),
        Text(
          author,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  static Widget buildFoodDetails({
    required String servingSize,
    required String? totalCookTime,
    required String? difficulty,
    required String? category,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Serving Size: $servingSize',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (totalCookTime != null)
          Text(
            'Total Cook Time: $totalCookTime',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        if (totalCookTime != null) const SizedBox(height: 8),
        if (difficulty != null)
          Text(
            'Difficulty: $difficulty',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        if (difficulty != null) const SizedBox(height: 8),
        if (category != null)
          Text(
            'Category: $category',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
      ],
    );
  }

  static Widget buildFoodDescription(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description:',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 5.0), // Add padding only to the description text
          child: RichText(
            textAlign: TextAlign.justify, // Justify the paragraph
            text: TextSpan(
              children: [
                const WidgetSpan(
                  child: SizedBox(width: 20), // Add indentation
                ),
                TextSpan(
                  text: description,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget buildPreparationTips(String? preparationTips) {
    if (preparationTips == null || preparationTips.isEmpty) {
      return Container(); // Return an empty container if there's no preparation tip
    }
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preparation Tips',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            preparationTips,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildCardContent(List<Ingredient> ingredients) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Ingredients',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                  color: Colors.black87,
                ),
              ),
            ),
            Column(
              children: ingredients.map((ingredient) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Colors.orangeAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(
                                text: '${ingredient.name} - ',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                              TextSpan(
                                text: ingredient.quantity,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildCardInstructions(List<String> instructions) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructions header
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Instructions',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                  color: Colors.black87,
                ),
              ),
            ),
            // List of instructions
            Column(
              children: List.generate(instructions.length, (i) {
                // Remove numeric prefix from instructions
                final instruction =
                    instructions[i].replaceFirst(RegExp(r'^\d+\.\s*'), '');

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Circular step number
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.orangeAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Instruction text
                      Expanded(
                        child: Text(
                          instruction,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildCardNutrients(
      List<String> nutrients, String? nutritionalParagraph) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nutritional Content header
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Nutritional Content',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                  color: Colors.black87,
                ),
              ),
            ),
            // Nutrients list
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: nutrients.map((nutrient) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline,
                          color: Colors.orangeAccent, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          nutrient,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            // Nutritional paragraph (optional)
            if (nutritionalParagraph != null &&
                nutritionalParagraph.isNotEmpty) ...[
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 5.0), // Horizontal padding
                child: RichText(
                  textAlign: TextAlign.justify, // Justify the paragraph
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: SizedBox(width: 20), // Add indentation
                      ),
                      TextSpan(
                        text: nutritionalParagraph,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black,
                          height: 1.5, // Line height for readability
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

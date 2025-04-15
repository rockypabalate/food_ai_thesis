import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/models/list_recipes/single_display_recipe.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/display_single_recipe_viewmodel.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/export_pdf_UI.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/youtube_play.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ModernRecipeWidgets {
  // App Bar with Parallax Effect and Gradient Overlay
  static Widget buildSliverAppBar(
      DisplaySingleRecipeViewModel viewModel, BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 300.0,
      backgroundColor: Colors.orange,
      elevation: 0,
      stretch: false, // Keep this false to prevent stretching
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode
            .pin, // Added this line to pin the background when collapsing
        stretchModes: const [], // Keep empty to prevent stretching
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Hero Image
            viewModel.foodInfoById!.images.isNotEmpty
                ? Hero(
                    tag: 'food_image_${viewModel.foodInfoById!.id}',
                    child: CachedNetworkImage(
                      imageUrl: viewModel.foodInfoById!
                          .images[viewModel.selectedImageIndex].imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(color: Colors.white),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )
                : Container(color: Colors.grey[300]),

            // Gradient overlay for better text visibility
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),

            // Recipe title at the bottom of the image
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Text(
                viewModel.foodInfoById!.foodName,
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(2.0, 2.0),
                    ),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.favorite,
              color: viewModel.isLiked ? Colors.red : Colors.white,
            ),
            onPressed: viewModel.isLiked
                ? null
                : () => viewModel.likeFoodById(viewModel.foodInfoById!.id),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.bookmark,
              color: viewModel.isSaved ? Colors.orange : Colors.white,
            ),
            onPressed: viewModel.isSaved
                ? null
                : () => viewModel.saveFoodById(viewModel.foodInfoById!.id),
          ),
        ),
      ],
    );
  }

  // Recipe Quick Info Card
  static Widget buildQuickInfoCard(
    DisplaySingleRecipeViewModel viewModel,
    BuildContext context,
  ) {
    final recipe = viewModel.foodInfoById!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Recipe stats in a row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat(
                Icons.access_time,
                recipe.totalCookTime ?? 'N/A',
                'Cook Time',
              ),
              _buildVerticalDivider(),
              _buildStat(
                Icons.people_alt_outlined,
                recipe.servingSize,
                'Servings',
              ),
              _buildVerticalDivider(),
              _buildStat(
                Icons.bar_chart,
                recipe.difficulty ?? 'N/A',
                'Difficulty',
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // Social stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSocialStat(Icons.favorite, recipe.likes, 'Likes'),
              _buildSocialStat(Icons.visibility, recipe.views, 'Views'),
              if (recipe.link != null && recipe.link!.isNotEmpty)
                _buildVideoButton(context, recipe.link!),
            ],
          ),
        ],
      ),
    );
  }

  // Helper for Quick Info Stats
  static Widget _buildStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.orange, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  // Helper for Social Stats
  static Widget _buildSocialStat(IconData icon, int count, String label) {
    return Row(
      children: [
        Icon(icon,
            size: 18,
            color: icon == Icons.favorite ? Colors.red : Colors.green),
        const SizedBox(width: 4),
        Text(
          '$count $label',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Helper for Video Button
  static Widget _buildVideoButton(BuildContext context, String youtubeUrl) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                YoutubeVideoPlayerView(youtubeUrl: youtubeUrl),
          ),
        );
      },
      icon: const Icon(
        Icons.play_circle_filled,
        size: 18,
        color: Colors.white,
      ),
      label: const Text('Video'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  // Helper for vertical divider
  static Widget _buildVerticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey[300],
    );
  }

  // Image Gallery
  static Widget buildImageGallery(DisplaySingleRecipeViewModel viewModel) {
    final images = viewModel.foodInfoById!.images;
    if (images.length <= 1) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => viewModel.setSelectedImageIndex(index),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: viewModel.selectedImageIndex == index
                      ? Colors.orange
                      : Colors.transparent,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: "${images[index].imageUrl}?quality=30",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Description Section
  static Widget buildDescription(String description) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.description, color: Colors.orange),
              const SizedBox(width: 8),
              Text(
                'About This Recipe',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 14,
              height: 1.5,
              color: Colors.black87,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  // Modern Ingredients Card
  static Widget buildIngredientsCard(List<Ingredient> ingredients) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.restaurant, color: Colors.orange),
              const SizedBox(width: 8),
              Text(
                'Ingredients',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...ingredients.map((ingredient) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 7),
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                        children: [
                          TextSpan(
                            text: '${ingredient.name} ',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: '(${ingredient.quantity})',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontStyle: FontStyle.italic,
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
        ],
      ),
    );
  }

  // Modern Instructions Card
  static Widget buildInstructionsCard(List<String> instructions) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.format_list_numbered, color: Colors.orange),
              const SizedBox(width: 8),
              Text(
                'Instructions',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...List.generate(instructions.length, (index) {
            // Clean up instruction text
            final instruction = instructions[index]
                .replaceFirst(RegExp(r'^\d+\.\s*'), '')
                .trim();

            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step number circle
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.orange, Colors.deepOrange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      instruction,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // Nutritional Content Card
  static Widget buildNutritionalCard(
      List<String> nutrients, String? nutritionalParagraph) {
    if (nutrients.isEmpty &&
        (nutritionalParagraph == null || nutritionalParagraph.isEmpty)) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.details, color: Colors.green),
              const SizedBox(width: 8),
              Text(
                'Nutritional Information',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Nutrient pills
          if (nutrients.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: nutrients.map((nutrient) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.green.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    nutrient,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.green[700],
                    ),
                  ),
                );
              }).toList(),
            ),

          // Nutritional paragraph
          if (nutritionalParagraph != null &&
              nutritionalParagraph.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              nutritionalParagraph,
              style: GoogleFonts.poppins(
                fontSize: 13,
                height: 1.5,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ],
      ),
    );
  }

  // Tips Card
  static Widget buildTipsCard(String? preparationTips) {
    if (preparationTips == null || preparationTips.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline, color: Colors.amber),
              const SizedBox(width: 8),
              Text(
                'Chef\'s Tips',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.amber.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              preparationTips,
              style: GoogleFonts.poppins(
                fontSize: 14,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Footer with PDF Export
  static Widget buildFooter(
    DisplaySingleRecipeViewModel viewModel,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ElevatedButton.icon(
        onPressed: () {
          final recipe = viewModel.foodInfoById;
          if (recipe != null) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PdfExportPage(recipe: recipe),
            ));
          }
        },
        icon: const Icon(
          Icons.picture_as_pdf,
          color: Colors.white,
        ),
        label: Text(
          'Save as PDF',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }

  // Main Method to build the entire Recipe Screen
  static Widget buildRecipeScreen(
    DisplaySingleRecipeViewModel viewModel,
    BuildContext context,
  ) {
    final recipe = viewModel.foodInfoById!;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar with Hero Image
          buildSliverAppBar(viewModel, context),

          // Content
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF9F9F9),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Quick info card
                  buildQuickInfoCard(viewModel, context),

                  // Author info if available
                  if (recipe.author != null && recipe.author!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.person, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(
                            'Recipe by ',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            recipe.author ?? 'Unknown',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Image gallery
                  buildImageGallery(viewModel),

                  // Description
                  buildDescription(recipe.description),

                  // Tips card
                  if (recipe.preparationTips != null)
                    buildTipsCard(recipe.preparationTips),

                  // Ingredients card
                  buildIngredientsCard(recipe.ingredients),

                  // Instructions card
                  buildInstructionsCard(recipe.instructions),

                  // Nutritional content
                  buildNutritionalCard(
                    recipe.nutritionalContent,
                    recipe.nutritionalParagraph,
                  ),

                  // PDF Export button
                  buildFooter(viewModel, context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

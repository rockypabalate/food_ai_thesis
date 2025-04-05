import 'package:flutter/material.dart';
import 'package:food_ai_thesis/models/list_recipes/featured_recipe_model.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/display_single_recipe_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedRecipeListWidget extends StatefulWidget {
  final List<FeaturedRecipe> featuredRecipes;
  final bool isFeaturedLoading;

  const FeaturedRecipeListWidget({
    Key? key,
    required this.featuredRecipes,
    required this.isFeaturedLoading,
  }) : super(key: key);

  @override
  _FeaturedRecipeListWidgetState createState() =>
      _FeaturedRecipeListWidgetState();
}

class _FeaturedRecipeListWidgetState extends State<FeaturedRecipeListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0), // Adds space above the whole widget
      child: widget.isFeaturedLoading
          ? _buildShimmerList()
          : widget.featuredRecipes.isEmpty
              ? const Center(
                  child: Text(
                    'No Featured Recipes Available',
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              : _buildRecipeList(),
    );
  }

  /// **Shimmer Loading Effect List**
  Widget _buildShimmerList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _buildShimmerCard(),
    );
  }

  /// **Shimmer Placeholder Card**
  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 190,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
      ),
    );
  }

  /// **Recipe List View**
  Widget _buildRecipeList() {
    return ListView.separated(
      key: const PageStorageKey<String>('featured_recipes_list'),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.featuredRecipes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildRecipeCard(widget.featuredRecipes[index]);
      },
    );
  }

  /// **Recipe Card UI**
  Widget _buildRecipeCard(FeaturedRecipe featuredRecipe) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DisplaySingleRecipeView(foodId: featuredRecipe.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 1),
              blurRadius: 1,
              spreadRadius: 1.5,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Recipe Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: (featuredRecipe.images.isNotEmpty)
                    ? featuredRecipe.images.first.imageUrl
                    : '',
                height: 190,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildShimmerCard(),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.image_not_supported, color: Colors.grey),
              ),
            ),

            // Featured Badge
            Positioned(
              top: 8,
              right: -40,
              child: Transform.rotate(
                angle: 0.785398,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                  decoration: const BoxDecoration(color: Colors.deepOrange),
                  child: Text(
                    'Featured',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Views and Likes
            Positioned(
              top: 8,
              left: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoContainer(
                      icon: Icons.remove_red_eye,
                      color: Colors.orange,
                      text: '${featuredRecipe.views} Views'),
                  const SizedBox(height: 8),
                  _buildInfoContainer(
                      icon: Icons.favorite,
                      color: Colors.red,
                      text: '${featuredRecipe.likes} Likes'),
                ],
              ),
            ),

            // Recipe Details
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildRecipeDetails(featuredRecipe),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoContainer({
    required IconData icon,
    required Color color,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0, .5),
              blurRadius: .5,
              spreadRadius: .5),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 3),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeDetails(FeaturedRecipe featuredRecipe) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(6),
        topRight: Radius.circular(6),
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.emoji_food_beverage,
                    size: 14, color: Colors.orange),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    featuredRecipe.foodName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    featuredRecipe.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        GoogleFonts.poppins(fontSize: 10, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

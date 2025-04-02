import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/models/list_recipes/popular_recipe_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/display_single_recipe_view.dart';

class MostViewedAndLikedRecipesWidget extends StatefulWidget {
  final List<PopularRecipe> popularRecipes;
  final bool isPopularLoading;

  const MostViewedAndLikedRecipesWidget({
    Key? key,
    required this.popularRecipes,
    required this.isPopularLoading,
  }) : super(key: key);

  @override
  _MostViewedAndLikedRecipesWidgetState createState() =>
      _MostViewedAndLikedRecipesWidgetState();
}

class _MostViewedAndLikedRecipesWidgetState
    extends State<MostViewedAndLikedRecipesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: widget.isPopularLoading
          ? _buildShimmerEffect()
          : widget.popularRecipes.isEmpty
              ? const Center(
                  child: Text(
                    'No Recipes Available',
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              : GridView.builder(
                  key: const PageStorageKey<String>(
                      'MostViewedAndLikedRecipesList'),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.popularRecipes.length,
                  cacheExtent: 500, // Prevent excessive memory usage
                  itemBuilder: (context, index) {
                    return _buildRecipeCard(
                        widget.popularRecipes[index], context);
                  },
                ),
    );
  }

  Widget _buildShimmerEffect() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) => _buildShimmerCard(),
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildRecipeCard(PopularRecipe popularRecipe, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DisplaySingleRecipeView(foodId: popularRecipe.id),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: (popularRecipe.images.isNotEmpty)
                    ? popularRecipe.images.first.imageUrl
                    : '',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                memCacheHeight: 300,
                memCacheWidth: 300,
                placeholder: (context, url) => _buildShimmerCard(),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.red),
              ),
            ),
            Positioned(
              top: 12,
              right: -40,
              child: Transform.rotate(
                angle: 0.785398,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                  decoration: const BoxDecoration(color: Colors.deepOrange),
                  child: Text(
                    'Popular',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Column(
                children: [
                  _buildInfoContainer(
                      icon: Icons.remove_red_eye,
                      color: Colors.orange,
                      text: '${popularRecipe.views} Views'),
                  const SizedBox(height: 8),
                  _buildInfoContainer(
                      icon: Icons.favorite,
                      color: Colors.red,
                      text: '${popularRecipe.likes} Likes'),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildRecipeDetails(popularRecipe),
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
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 4),
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

  Widget _buildRecipeDetails(PopularRecipe popularRecipe) {
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
          children: [
            Row(
              children: [
                const Icon(Icons.emoji_food_beverage,
                    size: 14, color: Colors.orange),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    popularRecipe.foodName,
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
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.access_time, size: 10, color: Colors.orange),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${popularRecipe.totalCookTime ?? 'N/A'} · ${popularRecipe.difficulty ?? 'N/A'} · ${popularRecipe.author ?? 'Unknown'}',
                    maxLines: 1,
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

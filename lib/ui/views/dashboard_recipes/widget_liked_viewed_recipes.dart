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
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0),
      child: widget.isPopularLoading
          ? _buildShimmerList()
          : widget.popularRecipes.isEmpty
              ? const Center(
                  child: Text(
                    'No Recipes Available',
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              : _buildRecipeList(),
    );
  }

  Widget _buildShimmerList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _buildShimmerCard(),
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 140,
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRecipeList() {
    return ListView.separated(
      key: const PageStorageKey<String>('popular_recipes_list'),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.popularRecipes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildRecipeCard(widget.popularRecipes[index], context);
      },
    );
  }

  Widget _buildRecipeCard(PopularRecipe popularRecipe, BuildContext context) {
    return InkWell(
      key: ValueKey(popularRecipe.id),
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
        height: 140,
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              offset: const Offset(0, 1),
              blurRadius: 1,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            // Image on the left
            SizedBox(
              width: 150,
              child: Stack(
                children: [
                  // Recipe Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: (popularRecipe.images.isNotEmpty)
                          ? popularRecipe.images.first.imageUrl
                          : '',
                      height: double.infinity,
                      width: 150,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(color: Colors.white),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 40),
                    ),
                  ),

                  // Popular Badge
                  Positioned(
                    top: 8,
                    left: -25,
                    child: Transform.rotate(
                      angle: -0.785398, // Adjusted angle for left side
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 3),
                        decoration:
                            const BoxDecoration(color: Colors.deepOrange),
                        child: Text(
                          'Popular',
                          style: GoogleFonts.poppins(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Recipe Details on the right
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recipe name
                    Row(
                      children: [
                        const Icon(Icons.emoji_food_beverage,
                            size: 16, color: Colors.orange),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            popularRecipe.foodName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    // Recipe details - cook time, difficulty, author
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 10, color: Colors.orange),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${popularRecipe.totalCookTime ?? 'N/A'} · ${popularRecipe.difficulty ?? 'N/A'} · ${popularRecipe.author ?? 'Unknown'}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 10, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

// New row for category
                    Row(
                      children: [
                        const Icon(Icons.restaurant_menu_rounded,
                            size: 10, color: Colors.orange),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            popularRecipe.category ?? 'Uncategorized',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 10, color: Colors.black),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Views and Likes at the bottom
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildInfoContainer(
                          icon: Icons.remove_red_eye,
                          color: Colors.orange,
                          text: '${popularRecipe.views} Views',
                        ),
                        const SizedBox(width: 8),
                        _buildInfoContainer(
                          icon: Icons.favorite,
                          color: Colors.red,
                          text: '${popularRecipe.likes} Likes',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
            offset: Offset(0, 0.5),
            blurRadius: 0.5,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

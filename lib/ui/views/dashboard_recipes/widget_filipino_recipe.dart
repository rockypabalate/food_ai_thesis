import 'package:flutter/material.dart';
import 'package:food_ai_thesis/models/list_recipes/list_recipes.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/display_single_recipe_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class FilipinoRecipeListWidget extends StatefulWidget {
  final List<FoodInfo> foodInfos;
  final bool isLoading;

  const FilipinoRecipeListWidget({
    Key? key,
    required this.foodInfos,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<FilipinoRecipeListWidget> createState() =>
      _FilipinoRecipeListWidgetState();
}

class _FilipinoRecipeListWidgetState extends State<FilipinoRecipeListWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Remove fixed height to allow vertical list to expand
      child: widget.isLoading
          ? _buildShimmerList()
          : widget.foodInfos.isEmpty
              ? const Center(
                  child: Text(
                    'No Recipes Available',
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              : _buildRecipeList(),
    );
  }

  /// **Shimmer Loading Effect**
  Widget _buildShimmerList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      scrollDirection: Axis.vertical, // Changed to vertical scrolling
      physics: const BouncingScrollPhysics(),
      itemCount: 4, // Limit shimmer items to prevent excessive memory usage
      separatorBuilder: (_, __) =>
          const SizedBox(height: 10), // Changed width to height
      itemBuilder: (context, index) => _buildShimmerCard(),
      shrinkWrap: true, // Added to ensure proper sizing
    );
  }

  /// **Shimmer Placeholder Card**
  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 150, // Set height instead of width for vertical cards
        margin: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 4.0),
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
      key: const PageStorageKey<String>('filipino_recipes_list'),
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      scrollDirection: Axis.vertical, // Changed to vertical scrolling
      physics: const BouncingScrollPhysics(),
      itemCount: widget.foodInfos.length,
      separatorBuilder: (_, __) =>
          const SizedBox(height: 10), // Changed width to height
      cacheExtent: 300, // Reduce memory usage
      itemBuilder: (context, index) =>
          _buildRecipeCard(widget.foodInfos[index], context),
      shrinkWrap: true, // Added to ensure proper sizing
    );
  }

  /// **Recipe Card Widget**
  Widget _buildRecipeCard(FoodInfo foodInfo, BuildContext context) {
    return InkWell(
      key: ValueKey(foodInfo.id),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplaySingleRecipeView(foodId: foodInfo.id),
          ),
        );
      },
      child: Container(
        height: 140, // Set a fixed height for the card
        margin: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 4.0),
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
          // Changed from Stack to Row for horizontal card layout
          children: [
            // Image on the left
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: SizedBox(
                width: 150, // Fixed width for the image section
                child: CachedNetworkImage(
                  imageUrl: (foodInfo.imageUrls.isNotEmpty)
                      ? foodInfo.imageUrls.first // Always take the first image
                      : '', // Fallback if no images exist
                  height: double.infinity,
                  width: 150,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(color: Colors.white),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
            // Details on the right
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
                            foodInfo.foodName,
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
                    const SizedBox(height: 8),
                    // Cooking time, difficulty, and author
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 12, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text(
                          foodInfo.totalCookTime ?? 'N/A',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${foodInfo.difficulty ?? 'N/A'} · ${foodInfo.author ?? 'Unknown'}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    // Stats (views and likes)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _infoContainer(
                          icon: Icons.remove_red_eye,
                          text: '${foodInfo.views} Views',
                          iconColor: Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        _infoContainer(
                          icon: Icons.favorite,
                          text: '${foodInfo.likes} Likes',
                          iconColor: Colors.red,
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

  /// **Information Container for Views & Likes**
  Widget _infoContainer({
    required IconData icon,
    required String text,
    required Color iconColor,
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
        children: [
          Icon(icon, size: 12, color: iconColor),
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

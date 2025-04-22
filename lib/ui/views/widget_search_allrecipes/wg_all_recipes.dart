import 'package:flutter/material.dart';
import 'package:food_ai_thesis/models/list_recipes/list_recipes.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/display_single_recipe_view.dart';
import 'package:food_ai_thesis/utils/shimmer_loading_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class AllRecipesWidget extends StatelessWidget {
  final List<FoodInfo> foodInfos;
  final bool isLoading;

  const AllRecipesWidget({
    Key? key,
    required this.foodInfos,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isLoading
            ? const Center(
                child: ShimmerLoadingWidget(),
              )
            : foodInfos.isEmpty
                ? const Center(
                    child: Text(
                      'No Recipes Available',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    shrinkWrap:
                        true, // Ensures GridView does not expand infinitely
                    physics:
                        const NeverScrollableScrollPhysics(), // Prevents GridView from scrolling independently
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 12, // Space between columns
                      mainAxisSpacing: 5, // Space between rows
                      childAspectRatio: 0.75, // Adjust height-to-width ratio
                    ),
                    itemCount: foodInfos.length,
                    itemBuilder: (context, index) {
                      final foodInfo = foodInfos[index];
                      return InkWell(
                        onTap: () {
                          // Also unfocus any other input
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DisplaySingleRecipeView(foodId: foodInfo.id),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 24,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 1.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.1), // Shadow color
                                offset: const Offset(0, 1), // Shadow position
                                blurRadius: 1, // Blur radius
                                spreadRadius: 1, // Spread radius
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  (foodInfo.imageUrls.isNotEmpty)
                                      ? foodInfo.imageUrls
                                          .first // Always take the first image
                                      : '', // Fallback if no images exist
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,

                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error,
                                          color: Colors.red),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12, // Shadow color
                                        offset: Offset(0,
                                            .5), // Shadow offset (horizontal, vertical)
                                        blurRadius: .5, // Shadow blur
                                        spreadRadius: .5, // Spread of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      // Views
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.remove_red_eye,
                                            size: 10,
                                            color: Colors.orange,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${foodInfo.views}  Views',
                                            style: GoogleFonts.poppins(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                          width:
                                              5), // Space between views and likes
                                      // Likes
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons
                                                .favorite, // Changed from thumb_up to favorite
                                            size: 10,
                                            color: Colors
                                                .red, // Changed color to red
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${foodInfo.likes}  Likes',
                                            style: GoogleFonts.poppins(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: const BoxDecoration(
                                      color: Colors
                                          .white, // Replaced the semi-transparent black with solid grey
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.emoji_food_beverage,
                                              size: 14,
                                              color: Colors.orange,
                                            ),
                                            const SizedBox(width: 4),
                                            Flexible(
                                              child: Text(
                                                foodInfo.foodName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange,
                                                  shadows: const [
                                                    Shadow(
                                                      offset: Offset(0, .3),
                                                      blurRadius: .1,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.access_time,
                                              size: 10,
                                              color: Colors.orange,
                                            ),
                                            const SizedBox(width: 4),
                                            Flexible(
                                              child: Text(
                                                '${foodInfo.totalCookTime ?? 'N/A'} · ${foodInfo.difficulty ?? 'N/A'} · ${foodInfo.author ?? 'Unknown'}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ],
    );
  }
}
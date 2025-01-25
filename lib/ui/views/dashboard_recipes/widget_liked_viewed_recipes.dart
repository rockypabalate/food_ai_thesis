import 'package:flutter/material.dart';
import 'package:food_ai_thesis/models/list_recipes/list_recipes.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/display_single_recipe_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class MostViewedAndLikedRecipesWidget extends StatelessWidget {
  final List<FoodInfo> mostViewedAndLikedRecipes;
  final bool isLoading;

  const MostViewedAndLikedRecipesWidget({
    Key? key,
    required this.mostViewedAndLikedRecipes,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : mostViewedAndLikedRecipes.isEmpty
                ? const Center(
                    child: Text(
                      'No Recipes Available',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )
                : SizedBox(
                    height: 220, // Adjust the height as needed
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: mostViewedAndLikedRecipes.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final foodInfo = mostViewedAndLikedRecipes[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DisplaySingleRecipeView(
                                    foodId: foodInfo.id),
                              ),
                            );
                          },
                          child: Container(
                            width: 153,
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
                                  spreadRadius: 1.5, // Spread radius
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    foodInfo.imageUrl ?? '',
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top:
                                      12, // Adjust the position for the rotation effect
                                  right:
                                      -40, // Adjust the position for the rotation effect
                                  child: Transform.rotate(
                                    angle:
                                        0.785398, // Approximately -45 degrees in radians
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 5),
                                      decoration: const BoxDecoration(
                                        color: Colors
                                            .deepOrange, // Customize the banner color
                                      ),
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
                                      // Views Container
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors
                                                  .black12, // Shadow color
                                              offset: Offset(0,
                                                  .5), // Shadow offset (horizontal, vertical)
                                              blurRadius: .5, // Shadow blur
                                              spreadRadius:
                                                  .5, // Spread of shadow
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.remove_red_eye,
                                              size: 10,
                                              color: Colors.orange,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${foodInfo.views} Views',
                                              style: GoogleFonts.poppins(
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                          height:
                                              8), // Space between the two containers
                                      // Likes Container
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors
                                                  .black12, // Shadow color
                                              offset: Offset(0,
                                                  .5), // Shadow offset (horizontal, vertical)
                                              blurRadius: .5, // Shadow blur
                                              spreadRadius:
                                                  .5, // Spread of shadow
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.favorite,
                                              size: 10,
                                              color: Colors.red,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${foodInfo.likes} Likes',
                                              style: GoogleFonts.poppins(
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: const BoxDecoration(
                                        color: Colors
                                            .white, // Replaced black with opacity with solid white
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                  ),
      ],
    );
  }
}

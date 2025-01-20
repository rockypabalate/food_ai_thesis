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
                    height: 210, // Adjust the height as needed
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
                              horizontal: 1.0,
                              vertical: 4.0,
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
                                // Positioned(
                                //   top: 75,
                                //   right: 8,
                                //   child: Column(
                                //     mainAxisSize: MainAxisSize.min,
                                //     children: [
                                //       GestureDetector(
                                //         onTap: () {
                                //           // Handle like tap
                                //         },
                                //         child: Stack(
                                //           alignment: Alignment
                                //               .center, // Centers the icon inside the blurred container
                                //           children: [
                                //             ClipRRect(
                                //               borderRadius: BorderRadius.circular(
                                //                   50), // Circular shape for the blur
                                //               child: BackdropFilter(
                                //                 filter: ImageFilter.blur(
                                //                     sigmaX: 1,
                                //                     sigmaY:
                                //                         1), // Stronger blur for glassmorphism
                                //                 child: Container(
                                //                   width:
                                //                       30, // Adjust size as needed
                                //                   height: 30,
                                //                   decoration: BoxDecoration(
                                //                     color: Colors.white.withOpacity(
                                //                         0.15), // Transparent frosted background
                                //                     shape: BoxShape.circle,
                                //                     border: Border.all(
                                //                       color: Colors.white
                                //                           .withOpacity(
                                //                               0.4), // Subtle white border
                                //                       width: .8,
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //             ),
                                //             const Icon(
                                //               Icons.favorite,
                                //               size: 17,
                                //               color: Colors.white,
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //       const SizedBox(height: 10),
                                //       GestureDetector(
                                //         onTap: () {
                                //           // Handle bookmark tap
                                //         },
                                //         child: Stack(
                                //           alignment: Alignment
                                //               .center, // Centers the icon inside the blurred container
                                //           children: [
                                //             ClipRRect(
                                //               borderRadius: BorderRadius.circular(
                                //                   50), // Circular shape for the blur
                                //               child: BackdropFilter(
                                //                 filter: ImageFilter.blur(
                                //                     sigmaX: 1,
                                //                     sigmaY:
                                //                         1), // Stronger blur for glassmorphism
                                //                 child: Container(
                                //                   width:
                                //                       30, // Adjust size as needed
                                //                   height: 30,
                                //                   decoration: BoxDecoration(
                                //                     color: Colors.white.withOpacity(
                                //                         0.15), // Transparent frosted background
                                //                     shape: BoxShape.circle,
                                //                     border: Border.all(
                                //                       color: Colors.white
                                //                           .withOpacity(
                                //                               0.4), // Subtle white border
                                //                       width: .8,
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //             ),
                                //             const Icon(
                                //               Icons.bookmark,
                                //               size: 17,
                                //               color: Colors.white,
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(16),
                                    ),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 2, sigmaY: 2),
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.2),
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      color: Colors.white,
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

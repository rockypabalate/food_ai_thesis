import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_ai_thesis/models/list_recipes/list_recipes.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/display_single_recipe_view.dart';
import 'package:google_fonts/google_fonts.dart';

class FilipinoRecipeListWidget extends StatelessWidget {
  final List<FoodInfo> foodInfos;
  final bool isLoading;

  const FilipinoRecipeListWidget({
    Key? key,
    required this.foodInfos,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (foodInfos.isEmpty) {
      return const Center(
        child: Text(
          'No Recipes Available',
          style: TextStyle(fontSize: 16.0),
        ),
      );
    }

    return SizedBox(
      height: 190, // Adjust the height as needed
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        scrollDirection: Axis.horizontal,
        itemCount: foodInfos.length,
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final foodInfo = foodInfos[index];

          return InkWell(
            onTap: () {
              // Handle recipe tap here
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DisplaySingleRecipeView(foodId: foodInfo.id),
                ),
              );
            },
            child: Container(
              width: 323,
              margin:
                  const EdgeInsets.symmetric(horizontal: 1.0, vertical: 4.0),
              child: Stack(
                children: [
                  // Background image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      foodInfo.imageUrl ?? '',
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Views and likes container
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Row(
                      children: [
                        // Views container
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.remove_red_eye,
                                size: 12,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${foodInfo.views}',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Views',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 8),
                        // Likes container
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.favorite,
                                size: 12,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${foodInfo.likes}',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Likes',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Icons for like and bookmark in a row with circular container
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Handle like tap
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.favorite,
                              size: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            // Handle bookmark tap
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.bookmark,
                              size: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Information overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Food name with icon
                              Row(
                                children: [
                                  const Icon(
                                    Icons
                                        .emoji_food_beverage, // Change this to any relevant icon, e.g., chef icon
                                    size: 18,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      foodInfo.foodName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
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
                              // Total cook time with icon, difficulty, and author
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 12,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    foodInfo.totalCookTime ?? 'N/A',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '· ${foodInfo.difficulty ?? 'N/A'} · ${foodInfo.author ?? 'Unknown'}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
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
    );
  }
}

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/display_single_recipe_view.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/recipe_slide_animation.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/user_dashboard_viewmodel.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/widgets_delete_button.dart';
import 'package:food_ai_thesis/utils/shimmer_bookmark.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

class BookmarkedRecipesTab extends StatefulWidget {
  const BookmarkedRecipesTab({Key? key}) : super(key: key);

  @override
  _BookmarkedRecipesTabState createState() => _BookmarkedRecipesTabState();
}

class _BookmarkedRecipesTabState extends State<BookmarkedRecipesTab> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ViewModelBuilder<UserDashboardViewModel>.reactive(
      viewModelBuilder: () => UserDashboardViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.getSavedRecipesByUser();

        _searchController.addListener(() {
          viewModel.filterRecipes(_searchController.text);
        });
      },
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 8.0),
                    child: TextField(
                      controller: _searchController,
                      enabled: viewModel.savedRecipes.isNotEmpty,
                      decoration: InputDecoration(
                        labelText: 'Search Bookmarked Recipes',
                        labelStyle: TextStyle(
                          color: viewModel.savedRecipes.isNotEmpty
                              ? Colors.black
                              : Colors.grey,
                        ),
                        hintStyle: const TextStyle(color: Colors.black),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 1.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: viewModel.isBusy
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 6,
                            itemBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ShimmerBookmark(),
                            ),
                          )
                        : viewModel.savedRecipes.isEmpty
                            ? SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 320,
                                      child: Lottie.asset(
                                        'lib/assets/not_found.json',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    const Text(
                                      'Looks like you didn\'t save any recipes',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        viewModel.navigateToSearchRecipes();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.green,
                                      ),
                                      child: const Text('Search Recipes'),
                                    ),
                                  ],
                                ),
                              )
                            : GridView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                shrinkWrap: true,
                                cacheExtent:
                                    300, // 🔥 Add cache extent to preload images
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: getCrossAxisCount(context),
                                  crossAxisSpacing: screenWidth * 0.01,
                                  mainAxisSpacing: screenWidth * 0.01,
                                  childAspectRatio: .82,
                                ),
                                itemCount: viewModel.filteredFoodInfos.length,
                                itemBuilder: (context, index) {
                                  final recipe =
                                      viewModel.filteredFoodInfos[index];
                                  final delay = index * 70;

                                  return RecipeSlideAnimation(
                                    delay: delay,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DisplaySingleRecipeView(
                                              foodId: recipe.id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4.0, vertical: 4),
                                        child: Stack(
                                          children: [
                                            // ✅ Cached Image
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Hero(
                                                tag: '${recipe.id}',
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      recipe.image?.imageUrl ??
                                                          '',
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      const SizedBox
                                                          .shrink(), // 🔥 No loading indicator
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.fastfood,
                                                          size: 50),
                                                ),
                                              ),
                                            ),

                                            // Views & Likes
                                            Positioned(
                                              top: 8,
                                              left: 8,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 4.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                            Icons
                                                                .remove_red_eye,
                                                            size: 10,
                                                            color:
                                                                Colors.orange),
                                                        const SizedBox(
                                                            width: 4),
                                                        Text(
                                                          '${recipe.views} Views',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 8,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                            Icons.favorite,
                                                            size: 10,
                                                            color: Colors.red),
                                                        const SizedBox(
                                                            width: 4),
                                                        Text(
                                                          '${recipe.likes} Likes',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 8,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            // Delete Button
                                            DeleteButton(
                                              onDelete: () async {
                                                await viewModel
                                                    .deleteFoodById(recipe.id);
                                                await viewModel
                                                    .getSavedRecipesByUser();
                                              },
                                            ),

                                            // Recipe Details
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.vertical(
                                                        bottom: Radius.circular(
                                                            16)),
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                      sigmaX: 7, sigmaY: 7),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                                Icons
                                                                    .emoji_food_beverage,
                                                                size: 14,
                                                                color: Colors
                                                                    .orange),
                                                            const SizedBox(
                                                                width: 4),
                                                            Flexible(
                                                              child: Text(
                                                                recipe.foodName,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .orange,
                                                                  shadows: const [
                                                                    Shadow(
                                                                        offset: Offset(
                                                                            0,
                                                                            .3),
                                                                        blurRadius:
                                                                            .1,
                                                                        color: Colors
                                                                            .white),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                                Icons
                                                                    .access_time,
                                                                size: 10,
                                                                color: Colors
                                                                    .orange),
                                                            const SizedBox(
                                                                width: 4),
                                                            Flexible(
                                                              child: Text(
                                                                '${recipe.totalCookTime ?? 'N/A'} · ${recipe.difficulty ?? 'N/A'} · by ${recipe.author ?? 'Unknown'}',
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .white,
                                                                ),
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
                                    ),
                                  );
                                },
                              ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  int getCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 1200) {
      return 4;
    } else if (screenWidth >= 800) {
      return 3;
    } else {
      return 2;
    }
  }
}

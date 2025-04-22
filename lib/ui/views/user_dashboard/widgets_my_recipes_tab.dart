import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/create_recipe/create_recipe_view.dart';
import 'package:food_ai_thesis/ui/views/single_view_page_recipe/single_view_page_recipe_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/user_dashboard_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRecipesTab extends StatelessWidget {
  const MyRecipesTab({Key? key}) : super(key: key);

  int getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 600 ? 2 : 3;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ViewModelBuilder<UserDashboardViewModel>.reactive(
      viewModelBuilder: () => UserDashboardViewModel(),
      onModelReady: (viewModel) => viewModel.getAllUserRecipes(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 17.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0), // <-- added horizontal padding
                    child: SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        onChanged: (query) =>
                            viewModel.userfilterRecipes(query),
                        enabled: viewModel.allUserRecipes.isNotEmpty,
                        decoration: InputDecoration(
                          labelText: 'Search Recipes',
                          labelStyle: TextStyle(
                            color: viewModel.allUserRecipes.isNotEmpty
                                ? Colors.black
                                : Colors.grey,
                          ),
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 1.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 7),
              Expanded(
                child: viewModel.isBusy
                    ? const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SpinKitThreeBounce(
                              color: Colors.orange,
                              size: 30.0,
                            ),
                            SizedBox(
                                height: 12), // Space between loader and text
                            Text(
                              'Loading created recipes...',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      )
                    : viewModel.userRecipes.isEmpty
                        ? Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: SizedBox(
                                    height: 320,
                                    child: Lottie.asset(
                                        'lib/assets/not_found.json',
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              const Text(
                                "No recipes found",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(flex: 1),
                            ],
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 2.0),
                            shrinkWrap: true,
                            cacheExtent: 500, // Improves scrolling performance
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: getCrossAxisCount(context),
                              crossAxisSpacing: screenWidth * 0.01,
                              mainAxisSpacing: screenWidth * 0.01,
                              childAspectRatio: 0.82,
                            ),
                            itemCount: viewModel.userRecipes.length,
                            itemBuilder: (context, index) {
                              final recipe = viewModel.userRecipes[index];

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SingleViewPageRecipeView(
                                              recipeId:
                                                  recipe.recipeId.toString()),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: .8),
                                  ),
                                  child: Stack(
                                    children: [
                                      // Recipe Image with Caching
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: CachedNetworkImage(
                                          imageUrl: recipe.images.isNotEmpty
                                              ? '${recipe.images.first}?w=500&auto=compress'
                                              : '',
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              noImageWidget(),
                                          errorWidget: (context, url, error) =>
                                              noImageWidget(),
                                        ),
                                      ),

                                      // Recipe Details Overlay
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  bottom: Radius.circular(16)),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 7, sigmaY: 7),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.2)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .emoji_food_beverage,
                                                        size: 14,
                                                        color: Colors.orange,
                                                      ),
                                                      const SizedBox(
                                                          width:
                                                              4), // Optional spacing between icon and text
                                                      Text(
                                                        recipe.foodName,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.orange,
                                                          shadows: const [
                                                            Shadow(
                                                              offset:
                                                                  Offset(0, .3),
                                                              blurRadius: .1,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ],
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
                                                          color: Colors.orange),
                                                      const SizedBox(width: 4),
                                                      Flexible(
                                                        child: Text(
                                                          '${recipe.totalCookTime} · ${recipe.difficulty}',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 10,
                                                            color: Colors.white,
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
                              );
                            },
                          ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateRecipeView()));
            },
            backgroundColor: Colors.orange,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, size: 28, color: Colors.white),
          ),
        );
      },
    );
  }
}

// Widget for handling cases where no image is available
Widget noImageWidget() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.grey.shade200,
    ),
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.image_not_supported, size: 60, color: Colors.grey),
        SizedBox(height: 2),
        Text("No Image", style: TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    ),
  );
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/create_recipe/create_recipe_view.dart';
import 'package:food_ai_thesis/ui/views/single_view_page_recipe/single_view_page_recipe_view.dart';
import 'package:food_ai_thesis/utils/shimmer_loading_widget.dart';
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
                  child: SizedBox(
                    width: 330, // Adjust the width as needed
                    child: TextFormField(
                      onChanged: (query) => viewModel.userfilterRecipes(query),
                      enabled: viewModel
                          .allUserRecipes.isNotEmpty, // Use the original list
                      decoration: InputDecoration(
                        labelText: 'Search Recipes',
                        labelStyle: TextStyle(
                          color: viewModel.allUserRecipes.isNotEmpty
                              ? Colors.black
                              : Colors.grey,
                        ),
                        hintStyle: const TextStyle(color: Colors.black),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                            width: 1.0,
                          ),
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
              Expanded(
                child: viewModel.isBusy
                    ? const Center(child: ShimmerLoadingWidget())
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
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                "No recipes found",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(flex: 1),
                            ],
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            shrinkWrap: true,
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
                                      color: Colors.grey.shade300,
                                      width: .8,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      // Recipe Image or Placeholder
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: recipe.images.isNotEmpty
                                            ? Image.network(
                                                recipe.images.first,
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return noImageWidget();
                                                },
                                              )
                                            : noImageWidget(),
                                      ),

                                      // Recipe Details Overlay
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            bottom: Radius.circular(16),
                                          ),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 7, sigmaY: 7),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    recipe.foodName,
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
                  builder: (context) => const CreateRecipeView(),
                ),
              );
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
        Icon(
          Icons.image_not_supported,
          size: 50,
          color: Colors.grey,
        ),
        SizedBox(height: 8),
        Text(
          "No Image",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    ),
  );
}

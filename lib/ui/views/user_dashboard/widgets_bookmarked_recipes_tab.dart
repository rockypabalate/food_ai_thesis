import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/user_dashboard_viewmodel.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = EdgeInsets.all(screenWidth * 0.02);
    final cardHeight = screenHeight * 0.15;
    final fontSizeTitle = screenWidth * 0.04;
    final fontSizeDescription = screenWidth * 0.035;

    return ViewModelBuilder<UserDashboardViewModel>.reactive(
      viewModelBuilder: () => UserDashboardViewModel(),
      onViewModelReady: (viewModel) {
        //    viewModel.getSavedRecipesByUser();

        _searchController.addListener(() {
          //     viewModel.filterRecipes(_searchController.text);
        });
      },
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
              //   child: TextField(
              //     controller: _searchController,
              //     enabled: viewModel.savedRecipes
              //         .isNotEmpty, // Disable search if no recipes saved
              //     decoration: InputDecoration(
              //       labelText: 'Search Bookmarked Recipes',
              //       labelStyle: TextStyle(
              //         color: viewModel.savedRecipes.isNotEmpty
              //             ? Colors.black
              //             : Colors.grey, // Change label color if disabled
              //       ),
              //       hintStyle: const TextStyle(color: Colors.black),
              //       prefixIcon: const Icon(Icons.search),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10.0),
              //         borderSide: const BorderSide(
              //           color: Color.fromARGB(255, 0, 0, 0),
              //           width: 1.0,
              //         ),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10.0),
              //         borderSide: const BorderSide(
              //           color: Color.fromARGB(255, 0, 0, 0),
              //           width: 1.0,
              //         ),
              //       ),
              //       filled: true,
              //       fillColor: Colors.white,
              //       contentPadding: const EdgeInsets.symmetric(
              //           vertical: 10.0, horizontal: 15.0),
              //     ),
              //     style: const TextStyle(color: Colors.black),
              //   ),
              // ),
              // Expanded(
              //   child: viewModel.isBusy
              //       ? ListView.builder(
              //           shrinkWrap: true,
              //           physics: const NeverScrollableScrollPhysics(),
              //           itemCount: 6,
              //           itemBuilder: (context, index) => const Padding(
              //             padding: EdgeInsets.all(8.0),
              //             child: ShimmerLoadingWidget(),
              //           ),
              //         )
              //       : viewModel.savedRecipes
              //               .isEmpty // Check if no recipes were saved at all
              //           ? SingleChildScrollView(
              //               // Wrap the entire content to make it scrollable
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 children: [
              //                   // Add some space from the top of the screen
              //                   SizedBox(
              //                     height: 320,
              //                     child: Lottie.asset(
              //                       'lib/assets/not_found.json', // You might want a different asset for this
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                   const SizedBox(height: 20.0),
              //                   const Text(
              //                     'Looks like you didn\'t save any recipes',
              //                     style: TextStyle(
              //                       fontSize: 15,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                   const SizedBox(height: 8),
              //                   ElevatedButton(
              //                     onPressed: () {
              //                       viewModel.navigationservice
              //                           .navigateTo(Routes.displayRecipesView);
              //                     },
              //                     style: ElevatedButton.styleFrom(
              //                       foregroundColor: Colors.white,
              //                       backgroundColor: Colors.green,
              //                     ),
              //                     child: const Text('Search Recipes'),
              //                   ),
              //                 ],
              //               ),
              //             )
              //           : viewModel.filteredFoodInfos
              //                   .isEmpty // If no search results found
              //               ? SingleChildScrollView(
              //                   // Make this part scrollable too
              //                   child: Column(
              //                     mainAxisAlignment: MainAxisAlignment.start,
              //                     children: [
              //                       // Add some space from the top of the screen
              //                       SizedBox(
              //                         height: 320,
              //                         child: Lottie.asset(
              //                           'lib/assets/not_found.json',
              //                           fit: BoxFit.cover,
              //                         ),
              //                       ),
              //                       const SizedBox(height: 20.0),
              //                       const Text(
              //                         'No recipes match your search',
              //                         style: TextStyle(
              //                           fontSize: 15,
              //                           fontWeight: FontWeight.bold,
              //                         ),
              //                       ),
              //                       const SizedBox(height: 8),
              //                     ],
              //                   ),
              //                 )
              //               : GridView.builder(
              //                   padding: EdgeInsets.zero,
              //                   shrinkWrap: true,
              //                   physics: const AlwaysScrollableScrollPhysics(),
              //                   gridDelegate:
              //                       SliverGridDelegateWithFixedCrossAxisCount(
              //                     crossAxisCount: getCrossAxisCount(context),
              //                     crossAxisSpacing: screenWidth * 0.01,
              //                     mainAxisSpacing: screenWidth * 0.01,
              //                     childAspectRatio: 0.80,
              //                   ),
              //                   itemCount: viewModel.filteredFoodInfos.length,
              //                   itemBuilder: (context, index) {
              //                     final recipe =
              //                         viewModel.filteredFoodInfos[index];
              //                     final delay = index * 70;

              //                     return RecipeSlideAnimation(
              //                       delay: delay,
              //                       child: Stack(
              //                         children: [
              //                           InkWell(
              //                             onTap: () {
              //                               Navigator.push(
              //                                 context,
              //                                 MaterialPageRoute(
              //                                   builder: (context) =>
              //                                       DisplaySingleRecipeView(
              //                                     foodId: recipe.id,
              //                                   ),
              //                                 ),
              //                               );
              //                             },
              //                             child: Card(
              //                               color: const Color.fromARGB(
              //                                   255, 253, 253, 253),
              //                               margin: padding,
              //                               child: Column(
              //                                 crossAxisAlignment:
              //                                     CrossAxisAlignment.start,
              //                                 children: [
              //                                   recipe.images.isNotEmpty
              //                                       ? Hero(
              //                                           tag:
              //                                               'food_image_${recipe.id}',
              //                                           child: Image.network(
              //                                             recipe.images[0]
              //                                                 .imageUrl,
              //                                             width:
              //                                                 double.infinity,
              //                                             height: cardHeight,
              //                                             fit: BoxFit.cover,
              //                                             errorBuilder:
              //                                                 (context, error,
              //                                                     stackTrace) {
              //                                               return const Icon(
              //                                                   Icons.fastfood);
              //                                             },
              //                                           ),
              //                                         )
              //                                       : const Icon(Icons.fastfood,
              //                                           size: 50),
              //                                   Padding(
              //                                     padding: padding,
              //                                     child: Text(
              //                                       recipe.foodName,
              //                                       style: GoogleFonts.poppins(
              //                                         fontWeight:
              //                                             FontWeight.bold,
              //                                         fontSize: fontSizeTitle,
              //                                         color: Colors.orange,
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   Padding(
              //                                     padding: EdgeInsets.symmetric(
              //                                         horizontal:
              //                                             screenWidth * 0.02),
              //                                     child: Text(
              //                                       recipe.description,
              //                                       maxLines: 2,
              //                                       overflow:
              //                                           TextOverflow.ellipsis,
              //                                       style: GoogleFonts.poppins(
              //                                         fontSize:
              //                                             fontSizeDescription,
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                           ),
              //                           DeleteButton(
              //                             onDelete: () async {
              //                               // Directly call deleteFoodById without confirmation
              //                               await viewModel
              //                                   .deleteFoodById(recipe.id);
              //                               // Optionally refresh the saved recipes
              //                               await viewModel
              //                                   .getSavedRecipesByUser();
              //                             },
              //                           ),
              //                         ],
              //                       ),
              //                     );
              //                   },
              //                 ),
              // ),
            ],
          ),
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

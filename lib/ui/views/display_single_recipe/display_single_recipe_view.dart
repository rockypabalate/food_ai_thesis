import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/widgest_delayed_fadein.dart';
import 'package:food_ai_thesis/ui/views/display_single_recipe/widgets_single_view_page_compenents.dart';
import 'package:stacked/stacked.dart';
import 'display_single_recipe_viewmodel.dart';

class DisplaySingleRecipeView
    extends StackedView<DisplaySingleRecipeViewModel> {
  final int foodId;

  const DisplaySingleRecipeView({Key? key, required this.foodId})
      : super(key: key);

  @override
  Widget builder(BuildContext context, DisplaySingleRecipeViewModel viewModel,
      Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: viewModel.isBusy
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpinKitThreeBounce(
                    color: Colors.orange,
                    size: 40.0,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Fetching recipes...',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            )
          : viewModel.foodInfoById != null
              ? CustomScrollView(
                  slivers: [
                    RecipeWidgets.buildSliverAppBar(viewModel, context),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// 📌 Icons aligned to the right above the food title
                              DelayedFadeIn(
                                delay: 100,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: RecipeWidgets
                                      .buildFavoriteAndBookmarkIcons(context,
                                          viewModel), // Pass context here
                                ),
                              ),

                              const SizedBox(height: 5),

                              /// 🥘 Food Title
                              if (viewModel.foodInfoById!.images.isNotEmpty)
                                DelayedFadeIn(
                                  delay: 150,
                                  child: RecipeWidgets.buildFoodTitle(
                                    viewModel.foodInfoById!.foodName,
                                  ),
                                ),

                              /// 👤 Author
                              DelayedFadeIn(
                                delay: 200,
                                child: RecipeWidgets.buildAuthor(
                                  viewModel.foodInfoById!.author,
                                ),
                              ),
                              const SizedBox(height: 15),

                              /// ❤️ Views & Likes Box
                              DelayedFadeIn(
                                delay: 250,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: RecipeWidgets.buildViewsAndLikes(
                                    viewModel.foodInfoById!.views,
                                    viewModel.foodInfoById!.likes,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),

                              /// 🖼️ Food Images
                              DelayedFadeIn(
                                delay: 300,
                                child: RecipeWidgets.buildFoodImagesSection(
                                    viewModel),
                              ),
                              const SizedBox(height: 20),

                              /// 📝 Details
                              DelayedFadeIn(
                                delay: 400,
                                child: RecipeWidgets.buildFoodDetails(
                                  servingSize:
                                      viewModel.foodInfoById!.servingSize,
                                  totalCookTime:
                                      viewModel.foodInfoById!.totalCookTime,
                                  difficulty:
                                      viewModel.foodInfoById!.difficulty,
                                  category: viewModel.foodInfoById!.category,
                                ),
                              ),

                              const DelayedFadeIn(
                                delay: 450,
                                child: SizedBox(height: 20),
                              ),

                              /// 📃 Description
                              DelayedFadeIn(
                                delay: 500,
                                child: RecipeWidgets.buildFoodDescription(
                                  viewModel.foodInfoById!.description,
                                ),
                              ),

                              const DelayedFadeIn(
                                delay: 600,
                                child: SizedBox(height: 20),
                              ),

                              /// 💡 Tips
                              DelayedFadeIn(
                                delay: 700,
                                child: RecipeWidgets.buildPreparationTips(
                                  viewModel.foodInfoById!.preparationTips,
                                ),
                              ),

                              const SizedBox(height: 15),
                              DelayedFadeIn(
                                delay: 800,
                                child: RecipeWidgets.buildSectionTitle(''),
                              ),

                              /// 🧂 Ingredients
                              DelayedFadeIn(
                                delay: 900,
                                child: RecipeWidgets.buildCardContent(
                                  viewModel.foodInfoById!.ingredients,
                                ),
                              ),

                              const DelayedFadeIn(
                                delay: 1000,
                                child: SizedBox(height: 20),
                              ),

                              DelayedFadeIn(
                                delay: 1100,
                                child: RecipeWidgets.buildSectionTitle(''),
                              ),
                              const DelayedFadeIn(
                                delay: 1200,
                                child: SizedBox(height: 10),
                              ),

                              /// 🔪 Instructions
                              DelayedFadeIn(
                                delay: 1300,
                                child: RecipeWidgets.buildCardInstructions(
                                  viewModel.foodInfoById!.instructions,
                                ),
                              ),

                              const DelayedFadeIn(
                                delay: 1400,
                                child: SizedBox(height: 20),
                              ),

                              DelayedFadeIn(
                                delay: 1500,
                                child: RecipeWidgets.buildSectionTitle(''),
                              ),
                              const DelayedFadeIn(
                                delay: 1600,
                                child: SizedBox(height: 10),
                              ),

                              /// 🔬 Nutritional Info
                              DelayedFadeIn(
                                delay: 1700,
                                child: RecipeWidgets.buildCardNutrients(
                                  viewModel.foodInfoById!.nutritionalContent,
                                  viewModel.foodInfoById!.nutritionalParagraph,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ],
                )
              : const Center(child: Text('No food information found')),
    );
  }

  @override
  DisplaySingleRecipeViewModel viewModelBuilder(BuildContext context) =>
      DisplaySingleRecipeViewModel();

  @override
  void onViewModelReady(DisplaySingleRecipeViewModel viewModel) {
    super.onViewModelReady(viewModel);
    someFunction(viewModel);
  }

  void someFunction(DisplaySingleRecipeViewModel viewModel) async {
    viewModel.fetchFoodInfoById(foodId);
  }
}

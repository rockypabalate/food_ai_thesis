import 'package:flutter/material.dart';
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
              child: CircularProgressIndicator(),
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
                              if (viewModel.foodInfoById!.images.isNotEmpty)
                                DelayedFadeIn(
                                  delay: 150,
                                  child: RecipeWidgets.buildFoodTitle(
                                    viewModel.foodInfoById!.foodName,
                                  ),
                                ),
                              DelayedFadeIn(
                                delay: 200,
                                child: RecipeWidgets.buildAuthor(
                                  viewModel.foodInfoById!.author,
                                ),
                              ),
                              const SizedBox(height: 15),
                              DelayedFadeIn(
                                delay: 100,
                                child: RecipeWidgets.buildFoodImagesSection(
                                    viewModel),
                              ),
                              const SizedBox(height: 20),
                              // DelayedFadeIn(
                              //   delay: 200,
                              //   child: RecipeWidgets.buildViewsAndLikes(
                              //     viewModel.foodInfoById!.views,
                              //     viewModel.foodInfoById!.likes,
                              //   ),
                              // ),

                              DelayedFadeIn(
                                delay: 200,
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
                                delay: 250,
                                child: SizedBox(height: 20),
                              ),
                              DelayedFadeIn(
                                  delay: 250,
                                  child: RecipeWidgets.buildFoodDescription(
                                    viewModel.foodInfoById!.description,
                                  )),
                              const DelayedFadeIn(
                                delay: 350,
                                child: SizedBox(height: 20),
                              ),
                              DelayedFadeIn(
                                delay: 600,
                                child: RecipeWidgets.buildPreparationTips(
                                  viewModel.foodInfoById!.preparationTips,
                                ),
                              ),
                              const SizedBox(height: 15),
                              DelayedFadeIn(
                                delay: 800,
                                child: RecipeWidgets.buildSectionTitle(''),
                              ),
                              DelayedFadeIn(
                                delay: 1000,
                                child: RecipeWidgets.buildCardContent(
                                  viewModel.foodInfoById!.ingredients,
                                  viewModel.foodInfoById!.ingredientQuantities,
                                ),
                              ),
                              const DelayedFadeIn(
                                delay: 1100,
                                child: SizedBox(height: 20),
                              ),
                              DelayedFadeIn(
                                delay: 1200,
                                child: RecipeWidgets.buildSectionTitle(''),
                              ),
                              const DelayedFadeIn(
                                delay: 1300,
                                child: SizedBox(height: 10),
                              ),
                              DelayedFadeIn(
                                delay: 1400,
                                child: RecipeWidgets.buildCardInstructions(
                                  viewModel.foodInfoById!.instructions,
                                ),
                              ),
                              const DelayedFadeIn(
                                delay: 1500,
                                child: SizedBox(height: 20),
                              ),
                              DelayedFadeIn(
                                delay: 1600,
                                child: RecipeWidgets.buildSectionTitle(''),
                              ),
                              const DelayedFadeIn(
                                delay: 1700,
                                child: SizedBox(height: 10),
                              ),
                              DelayedFadeIn(
                                delay: 1800,
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
              : const Center(
                  child: Text('No food information found'),
                ),
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

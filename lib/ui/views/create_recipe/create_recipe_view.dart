import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'create_recipe_viewmodel.dart';

class CreateRecipeView extends StackedView<CreateRecipeViewModel> {
  const CreateRecipeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CreateRecipeViewModel viewModel,
    Widget? child,
  ) {
    // Controllers for form fields
    final TextEditingController foodNameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController servingsController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController totalCookTimeController = TextEditingController();
    final TextEditingController difficultyController = TextEditingController();
    final TextEditingController preparationTipsController = TextEditingController();
    final TextEditingController nutritionalParagraphController = TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Create Recipe'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Name
            TextField(
              controller: foodNameController,
              decoration: const InputDecoration(labelText: 'Food Name'),
            ),
            const SizedBox(height: 10),

            // Description
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 10),

            // Servings
            TextField(
              controller: servingsController,
              decoration: const InputDecoration(labelText: 'Servings'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            // Category
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 10),

            // Total Cook Time
            TextField(
              controller: totalCookTimeController,
              decoration: const InputDecoration(labelText: 'Total Cook Time'),
            ),
            const SizedBox(height: 10),

            // Difficulty
            TextField(
              controller: difficultyController,
              decoration: const InputDecoration(labelText: 'Difficulty'),
            ),
            const SizedBox(height: 10),

            // Preparation Tips
            TextField(
              controller: preparationTipsController,
              decoration: const InputDecoration(labelText: 'Preparation Tips'),
              maxLines: 2,
            ),
            const SizedBox(height: 10),

            // Nutritional Paragraph
            TextField(
              controller: nutritionalParagraphController,
              decoration: const InputDecoration(labelText: 'Nutritional Paragraph'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            // Dynamic Ingredients Input
            const Text('Ingredients:'),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.ingredients.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(labelText: 'Ingredient'),
                        onChanged: (value) => viewModel.updateIngredient(index, value),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(labelText: 'Quantity'),
                        onChanged: (value) => viewModel.updateQuantity(index, value),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => viewModel.removeIngredient(index),
                    ),
                  ],
                );
              },
            ),
            ElevatedButton(
              onPressed: viewModel.addIngredient,
              child: const Text('Add Ingredient'),
            ),
            const SizedBox(height: 20),

            // Dynamic Instructions Input
            const Text('Instructions:'),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.instructions.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(labelText: 'Instruction'),
                        onChanged: (value) => viewModel.updateInstruction(index, value),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => viewModel.removeInstruction(index),
                    ),
                  ],
                );
              },
            ),
            ElevatedButton(
              onPressed: viewModel.addInstruction,
              child: const Text('Add Instruction'),
            ),
            const SizedBox(height: 20),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  viewModel.createRecipe(
                    foodName: foodNameController.text,
                    description: descriptionController.text,
                    servings: int.tryParse(servingsController.text) ?? 0,
                    category: categoryController.text,
                    ingredients: viewModel.ingredients,
                    quantities: viewModel.quantities,
                    instructions: viewModel.instructions,
                    nutritionalContent: [], // Replace with actual nutritional content inputs
                    totalCookTime: totalCookTimeController.text,
                    difficulty: difficultyController.text,
                    preparationTips: preparationTipsController.text,
                    nutritionalParagraph: nutritionalParagraphController.text,
                  );
                },
                child: const Text('Create Recipe'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  CreateRecipeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CreateRecipeViewModel();
}

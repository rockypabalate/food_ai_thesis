import 'package:flutter/material.dart';
import 'package:food_ai_thesis/utils/widgets_fade_effect.dart';

class RecipeDetailsSection extends StatelessWidget {
  final List<String> ingredients;
  final List<String> quantities;
  final String preparationTips;
  final List<String> instructions;
  final String nutritionalParagraph;

  const RecipeDetailsSection({
    Key? key,
    required this.ingredients,
    required this.quantities,
    required this.preparationTips,
    required this.instructions,
    required this.nutritionalParagraph,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Preparation Tips Section
        if (preparationTips.isNotEmpty)
          FadeEffectRecipe(
            delay: 700,
            child: _buildSectionContainer(
              'Preparation Tips',
              Text(preparationTips, style: const TextStyle(fontSize: 16)),
            ),
          ),
        const SizedBox(height: 16),

        // Ingredients Section
        FadeEffectRecipe(
          delay: 400,
          child: _buildSectionContainer(
            'Ingredients',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
              children: _buildIngredientsList(),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Instructions Section
        FadeEffectRecipe(
          delay: 800,
          child: _buildSectionContainer(
            'Instructions',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
              children: _buildInstructionsList(),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Nutritional Information Section
        if (nutritionalParagraph.isNotEmpty)
          FadeEffectRecipe(
            delay: 900,
            child: _buildSectionContainer(
              'Nutritional Information',
              Text(nutritionalParagraph, style: const TextStyle(fontSize: 16)),
            ),
          ),
      ],
    );
  }

  // Section container now takes full width
  Widget _buildSectionContainer(String title, Widget content) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: double.infinity, // Makes the container full width
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }

  List<Widget> _buildIngredientsList() {
    return List.generate(ingredients.length, (index) {
      String ingredient = ingredients[index];
      String quantity = (index < quantities.length) ? quantities[index] : 'N/A';

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          '- $ingredient: $quantity',
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.left, // Ensure left alignment for ingredients
        ),
      );
    });
  }

  List<Widget> _buildInstructionsList() {
    return instructions
        .map((instruction) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                instruction,
                style: const TextStyle(fontSize: 16),
                textAlign:
                    TextAlign.left, // Ensure left alignment for instructions
              ),
            ))
        .toList();
  }
}

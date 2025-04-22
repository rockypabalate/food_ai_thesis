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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ingredients Section with modern card design
            _buildModernSection(
              context: context,
              title: 'Ingredients',
              icon: Icons.shopping_basket_outlined,
              color: Colors.orange.shade100,
              iconColor: Colors.orange.shade800,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ingredients.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  String ingredient = ingredients[index];
                  String quantity =
                      (index < quantities.length) ? quantities[index] : 'N/A';

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade800,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            ingredient,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Text(
                          quantity,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade800,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Preparation Tips Section
            if (preparationTips.isNotEmpty)
              _buildModernSection(
                context: context,
                title: 'Preparation Tips',
                icon: Icons.lightbulb_outline,
                color: Colors.orange.shade100,
                iconColor: Colors.orange.shade800,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    preparationTips,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
              ),

            if (preparationTips.isNotEmpty) const SizedBox(height: 24),

            // Instructions Section with numbered steps
            _buildModernSection(
              context: context,
              title: 'Instructions',
              icon: Icons.format_list_numbered,
              color: Colors.orange.shade100,
              iconColor: Colors.orange.shade800,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: instructions.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final cleanText = instructions[index]
                      .replaceFirst(RegExp(r'^\d+\.\s*'), '');

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade800,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            cleanText,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Nutritional Information Section
            if (nutritionalParagraph.isNotEmpty)
              _buildModernSection(
                context: context,
                title: 'Nutritional Information',
                icon: Icons.monitor_heart_outlined,
                color: Colors.orange.shade100,
                iconColor: Colors.orange.shade800,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    nutritionalParagraph,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildModernSection({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required Color iconColor,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header with icon and colored background
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
              ],
            ),
          ),
          // Section content
          Padding(
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        ],
      ),
    );
  }
}

// Add this animation for a smooth appearance effect
class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final int delay;

  const FadeInAnimation({
    Key? key,
    required this.child,
    this.delay = 0,
  }) : super(key: key);

  @override
  _FadeInAnimationState createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(_animation),
        child: widget.child,
      ),
    );
  }
}

class RecipeDetailsPage extends StatelessWidget {
  final String recipeName;
  final String imageUrl;
  final int cookTime;
  final int servings;
  final List<String> ingredients;
  final List<String> quantities;
  final String preparationTips;
  final List<String> instructions;
  final String nutritionalParagraph;

  const RecipeDetailsPage({
    Key? key,
    required this.recipeName,
    required this.imageUrl,
    required this.cookTime,
    required this.servings,
    required this.ingredients,
    required this.quantities,
    required this.preparationTips,
    required this.instructions,
    required this.nutritionalParagraph,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero image with recipe name
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Recipe image
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                  // Gradient overlay for better text visibility
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.6, 1.0],
                      ),
                    ),
                  ),
                  // Recipe title at the bottom
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Text(
                      recipeName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Recipe quick info (time and servings)
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoChip(Icons.access_time, '$cookTime min'),
                  _buildInfoChip(Icons.people_outline, '$servings servings'),
                ],
              ),
            ),
          ),

          // Recipe details sections
          SliverToBoxAdapter(
            child: FadeEffectRecipe(
              delay: 300,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RecipeDetailsSection(
                  ingredients: ingredients,
                  quantities: quantities,
                  preparationTips: preparationTips,
                  instructions: instructions,
                  nutritionalParagraph: nutritionalParagraph,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.favorite_border),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey.shade700,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}

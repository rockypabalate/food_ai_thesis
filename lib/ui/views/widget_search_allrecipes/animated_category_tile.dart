import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_ai_thesis/models/list_recipes/list_recipes.dart';

class AnimatedCategoryTile extends StatefulWidget {
  final String category;
  final List<FoodInfo> recipes;
  final VoidCallback onTap;

  const AnimatedCategoryTile({
    required this.category,
    required this.recipes,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedCategoryTile> createState() => _AnimatedCategoryTileState();
}

class _AnimatedCategoryTileState extends State<AnimatedCategoryTile> {
  int _currentImageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.recipes.isNotEmpty) {
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        setState(() {
          _currentImageIndex =
              (_currentImageIndex + 1) % widget.recipes.length;
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.recipes.isNotEmpty &&
            widget.recipes[_currentImageIndex].imageUrls.isNotEmpty
        ? widget.recipes[_currentImageIndex].imageUrls.first
        : '';

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        key: ValueKey(imageUrl),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Container(
                        key: const ValueKey('empty'),
                        color: Colors.grey[300],
                      ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${widget.recipes.length} recipes',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
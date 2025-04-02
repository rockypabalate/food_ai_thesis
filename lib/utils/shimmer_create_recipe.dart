import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCreateRecipe extends StatelessWidget {
  const ShimmerCreateRecipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        shrinkWrap: true,
        physics:
            const NeverScrollableScrollPhysics(), // Prevents scrolling issues
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.82,
        ),
        itemCount: 6, // Simulating 6 loading items
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300, width: 0.8),
            ),
            child: Stack(
              children: [
                // Shimmer Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: _buildShimmerBlock(double.infinity, double.infinity),
                ),
                // Shimmer Details Overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildShimmerBlock(120, 14, radius: 4), // Food Name
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              _buildShimmerBlock(10, 10, radius: 4), // Icon
                              const SizedBox(width: 4),
                              _buildShimmerBlock(80, 10, radius: 4), // Text
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerBlock(double width, double height, {double radius = 8}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

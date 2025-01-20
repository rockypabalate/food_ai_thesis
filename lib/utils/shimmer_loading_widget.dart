import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({Key? key}) : super(key: key);

  Widget _buildShimmerBlock(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(10.0), // Add padding here
        child: SingleChildScrollView(
          // Make content scrollable
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // First Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShimmerBlock(150.0, 120.0), // Header shimmer
                      const SizedBox(height: 8.0),
                      _buildShimmerBlock(100.0, 14.0), // Subheader shimmer
                      const SizedBox(height: 8.0),
                      _buildShimmerBlock(
                          150.0, 14.0), // Paragraph shimmer line 1
                      const SizedBox(height: 4.0),
                      _buildShimmerBlock(
                          150.0, 10.0), // Paragraph shimmer line 2
                      // Paragraph shimmer line 3
                    ],
                  ),
                  // Second Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShimmerBlock(150.0, 120.0), // Header shimmer
                      const SizedBox(height: 8.0),
                      _buildShimmerBlock(100.0, 14.0), // Subheader shimmer
                      const SizedBox(height: 8.0),
                      _buildShimmerBlock(
                          150.0, 14.0), // Paragraph shimmer line 1
                      const SizedBox(height: 4.0),
                      _buildShimmerBlock(
                          150.0, 10.0), // Paragraph shimmer line 2
                      // Paragraph shimmer line 3
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              // Add more rows as needed
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShimmerBlock(150.0, 120.0), // Header shimmer
                      const SizedBox(height: 8.0),
                      _buildShimmerBlock(100.0, 14.0), // Subheader shimmer
                      const SizedBox(height: 8.0),
                      _buildShimmerBlock(
                          150.0, 14.0), // Paragraph shimmer line 1
                      const SizedBox(height: 4.0),
                      _buildShimmerBlock(
                          150.0, 10.0), // Paragraph shimmer line 2
                      // Paragraph shimmer line 3
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShimmerBlock(150.0, 120.0), // Header shimmer
                      const SizedBox(height: 8.0),
                      _buildShimmerBlock(100.0, 14.0), // Subheader shimmer
                      const SizedBox(height: 8.0),
                      _buildShimmerBlock(
                          150.0, 14.0), // Paragraph shimmer line 1
                      const SizedBox(height: 4.0),
                      _buildShimmerBlock(
                          150.0, 10.0), // Paragraph shimmer line 2
                      // Paragraph shimmer line 3
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              // Add more rows as needed
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShimmerBlock(150.0, 120.0), // Header shimmer
                      const SizedBox(height: 8.0),
                      _buildShimmerBlock(100.0, 14.0), // Subheader shimmer
                      const SizedBox(height: 8.0),
                      _buildShimmerBlock(
                          150.0, 14.0), // Paragraph shimmer line 1
                      const SizedBox(height: 4.0),
                      _buildShimmerBlock(
                          150.0, 10.0), // Paragraph shimmer line 2
                      // Paragraph shimmer line 3
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShimmerBlock(150.0, 120.0), // Header shimmer
                      const SizedBox(height: 8.0),
                      _buildShimmerBlock(100.0, 14.0), // Subheader shimmer
                      const SizedBox(height: 8.0),
                      _buildShimmerBlock(
                          150.0, 14.0), // Paragraph shimmer line 1
                      const SizedBox(height: 4.0),
                      _buildShimmerBlock(
                          150.0, 10.0), // Paragraph shimmer line 2
                      // Paragraph shimmer line 3
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

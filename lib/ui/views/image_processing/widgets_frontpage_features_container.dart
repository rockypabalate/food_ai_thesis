import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturesContainer extends StatelessWidget {
  final String title;
  final String description;
  final String assetPath; // This will be the path to your PNG image
  final double scale;
  final MainAxisAlignment alignment;

  const FeaturesContainer({
    Key? key,
    required this.title,
    required this.description,
    required this.assetPath,
    required this.scale,
    required this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 325,
        margin: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: alignment, // Adjust the vertical alignment of the Column
          crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally
          children: [
            // Display PNG image
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4 * scale,
              height: MediaQuery.of(context).size.width * 0.3 * scale,
              child: Image.asset(
                assetPath,
                fit: BoxFit.fitHeight, // Adjust the image to fit within the box
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.error,
                  size: 80,
                ), // Show an error icon if the image fails to load
              ),
            ),
            const SizedBox(height: 16),
            // Title and Description aligned to the left
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

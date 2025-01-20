import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class FeaturesContainer extends StatelessWidget {
  final String title;
  final String description;
  final String assetPath;
  final double scale;
  final MainAxisAlignment alignment;

  const FeaturesContainer({
    Key? key,
    required this.title,
    required this.description,
    required this.assetPath,
    required this.scale,
    required this.alignment, // Added constructor parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: alignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Lottie.asset(
              assetPath,
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width * 0.5 * scale,
              height: MediaQuery.of(context).size.width * 0.5 * scale,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, size: 100),
            ),
          ),
          const SizedBox(height: 20),
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
    );
  }
}

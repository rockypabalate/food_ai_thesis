import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/image_processing/image_processing_viewmodel.dart';
import 'package:food_ai_thesis/ui/views/image_processing/note_dialog.dart';
import 'package:food_ai_thesis/ui/views/image_processing/widgets_frontpage_features_container.dart';
import 'package:food_ai_thesis/ui/views/image_processing/widgets_settings_fade_effect.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FrontPage extends StatefulWidget {
  final ImageProcessingViewModel viewModel;

  const FrontPage({Key? key, required this.viewModel}) : super(key: key);

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Image Processing',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.orange,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              showImageProcessingNoteDialog(context);
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.06),
                  FadeEffectSettings(
                    delay: 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Here\'s the feature !',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  FadeEffectSettings(
                    delay: 200,
                    child: SizedBox(
                        height: 360,
                        child: PageView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: _pageController,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            switch (index) {
                              case 0:
                                return const FeaturesContainer(
                                  title: 'Food Identification using CNN',
                                  description:
                                      'Our app identifies food items using a Convolutional Neural Network (CNN). Capture or upload an image of food and let the AI analyze it.',
                                  assetPath: 'lib/assets/cnn.png',
                                  scale: 1.5,
                                  alignment: MainAxisAlignment.start,
                                );
                              case 1:
                                return const FeaturesContainer(
                                  title: '\nHow to Use the App',
                                  description:
                                      'Simply capture an image or upload one from your gallery. The app will process the image to identify the food item.',
                                  assetPath: 'lib/assets/captured.png',
                                  scale: 1.47,
                                  alignment: MainAxisAlignment.center,
                                );
                              case 2:
                              default:
                                return const FeaturesContainer(
                                  title: 'Food Information and Recipes',
                                  description:
                                      'After identification, the app provides detailed food recipes, instructions, and nutritional content for the identified food item.',
                                  assetPath: 'lib/assets/result.png',
                                  scale: 1.7,
                                  alignment: MainAxisAlignment.start,
                                );
                            }
                          },
                        )),
                  ),
                  const SizedBox(height: 5),
                  FadeEffectSettings(
                    delay: 300,
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: 3, // Number of pages
                      effect: const WormEffect(
                        dotHeight: 6,
                        dotWidth: 6,
                        activeDotColor: Colors.orangeAccent,
                        dotColor: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),

                  FadeEffectSettings(
                    delay: 400,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Choose Method',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  FadeEffectSettings(
                    delay: 500,
                    child: Center(
                      child: SizedBox(
                        width: 320,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await widget.viewModel.pickImageCamera();
                          },
                          icon:
                              const Icon(Icons.camera_alt, color: Colors.white),
                          label: Text(
                            'Capture Image',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  FadeEffectSettings(
                    delay: 600,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 25.4,
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'or',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 25.4, // About one inch
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  FadeEffectSettings(
                    delay: 700,
                    child: Center(
                      child: SizedBox(
                        width: 320,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await widget.viewModel.pickImageGallery();
                          },
                          icon: const Icon(Icons.photo_library,
                              color: Colors.white),
                          label: Text(
                            'Select from Gallery',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 50),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class _FrontPageState extends State<FrontPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    // Add this: Show the note dialog after the widget is fully built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showImageProcessingNoteDialog(context);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            fontWeight: FontWeight.w500,
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
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: FadeEffectSettings(
                  delay: 200,
                  child: Text(
                    'Here\'s the feature!',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: FadeEffectSettings(
                  delay: 300,
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
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: FadeEffectSettings(
                delay: 400,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Colors.orange,
                      dotColor: Colors.grey.shade300,
                      spacing: 12,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: FadeEffectSettings(
                  delay: 500,
                  child: Text(
                    'Choose Method',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: FadeEffectSettings(
                  delay: 600,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await widget.viewModel.pickImageCamera();
                      },
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      label: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'Capture Image',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: FadeEffectSettings(
                  delay: 700,
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          indent: 50,
                          endIndent: 10,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      Text(
                        'or',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          indent: 10,
                          endIndent: 50,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: FadeEffectSettings(
                  delay: 800,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await widget.viewModel.pickImageGallery();
                    },
                    icon:
                        const Icon(Icons.photo_library, color: Colors.black87),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Select from Gallery',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      foregroundColor: Colors.black87,
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

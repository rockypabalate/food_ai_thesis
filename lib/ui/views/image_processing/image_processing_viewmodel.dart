import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:food_ai_thesis/services/feedback_service.dart';
import 'package:image/image.dart' as img;
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/search_recipe_name/food_description.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ImageProcessingViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = locator<ApiServiceService>();
  final NavigationService _navigationService = locator<NavigationService>();

  final _feedbackService = locator<FeedbackService>();

  final Logger _logger = Logger();

  final GenerativeModel _generativeModel = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: 'AIzaSyAxbZ36P5_Q4liCHXZ_n2T9Ird77_mr1KI',
  );

  File? selectedImage;
  String? result;
  bool isFrontPageVisible = true;

  List<FoodInformation> _searchResults = [];
  List<FoodInformation> get searchResults => _searchResults;

  /// Updates the search text field manually (used for testing or typed search).
  void updateSearchQuery(String value) {
    result = value.trim();
    notifyListeners();
  }

  /// Fetch recipes using the result text.
  Future<void> fetchSearchResults() async {
    if (result == null || result!.isEmpty) return;

    setBusy(true);
    try {
      _searchResults = await _apiService.searchRecipesByName(result!);
    } catch (e) {
      _searchResults = [];
      print('Error fetching search results: $e');
    } finally {
      setBusy(false);
    }
    notifyListeners();
  }

  /// Select image from gallery and process.
  Future<void> pickImageGallery() async {
    await _pickImage(ImageSource.gallery);
  }

  /// Capture image from camera and process.
  Future<void> pickImageCamera() async {
    await _pickImage(ImageSource.camera);
  }

  /// Common image picker logic for gallery and camera.
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) return;

    selectedImage = File(pickedFile.path);
    isFrontPageVisible = false;
    notifyListeners();

    await processImageWithGenerativeAI(selectedImage!);
  }

  Future<void> processImageWithGenerativeAI(File image) async {
    setBusy(true);
    try {
      final Uint8List imageBytes = await image.readAsBytes();
      final img.Image? originalImage = img.decodeImage(imageBytes);

      if (originalImage == null) {
        result = "Error: Unable to decode image.";
        notifyListeners();
        return;
      }

      final resizedImage = img.copyResize(originalImage, width: 600);
      final Uint8List compressedBytes = Uint8List.fromList(
        img.encodeJpg(resizedImage, quality: 50),
      );

      final response = await _generativeModel.generateContent([
        Content.multi([
          TextPart(
            'Check if the image is food , if not then prompt error and if matches in any of the following Filipino dishes below like:\n'
            '• Adobong Manok\n'
            '• Ginataang Langka\n'
            '• Ginisang Munggo\n'
            '• Isdang Paksiw\n'
            '• Kaldereta\n'
            '• Lumpia\n'
            '• Menudo\n'
            '• Pancit\n'
            '• Sinigang Baboy\n'
            '• Tinolang Manok\n'
            '• Tortang Talong\n\n'
            'Please respond with only the **exact name** from the list above that matches the food item.\n'
            'The text images must not include the process it must be food images not a list of food.\n'
            'If the food is not one of the listed Filipino dishes, simply respond: "Not a listed Filipino food item."',
          ),
          DataPart('image/jpeg', compressedBytes),
        ]),
      ]);

      _logger.i('Gemini response: ${response.text}');

      result = response.text?.trim() ?? "No response from AI";
      notifyListeners();

      await fetchSearchResults();
    } catch (e) {
      result = 'Error processing image: $e';
      _logger.e('Error processing image with Generative AI: $e');
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  /// Reset everything and return to the main screen.
  void resetViewState() {
    selectedImage = null;
    _searchResults.clear();
    result = null;
    isFrontPageVisible = true;
    notifyListeners();
  }

  /// Navigate to the recipes page.
  void navigateToRecipes() {
    _navigationService.navigateTo(Routes.dashboardRecipesView);
  }

  void navigateBack() {
    _navigationService.navigateTo(Routes.imageProcessingView);
  }

  void markVisitedForFeedback() async {
    const pageKey = 'visited_ImageClassificationView';

    final alreadyVisited = await _feedbackService.isPageVisited(pageKey);

    if (!alreadyVisited) {
      await _feedbackService.markPageVisited(pageKey);
      debugPrint(
          '✅ visited_ImageClassificationView visited for the first time.');
    } else {
      debugPrint('ℹ️ visited_ImageClassificationView was already visited.');
    }
  }
}

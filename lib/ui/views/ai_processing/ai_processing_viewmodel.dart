import 'dart:io';
import 'dart:typed_data';

import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/search_recipe_name/food_description.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';


class AiProcessingViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = locator<ApiServiceService>();

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  List<FoodInformation> _searchResults = [];
  List<FoodInformation> get searchResults => _searchResults;

  String? result;
  File? selectedImage;

  final GenerativeModel _generativeModel;

  AiProcessingViewModel()
      : _generativeModel = GenerativeModel(
          model: 'gemini-1.5-flash-latest',
          apiKey: 'AIzaSyAxbZ36P5_Q4liCHXZ_n2T9Ird77_mr1KI',
        );

  void updateSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  Future<void> fetchSearchResults() async {
    if (result == null || result!.isEmpty) return;
    setBusy(true);
    try {
      _searchResults = await _apiService.searchRecipesByName(result!);
    } catch (e) {
      _searchResults = [];
      print('Error fetching search results: $e');
    }
    setBusy(false);
  }

  Future<void> pickImageGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      notifyListeners();
      await processImageWithGenerativeAI(selectedImage!);
    }
  }

  Future<void> pickImageCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      notifyListeners();
      await processImageWithGenerativeAI(selectedImage!);
    }
  }

Future<void> processImageWithGenerativeAI(File image) async {
  try {
    setBusy(true);
    final Uint8List imageBytes = await image.readAsBytes();

    // 🔥 Determine the correct MIME type based on the file extension
    String mimeType = image.path.toLowerCase().endsWith('.png') 
        ? 'image/png' 
        : 'image/jpeg'; // Default to JPEG if not PNG

    final response = await _generativeModel.generateContent([
      Content.multi([
        TextPart(
          'Identify this Filipino food item image. '
          'State only the full name of the identified food. '
          'If the identified food is not Filipino, please state that it is not a Filipino food item.',
        ),
        DataPart(mimeType, imageBytes), // ✅ Dynamically use the correct MIME type
      ]),
    ]);

    // ✅ Store AI's full response
    result = response.text ?? "No response from AI";
    notifyListeners();
  } catch (e) {
    result = 'Error processing image: $e';
    notifyListeners();
    print('Error processing image with Generative AI: $e');
  } finally {
    setBusy(false);
  }
}

}

import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/search_recipe_name/food_description.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class ImageProcessingViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = locator<ApiServiceService>();

  bool isFrontPageVisible = true;
  bool isBusy = false;
  File? selectedImage;
  String? result;

  List<FoodInformation> _searchResults = [];
  List<FoodInformation> get searchResults => _searchResults;

  final GenerativeModel _generativeModel;

  ImageProcessingViewModel()
      : _generativeModel = GenerativeModel(
          model: 'gemini-1.5-flash-latest',
          apiKey: 'AIzaSyAxbZ36P5_Q4liCHXZ_n2T9Ird77_mr1KI',
        );

  void updateSearchQuery(String value) {
    result = value;
    notifyListeners();
  }

  Future<void> fetchSearchResults() async {
    if (result == null || result!.isEmpty) return;
    setBusy(true);
    try {
      result = result!.trim();
      _searchResults = await _apiService.searchRecipesByName(result!);
      notifyListeners();
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
      isFrontPageVisible = false;
      notifyListeners();
      await processImageWithGenerativeAI(selectedImage!);
    }
  }

  Future<void> pickImageCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      isFrontPageVisible = false;
      notifyListeners();
      await processImageWithGenerativeAI(selectedImage!);
    }
  }

  Future<void> processImageWithGenerativeAI(File image) async {
    try {
      isBusy = true;
      notifyListeners(); // Ensure UI updates

      setBusy(true); // Call Stacked's setBusy

      // Read the image as bytes
      final Uint8List imageBytes = await image.readAsBytes();
      img.Image? originalImage = img.decodeImage(imageBytes);

      if (originalImage == null) {
        result = "Error: Unable to decode image.";
        notifyListeners();
        return;
      }

      // Resize the image to reduce dimensions (max width/height of 600px)
      final img.Image resizedImage = img.copyResize(originalImage, width: 600);

      // Compress the image to reduce file size (JPEG, quality 50%)
      final Uint8List compressedBytes =
          img.encodeJpg(resizedImage, quality: 50);

      // Determine MIME type
      String mimeType = 'image/jpeg';

      final response = await _generativeModel.generateContent([
        Content.multi([
          TextPart(
            'Identify this Filipino food item image. '
            'State only the full name of the identified food. '
            'If the identified food is not Filipino, please state that it is not a Filipino food item.',
          ),
          DataPart(mimeType, compressedBytes), // Use compressed image
        ]),
      ]);

      result = response.text?.trim() ?? "No response from AI";
      notifyListeners();

      await fetchSearchResults();
    } catch (e) {
      result = 'Error processing image: $e';
      notifyListeners();
      print('Error processing image with Generative AI: $e');
    } finally {
      isBusy = false;
      notifyListeners(); // Ensure UI updates when process is done
      setBusy(false);
    }
  }

  void resetViewState() {
    selectedImage = null;
    _searchResults.clear();
    result = null;
  }
}

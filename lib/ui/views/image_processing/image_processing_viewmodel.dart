import 'dart:io';
import 'dart:typed_data';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:image/image.dart' as img;
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/search_recipe_name/food_description.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked_services/stacked_services.dart';

class ImageProcessingViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = locator<ApiServiceService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool isFrontPageVisible = true;
  bool isBusy = false;
  File? selectedImage;
  String? result;

  List<FoodInformation> _searchResults = [];
  List<FoodInformation> get searchResults => _searchResults;

  void updateSearchQuery(String value) {
    result = value;
    notifyListeners();
  }

  Future<void> fetchSearchResults() async {
    if (result == null || result!.isEmpty) return;
    setBusy(true);
    try {
      result = result!.trim();
      print('Searching for recipes: $result');  // Log to check the search query

      _searchResults = await _apiService.searchRecipesByName(result!);
      print('Search results: $_searchResults');  // Log to check the fetched results

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
      await processImage(selectedImage!);
    }
  }

  Future<void> pickImageCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      isFrontPageVisible = false;
      notifyListeners();
      await processImage(selectedImage!);
    }
  }

  Future<void> processImage(File image) async {
    try {
      isBusy = true;
      notifyListeners();
      setBusy(true);

      // Read the image as bytes
      final Uint8List imageBytes = await image.readAsBytes();
      img.Image? originalImage = img.decodeImage(imageBytes);

      if (originalImage == null) {
        result = "Error: Unable to decode image.";
        notifyListeners();
        return;
      }

      // Resize the image (max width 600px)
      final img.Image resizedImage = img.copyResize(originalImage, width: 600);

      // Compress the image to reduce file size
      final Uint8List compressedBytes =
          img.encodeJpg(resizedImage, quality: 50);

      // Save the compressed image to a temporary file
      final tempFile = File('${image.path}_compressed.jpg');
      await tempFile.writeAsBytes(compressedBytes);

      // **🔍 Classify food using API**
      result = await _apiService.classifyFood(tempFile);

      // Debugging: Log the result to ensure it's the correct prediction
      print('Classification result: $result');  // Check here if 'TORTANG TALONG' is passed correctly

      if (result == null || result!.isEmpty) {
        result = "Food classification failed.";
        notifyListeners();
        return;
      }

      // **🍲 Fetch recipes based on classification result**
      await fetchSearchResults();  // This will now correctly use the result ("TORTANG TALONG")
    } catch (e) {
      result = 'Error processing image: $e';
      notifyListeners();
      print('Error processing image: $e');
    } finally {
      isBusy = false;
      notifyListeners();
      setBusy(false);
    }
  }

  void resetViewState() {
    selectedImage = null;
    _searchResults.clear();
    result = null;
  }

  void navigateToRecipes() {
    _navigationService.navigateTo(Routes.dashboardRecipesView);
  }
}

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/models/search_recipe_name/food_description.dart';
import 'package:image/image.dart' as img;
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class ImageProcessingViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = locator<ApiServiceService>();
  bool isFrontPageVisible = true;
  bool isBusy = false;
  File? filePath;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  List<FoodInformation> _searchResults = [];
  List<FoodInformation> get searchResults => _searchResults;

  File? selectedImage;
  String? result;

  late final Interpreter _interpreter;
  final List<String> _labels = [];

  ImageProcessingViewModel() {
    _initializeModel();
  }

  void updateSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  Future<void> fetchSearchResults() async {
    if (result == null || result!.isEmpty) return; // Ensure result is valid
    setBusy(true);
    try {
      _searchResults = await _apiService.searchRecipesByName(result!);
    } catch (e) {
      _searchResults = [];
      print('Error fetching search results: $e');
    }
    setBusy(false);
  }

  Future<void> _initializeModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(
          'lib/assets/food_classification_model_v3.tflite');
      await _loadLabels();
    } catch (e) {
      result = 'Error initializing model: $e';
      notifyListeners();
    }
  }

  Future<void> _loadLabels() async {
    try {
      final labelData = await rootBundle.loadString('lib/assets/labels.txt');
      _labels.addAll(labelData.split('\n'));
    } catch (e) {
      result = 'Error loading labels: $e';
      notifyListeners();
    }
  }

  Future<void> pickImageGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      isFrontPageVisible = false; // Switch to the result view
      notifyListeners(); // Notify UI of the change
      await _processImageAndSearch(selectedImage!);
    }
  }

  Future<void> pickImageCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      isFrontPageVisible = false; // Switch to the result view
      notifyListeners(); // Notify UI of the change
      await _processImageAndSearch(selectedImage!);
    }
  }

  Future<void> _processImageAndSearch(File image) async {
    try {
      await _classifyImage(image);
      await fetchSearchResults();
    } catch (e) {
      print('Error processing image and fetching search results: $e');
    }
  }

  Future<void> _classifyImage(File image) async {
    try {
      final input = await _preprocessImage(image);

      final outputShape = _interpreter.getOutputTensor(0).shape;
      final output = List.filled(outputShape.reduce((a, b) => a * b), 0.0)
          .reshape(outputShape);

      _interpreter.run(input, output);

      if (output.isNotEmpty && output[0] is List) {
        final List<double> outputList = (output[0] as List).cast<double>();
        final outputIndex = outputList.indexWhere(
            (value) => value == outputList.reduce((a, b) => a > b ? a : b));
        result = _labels[outputIndex].replaceAll(RegExp(r'^\d+\s*'), '');
      } else {
        throw Exception('Output tensor format is invalid or empty.');
      }

      notifyListeners();
    } catch (e) {
      result = 'Error during classification: $e';
      print('Error stack trace: $e');
      notifyListeners();
    }
  }

  Future<List<List<List<List<double>>>>> _preprocessImage(File image) async {
    final imageBytes = await image.readAsBytes();
    final decodedImage = img.decodeImage(imageBytes);

    if (decodedImage == null) {
      throw Exception('Failed to decode image.');
    }

    final resizedImage = img.copyResize(decodedImage, width: 224, height: 224);

    final input = List.generate(
      224,
      (y) => List.generate(
        224,
        (x) {
          final pixel = resizedImage.getPixel(x, y);
          final r = pixel.r / 255.0;
          final g = pixel.g / 255.0;
          final b = pixel.b / 255.0;
          return [r, g, b];
        },
      ),
    );

    return [input];
  }

  void resetViewState() {
    selectedImage = null;
    searchResults.clear();
    result = null;
  }

  @override
  void dispose() {
    _interpreter.close();
    resetViewState();
    super.dispose();
  }
}

import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class ImageClassificationViewModel extends BaseViewModel {
  File? selectedImage;
  String? result;

  late final Interpreter _interpreter;
  final List<String> _labels = [];

  ImageClassificationViewModel() {
    _initializeModel();
  }

  Future<void> _initializeModel() async {
    try {
      // Load the TensorFlow Lite model
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

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      notifyListeners();
      await _classifyImage(selectedImage!);
    }
  }

  Future<void> _classifyImage(File image) async {
    try {
      // Preprocess the image for the model
      final input = await _preprocessImage(image);

      // Prepare output buffer
      final outputShape = _interpreter.getOutputTensor(0).shape;
      final output = List.filled(outputShape.reduce((a, b) => a * b), 0.0)
          .reshape(outputShape);

      // Perform inference
      _interpreter.run(input, output);

      // Log the output for debugging
      print('Raw output: $output');

      // Safely handle the output tensor and find the max value index
      if (output.isNotEmpty && output[0] is List) {
        final List<double> outputList = (output[0] as List).cast<double>();
        print('Processed outputList: $outputList');

        // Get the index of the highest confidence score
        final outputIndex = outputList.indexWhere(
            (value) => value == outputList.reduce((a, b) => a > b ? a : b));

        // Remove numbers from the label using regex
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
    // Load the image bytes
    final imageBytes = await image.readAsBytes();
    final decodedImage = img.decodeImage(imageBytes);

    if (decodedImage == null) {
      throw Exception('Failed to decode image.');
    }

    // Resize the image to the required dimensions (e.g., 224x224)
    final resizedImage = img.copyResize(decodedImage, width: 224, height: 224);

    // Normalize pixel values to [0, 1] and create a 4D tensor input
    final input = List.generate(
      224,
      (y) => List.generate(
        224,
        (x) {
          final pixel = resizedImage.getPixel(x, y); // Get the Pixel object
          final r = pixel.r / 255.0; // Red channel (normalized)
          final g = pixel.g / 255.0; // Green channel (normalized)
          final b = pixel.b / 255.0; // Blue channel (normalized)
          return [r, g, b];
        },
      ),
    );
    print('Model input shape: ${_interpreter.getInputTensor(0).shape}');
    print(
        'Processed input shape: ${input.length}x${input[0].length}x${input[0][0].length}');

    // Add a batch dimension (for batch size = 1)
    return [input];
  }

  @override
  void dispose() {
    _interpreter.close();
    super.dispose();
  }
}

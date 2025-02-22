import 'package:flutter/material.dart';
import 'package:food_ai_thesis/app/app.locator.dart';
import 'package:food_ai_thesis/app/app.router.dart';
import 'package:food_ai_thesis/app/app_base_viewmodel.dart';
import 'package:food_ai_thesis/services/api/api_services/api_service_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked_services/stacked_services.dart';
import 'dart:io';

class UploadRecipeImageViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = locator<ApiServiceService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();

  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;

  int? recipeId; // Add recipeId property

  // Initialize the recipeId
  void init(int id) {
    recipeId = id;
  }

  // Show dialog for picking image source
  void showImagePickerDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Choose from Gallery'),
              onTap: () {
                pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // Pick an image from the selected source
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        selectedImage = image;
        notifyListeners();
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'Error selecting image: $e',
        duration: const Duration(seconds: 3),
      );
    }
  }

  // Upload the selected image
  Future<void> uploadImage() async {
    if (selectedImage == null) {
      _snackbarService.showSnackbar(
        message: 'No image selected. Please select an image first.',
        duration: const Duration(seconds: 3),
      );
      return;
    }

    if (recipeId == null) {
      _snackbarService.showSnackbar(
        message: 'Recipe ID is missing. Please try again.',
        duration: const Duration(seconds: 3),
      );
      return;
    }

    setBusy(true); // Show loading state

    try {
      final File imageFile = File(selectedImage!.path);

      // Upload the image using API service
      final response =
          await _apiService.uploadRecipeImage(recipeId!, imageFile);

      if (response != null) {
        // Success
        _snackbarService.showSnackbar(
          message: 'Image uploaded successfully!',
          duration: const Duration(seconds: 3),
        );

        // Navigate back or to the next screen
        _navigationService.replaceWith(Routes.userDashboardView);
      } else {
        _snackbarService.showSnackbar(
          message: 'Failed to upload image. Please try again.',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'An error occurred: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false); // Hide loading state
    }
  }

  // Handle the skip action
  void skip() {
    _navigationService.replaceWith(Routes.userDashboardView);
  }
}

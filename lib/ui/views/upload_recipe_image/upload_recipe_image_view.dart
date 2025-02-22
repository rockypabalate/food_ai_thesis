import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'upload_recipe_image_viewmodel.dart';

class UploadRecipeImageView extends StackedView<UploadRecipeImageViewModel> {
  final int recipeId; // Accept the recipeId directly

  const UploadRecipeImageView({
    Key? key,
    required this.recipeId,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UploadRecipeImageViewModel viewModel,
    Widget? child,
  ) {
    return WillPopScope(
      onWillPop: () async => false, // Prevent back navigation
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload Recipe Image'),
          centerTitle: true,
          backgroundColor: Colors.orange,
          automaticallyImplyLeading: false, // Remove back button
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => viewModel
                    .showImagePickerDialog(context), // Open image picker dialog
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  child: viewModel.selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(viewModel.selectedImage!.path),
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Center(
                          child: Text(
                            'Tap to select an image',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => viewModel.uploadImage(), // Upload the image
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Button color
                  foregroundColor: Colors.white, // Text color
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                ),
                child: const Text(
                  'Upload',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => viewModel.skip(), // Skip action
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  UploadRecipeImageViewModel viewModelBuilder(BuildContext context) =>
      UploadRecipeImageViewModel();

  @override
  void onViewModelReady(UploadRecipeImageViewModel viewModel) {
    // Pass the recipeId to the view model when the view is ready
    viewModel.init(recipeId);
    super.onViewModelReady(viewModel);
  }
}

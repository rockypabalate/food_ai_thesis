import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'ai_processing_viewmodel.dart';

class AiProcessingView extends StackedView<AiProcessingViewModel> {
  const AiProcessingView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AiProcessingViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Food Processing"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show selected image
            if (viewModel.selectedImage != null)
              Column(
                children: [
                  Image.file(
                    viewModel.selectedImage!,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                ],
              ),

            // Show AI response directly
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                viewModel.result ?? "Select an image to process",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            // Buttons for picking images
            ElevatedButton.icon(
              onPressed: viewModel.pickImageGallery,
              icon: const Icon(Icons.photo_library),
              label: const Text("Pick from Gallery"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: viewModel.pickImageCamera,
              icon: const Icon(Icons.camera_alt),
              label: const Text("Capture from Camera"),
            ),

            const SizedBox(height: 20),

            // Show loading indicator when busy
            if (viewModel.isBusy) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  @override
  AiProcessingViewModel viewModelBuilder(BuildContext context) =>
      AiProcessingViewModel();
}

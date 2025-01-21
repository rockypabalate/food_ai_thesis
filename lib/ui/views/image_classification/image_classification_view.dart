import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'image_classification_viewmodel.dart';

class ImageClassificationView
    extends StackedView<ImageClassificationViewModel> {
  const ImageClassificationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ImageClassificationViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (viewModel.selectedImage != null)
              Image.file(
                viewModel.selectedImage!,
                height: 250,
              )
            else
              const Icon(
                Icons.image,
                size: 250,
                color: Colors.grey,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: viewModel.pickImage,
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 20),
            if (viewModel.result != null)
              Text(
                'Result: ${viewModel.result!}',
              )
            else
              const Text('No classification result yet.'),
          ],
        ),
      ),
    );
  }

  @override
  ImageClassificationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ImageClassificationViewModel();
}

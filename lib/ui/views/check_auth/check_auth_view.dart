import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import 'check_auth_viewmodel.dart';

class CheckAuthView extends StackedView<CheckAuthViewModel> {
  const CheckAuthView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(CheckAuthViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.authenticate();
  }

  @override
  Widget builder(
    BuildContext context,
    CheckAuthViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 100),
        child: const AnimatedLoader(),
      ),
    );
  }

  @override
  CheckAuthViewModel viewModelBuilder(BuildContext context) =>
      CheckAuthViewModel();
}

class AnimatedLoader extends StatefulWidget {
  const AnimatedLoader({Key? key}) : super(key: key);

  @override
  _AnimatedLoaderState createState() => _AnimatedLoaderState();
}

class _AnimatedLoaderState extends State<AnimatedLoader>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  bool _showLogo = true;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController with a valid vsync
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Start the logo animation
    Future.delayed(const Duration(milliseconds: 500), () {
      _scaleController.forward().then((_) {
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _showLogo = false;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _showLogo
          ? AnimatedBuilder(
              animation: _scaleController,
              builder: (context, child) {
                return Opacity(
                  opacity: _scaleController.value,
                  child: Image.asset(
                    'lib/assets/foodlogo.png',
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width *
                        0.6 *
                        _scaleController.value,
                    height: MediaQuery.of(context).size.width *
                        0.6 *
                        _scaleController.value,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, size: 100),
                  ),
                );
              },
            )
          : Column(
              mainAxisSize: MainAxisSize.min, // Use min to reduce space
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height:
                      200, // Set your desired height for the Lottie animation
                  child: Lottie.asset(
                    'lib/assets/loads.json', // Update with your Lottie file path
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                    height: 8), // Reduce space between Lottie and text
                // const Text(
                //   'Loading...',
                //   style: TextStyle(
                //     fontSize: 30,
                //     fontWeight: FontWeight.w500,
                //     color: Colors.black54,
                //   ),
                // ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _scaleController
        .dispose(); // MyRecipesTab Dispose of the controller to free resources
    super.dispose();
  }
}

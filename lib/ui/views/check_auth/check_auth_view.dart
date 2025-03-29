import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

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
          : const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitChasingDots(
                  color: Colors.orange,
                  size: 80.0,
                ),
                SizedBox(height: 40),
                Text(
                  'Loading, please wait...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }
}

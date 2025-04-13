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
      body: const Center(
        child: Column(
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
      ),
    );
  }

  @override
  CheckAuthViewModel viewModelBuilder(BuildContext context) =>
      CheckAuthViewModel();
}

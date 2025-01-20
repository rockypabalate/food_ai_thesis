import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'seeall_filipino_recipes_viewmodel.dart';

class SeeallFilipinoRecipesView
    extends StackedView<SeeallFilipinoRecipesViewModel> {
  const SeeallFilipinoRecipesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SeeallFilipinoRecipesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  SeeallFilipinoRecipesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SeeallFilipinoRecipesViewModel();
}

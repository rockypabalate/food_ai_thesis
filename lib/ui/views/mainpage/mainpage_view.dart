import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/dashboard_recipes/dashboard_recipes_view.dart';
import 'package:food_ai_thesis/ui/views/image_processing/image_processing_view.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mainpage_viewmodel.dart';

class MainpageView extends StackedView<MainpageViewModel> {
  const MainpageView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MainpageViewModel viewModel,
    Widget? child,
  ) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: viewModel.currentIndex,
          children: const [
            DashboardRecipesView(),
            ImageProcessingView(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: .5,
                blurRadius: 1,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: viewModel.currentIndex,
            onTap: viewModel.onTabTapped,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color:
                      viewModel.currentIndex == 0 ? Colors.orange : Colors.grey,
                ),
                label: 'Recipes',
                tooltip: 'View Recipes',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.camera_alt,
                  color:
                      viewModel.currentIndex == 1 ? Colors.orange : Colors.grey,
                ),
                label: 'Camera',
                tooltip: 'Capture Photos',
              ),
            ],
            selectedLabelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
            ),
            unselectedLabelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  @override
  MainpageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MainpageViewModel();
}

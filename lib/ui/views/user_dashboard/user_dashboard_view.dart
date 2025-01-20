import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/widgets_bookmarked_recipes_tab.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/widgets_my_recipes_tab.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/widgets_profile_header.dart';
import 'package:stacked/stacked.dart';

import 'user_dashboard_viewmodel.dart';

class UserDashboardView extends StackedView<UserDashboardViewModel> {
  const UserDashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UserDashboardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: viewModel.isBusy
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : viewModel.user == null
              ? const Center(
                  child: Text('No user data available'),
                )
              : Column(
                  children: [
                    const ProfileHeader(),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => viewModel.setSelectedTab(0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: viewModel.selectedTab == 0
                                          ? Colors.orange
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'My Recipes',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: viewModel.selectedTab == 0
                                          ? Colors.orange
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => viewModel.setSelectedTab(1),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: viewModel.selectedTab == 1
                                          ? Colors.orange
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Bookmarked Recipes',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: viewModel.selectedTab == 1
                                          ? Colors.orange
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: viewModel.selectedTab == 0
                            ? const MyRecipesTab()
                            : const MyRecipesTab(),
                      ),
                    ),
                  ],
                ),
    );
  }

  @override
  UserDashboardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UserDashboardViewModel();

  @override
  void onViewModelReady(UserDashboardViewModel viewModel) {
    viewModel.getCurrentUser();
    //   viewModel.getSavedRecipesByUser();
  }
}

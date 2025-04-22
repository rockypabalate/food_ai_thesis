import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/widgets_my_recipes_tab.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/widgets_bookmark_tab.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/widgets_profile_header.dart';
import 'package:stacked/stacked.dart';

import 'user_dashboard_viewmodel.dart';

class UserDashboardView extends StatefulWidget {
  const UserDashboardView({Key? key}) : super(key: key);

  @override
  State<UserDashboardView> createState() => _UserDashboardViewState();
}

class _UserDashboardViewState extends State<UserDashboardView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Keeps tab state when switching

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return ViewModelBuilder<UserDashboardViewModel>.reactive(
      viewModelBuilder: () => UserDashboardViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.getCurrentUser(); // Get current user data
        viewModel
            .markVisitedForFeedback(); // Mark the page as visited for feedback
      },
      builder: (context, viewModel, child) {
        return WillPopScope(
          onWillPop: () async {
            viewModel.navigateBack();
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                const ProfileHeader(), // Should handle null data gracefully
                _buildTabBar(viewModel),
                Expanded(
                  child: IndexedStack(
                    index: viewModel.selectedTab,
                    children: const [
                      MyRecipesTab(),
                      BookmarkedRecipesTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Tab Bar with "My Recipes" and "Bookmarked Recipes"
  Widget _buildTabBar(UserDashboardViewModel viewModel) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: [
          _buildTab(viewModel, 0, 'My Recipes'),
          _buildTab(viewModel, 1, 'Bookmarked Recipes'),
        ],
      ),
    );
  }

  /// Tab Button
  Widget _buildTab(UserDashboardViewModel viewModel, int index, String title) {
    bool isSelected = viewModel.selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (viewModel.selectedTab != index) {
            viewModel.setSelectedTab(index);
            viewModel.notifyListeners();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.orange : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.orange : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

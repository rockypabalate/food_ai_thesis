import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/user_dashboard_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfileHeader extends StatelessWidget implements PreferredSizeWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserDashboardViewModel>.reactive(
      viewModelBuilder: () => UserDashboardViewModel(),
      onViewModelReady: (viewModel) => viewModel.getCurrentUser(),
      builder: (context, viewModel, child) {
        return AppBar(
          backgroundColor: Colors.orange,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 26),
            onPressed: () => viewModel.navigateBack(),
          ),
          title: const Text(
            'My Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white, size: 30),
              onPressed: () => viewModel.navigateToSettingsPage(),
              tooltip: 'Settings',
            ),
          ],
        );
      },
    );
  }

  // This is required when using AppBar as a custom widget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

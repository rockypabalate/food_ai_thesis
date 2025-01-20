import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/edit_profile/edit_profile_view.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/user_dashboard_view.dart';
import 'package:stacked/stacked.dart';
import 'my_profile_viewmodel.dart';

class MyProfileView extends StackedView<MyProfileViewModel> {
  const MyProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MyProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Top profile card
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      // Circular profile image with shadow and white border
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 5,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          backgroundImage: viewModel.profileImage.isNotEmpty
                              ? NetworkImage(viewModel.profileImage)
                              : null,
                          child: viewModel.profileImage.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.orange,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Username
                      Text(
                        viewModel.username,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Role
                      Text(
                        viewModel.role,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Buttons section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        // My Saved and Created Recipe Button
                        _buildProfileOption(
                          icon: Icons.book,
                          text: 'My Saved and Created Recipe',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserDashboardView(),
                              ),
                            );
                          },
                        ),

                        // Edit Profile Button
                        _buildProfileOption(
                          icon: Icons.edit,
                          text: 'Edit Profile',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfileView(),
                              ),
                            );
                          },
                        ),
                        // Settings Button
                        _buildProfileOption(
                          icon: Icons.settings,
                          text: 'Settings',
                          onTap: () {
                            // Handle Settings action
                          },
                        ),
                        // Logout Button
                        _buildProfileOption(
                          icon: Icons.logout,
                          text: 'Logout',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding:
                                      const EdgeInsets.all(1), // Adjust padding
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // Add rounded corners
                                  ),
                                  title: const Text(
                                    'Logout Account',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  content: Container(
                                    constraints: const BoxConstraints(
                                        maxWidth: 300), // Set max width
                                    child: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: 12),
                                        Text(
                                          'Are you sure you want to logout?',
                                          style: TextStyle(fontSize: 14),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 3),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel',
                                          style: TextStyle(color: Colors.grey)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        viewModel.logout();
                                      },
                                      child: const Text('Logout',
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // Helper method for profile options
  Widget _buildProfileOption({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.orange, size: 28),
              const SizedBox(width: 16),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  MyProfileViewModel viewModelBuilder(BuildContext context) =>
      MyProfileViewModel();
}

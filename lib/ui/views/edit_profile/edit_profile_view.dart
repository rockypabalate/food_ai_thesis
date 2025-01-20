import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import 'edit_profile_viewmodel.dart';

class EditProfileView extends StackedView<EditProfileViewModel> {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EditProfileViewModel viewModel,
    Widget? child,
  ) {
    if (viewModel.isBusy) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.user == null) {
      return const Center(child: Text('No user data available.'));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          TextButton(
            onPressed: () {
              viewModel.updateUserProfile(context);
            },
            child: Text(
              'Save',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.orange,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 90,
                          backgroundImage: viewModel.profileImage != null
                              ? FileImage(viewModel.profileImage!)
                                  as ImageProvider
                              : NetworkImage(
                                  viewModel.user!.profileImage ?? ''),
                          onBackgroundImageError: (_, __) =>
                              const Icon(Icons.person, size: 50),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 5,
                        child: GestureDetector(
                          onTap: () => viewModel
                              .selectImage(context), // Trigger image selection
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.orangeAccent,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    viewModel.user!.email,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  _buildTextFormField(
                    controller: viewModel.usernameController,
                    label: 'Username',
                    icon: Icons.person_outline,
                  ),
                  _buildTextFormField(
                    controller: viewModel.addressController,
                    label: 'Address',
                    icon: Icons.location_on_outlined,
                  ),
                  _buildTextFormField(
                    controller: viewModel.roleController,
                    label: 'Role',
                    icon: Icons.person_pin_circle_outlined,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.orange),
          labelText: label,
          labelStyle: GoogleFonts.poppins(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orangeAccent),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }

  @override
  EditProfileViewModel viewModelBuilder(BuildContext context) =>
      EditProfileViewModel();

  @override
  void onViewModelReady(EditProfileViewModel viewModel) {
    viewModel.getCurrentUser();
    super.onViewModelReady(viewModel);
  }
}

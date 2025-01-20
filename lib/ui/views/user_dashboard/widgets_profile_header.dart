// profile_header.dart
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/user_dashboard_viewmodel.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/widgets_fade_effect.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class ProfileHeader extends ViewModelWidget<UserDashboardViewModel> {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, UserDashboardViewModel viewModel) {
    return Container(
      width: double.infinity,
      height: 155.0,
      decoration: const BoxDecoration(
        color: Colors.orange,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.055,
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 15.0),
                const Text(
                  'My Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17.0),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FadeEffect(
                        delay: 300,
                        isHorizontalSlide: false,
                        child: viewModel.user?.profileImage != null
                            ? Container(
                                padding: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 23,
                                  backgroundImage: NetworkImage(
                                    viewModel.user!.profileImage!,
                                  ),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                                child: const CircleAvatar(
                                  radius: 23,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.red,
                                    size: 23,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(width: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeEffect(
                            delay: 400,
                            isHorizontalSlide: true,
                            child: Text(
                              viewModel.user?.username ?? 'N/A',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          FadeEffect(
                            delay: 500,
                            isHorizontalSlide: true,
                            child: Text(
                              viewModel.user?.email ?? 'No email',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32.0, // Adjusted size for better visibility
                    width: 32.0,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add notification action here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(), // Circular background
                        padding: EdgeInsets.zero, // Remove extra padding
                      ),
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.orange,
                        size: 20.0, // Adjusted icon size for circular button
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

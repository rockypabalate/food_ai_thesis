import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/user_dashboard_viewmodel.dart';
import 'package:food_ai_thesis/ui/views/user_dashboard/widgets_fade_effect.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserDashboardViewModel>.reactive(
      viewModelBuilder: () => UserDashboardViewModel(),
      onViewModelReady: (viewModel) => viewModel.getCurrentUser(),
      builder: (context, viewModel, child) {
        return Container(
          width: double.infinity,
          height: 170.0,
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
                      onTap: () => viewModel.navigateBack(),
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
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () => viewModel.navigateToEditProfile(),
                            child: FadeEffect(
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
                                        radius: 30,
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
                                        radius: 24,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          Positioned(
                            top: -1,
                            right: -1,
                            child: Container(
                              height: 17.0,
                              width: 17.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.green, width: 1.0),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.green,
                                size: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
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
                      ),
                      const SizedBox(width: 8.0),
                      SizedBox(
                        height: 35.0,
                        width: 35.0,
                        child: ElevatedButton(
                          onPressed: () => viewModel.logout(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const CircleBorder(),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Icon(
                            Icons.logout,
                            color: Colors.orange,
                            size: 19.0,
                          ),
                        ),
                      ),
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
}

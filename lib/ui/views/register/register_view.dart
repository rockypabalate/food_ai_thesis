import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/register/widgets_fade_effect_register.dart';
import 'package:food_ai_thesis/ui/views/register/widgets_loading_sign_up.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import 'register_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    // Calculate responsive sizes
    final double contentPadding = screenWidth * 0.05;
    final double buttonHeight = screenHeight * 0.06;
    final double verticalSpacing = screenHeight * 0.02;
    final double smallerSpacing = screenHeight * 0.015;

    // Text scaling
    final titleFontSize = 28 * (screenWidth / 375);
    final subtitleFontSize = 15 * (screenWidth / 375);
    final bodyTextFontSize = 14 * (screenWidth / 375);
    final smallTextFontSize = 12 * (screenWidth / 375);

    // Colors - matching the login page
    final primaryColor = const Color(0xFFFF6B00); // Vibrant orange
    final secondaryColor = const Color(0xFF2E3E5C); // Dark blue for text
    final backgroundColor = const Color(0xFFFAFAFA); // Light background
    final cardColor = Colors.white;
    final subtleGrey = const Color(0xFFF1F1F1); // For input fields

    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, color: secondaryColor),
              onPressed: () => viewModel.navigateToLogin(),
            ),
          ),
          body: Stack(
            children: [
              // Background with subtle pattern
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    image: const DecorationImage(
                      image: AssetImage(
                          'lib/assets/subtle_pattern.png'), // Add this asset or use a color
                      repeat: ImageRepeat.repeat,
                      opacity: 0.05,
                    ),
                  ),
                ),
              ),

              // Main content
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: contentPadding,
                      vertical: screenHeight * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and subtitle
                        FadeEffectRegister(
                          delay: 200,
                          child: Text(
                            'Create Account',
                            style: GoogleFonts.poppins(
                              fontSize: titleFontSize,
                              color: secondaryColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),

                        SizedBox(height: verticalSpacing * 0.5),

                        FadeEffectRegister(
                          delay: 300,
                          child: Text(
                            'Discover personalized recipes tailored just for you',
                            style: GoogleFonts.poppins(
                              fontSize: subtitleFontSize,
                              color: secondaryColor.withOpacity(0.7),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),

                        SizedBox(height: verticalSpacing * 2),

                        // Registration form
                        FadeEffectRegister(
                          delay: 400,
                          isHorizontalSlide: true,
                          child: Container(
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 15,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(screenWidth * 0.06),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Form title
                                FadeEffectRegister(
                                  delay: 500,
                                  child: Text(
                                    'Personal Information',
                                    style: GoogleFonts.poppins(
                                      fontSize: bodyTextFontSize * 1.1,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                                SizedBox(height: verticalSpacing * 1.2),

                                // Username field
                                FadeEffectRegister(
                                  delay: 600,
                                  child: _buildTextField(
                                    controller: usernameController,
                                    label: 'Username',
                                    hintText: 'Enter your username',
                                    icon: Icons.person_outline_rounded,
                                    screenWidth: screenWidth,
                                    screenHeight: screenHeight,
                                    bodyTextFontSize: bodyTextFontSize,
                                    smallTextFontSize: smallTextFontSize,
                                    primaryColor: primaryColor,
                                    secondaryColor: secondaryColor,
                                    subtleGrey: subtleGrey,
                                  ),
                                ),

                                SizedBox(height: verticalSpacing),

                                // Email field
                                FadeEffectRegister(
                                  delay: 700,
                                  child: _buildTextField(
                                    controller: emailController,
                                    label: 'Email',
                                    hintText: 'Enter your email address',
                                    icon: Icons.email_outlined,
                                    screenWidth: screenWidth,
                                    screenHeight: screenHeight,
                                    bodyTextFontSize: bodyTextFontSize,
                                    smallTextFontSize: smallTextFontSize,
                                    primaryColor: primaryColor,
                                    secondaryColor: secondaryColor,
                                    subtleGrey: subtleGrey,
                                  ),
                                ),

                                SizedBox(height: verticalSpacing),

                                // Password field
                                FadeEffectRegister(
                                  delay: 800,
                                  child: _buildPasswordField(
                                    controller: passwordController,
                                    label: 'Password',
                                    hintText: 'Create a secure password',
                                    isVisible: viewModel.isPasswordVisible,
                                    toggleVisibility:
                                        viewModel.togglePasswordVisibility,
                                    screenWidth: screenWidth,
                                    screenHeight: screenHeight,
                                    bodyTextFontSize: bodyTextFontSize,
                                    smallTextFontSize: smallTextFontSize,
                                    primaryColor: primaryColor,
                                    secondaryColor: secondaryColor,
                                    subtleGrey: subtleGrey,
                                  ),
                                ),

                                SizedBox(height: verticalSpacing),

                                // Confirm password field
                                FadeEffectRegister(
                                  delay: 900,
                                  child: _buildPasswordField(
                                    controller: confirmPasswordController,
                                    label: 'Confirm Password',
                                    hintText: 'Repeat your password',
                                    isVisible: viewModel.isPasswordVisible,
                                    toggleVisibility:
                                        viewModel.togglePasswordVisibility,
                                    screenWidth: screenWidth,
                                    screenHeight: screenHeight,
                                    bodyTextFontSize: bodyTextFontSize,
                                    smallTextFontSize: smallTextFontSize,
                                    primaryColor: primaryColor,
                                    secondaryColor: secondaryColor,
                                    subtleGrey: subtleGrey,
                                  ),
                                ),

                                // Password strength indicator could be added here

                                SizedBox(height: verticalSpacing * 1.5),

                                // Sign up button
                                FadeEffectRegister(
                                  delay: 1000,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: buttonHeight,
                                    child: ElevatedButton(
                                      onPressed: viewModel.isLoading
                                          ? null
                                          : () async {
                                              FocusScope.of(context).unfocus();
                                              await viewModel.register(
                                                usernameController.text,
                                                emailController.text,
                                                passwordController.text,
                                                confirmPasswordController.text,
                                              );
                                            },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: primaryColor,
                                        shadowColor:
                                            primaryColor.withOpacity(0.4),
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        disabledBackgroundColor:
                                            primaryColor.withOpacity(0.7),
                                        disabledForegroundColor: Colors.white,
                                      ),
                                      child: viewModel.isLoading
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: screenWidth * 0.05,
                                                  height: screenWidth * 0.05,
                                                  child:
                                                      const CircularProgressIndicator(
                                                    strokeWidth: 2.5,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.white),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: screenWidth * 0.03),
                                                Text(
                                                  'Creating...',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: bodyTextFontSize,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Text(
                                              'Create Account',
                                              style: GoogleFonts.poppins(
                                                fontSize:
                                                    bodyTextFontSize * 1.1,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),

                                // Error message
                                if (viewModel.errorMessage != null)
                                  FadeEffectRegister(
                                    delay: 1050,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: smallerSpacing),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.error_outline,
                                              color: Colors.red,
                                              size: bodyTextFontSize * 1.2,
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                viewModel.errorMessage!,
                                                style: GoogleFonts.poppins(
                                                  color: Colors.red,
                                                  fontSize: smallTextFontSize,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: verticalSpacing * 2),

                        // Already have an account text
                        FadeEffectRegister(
                          delay: 1100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: GoogleFonts.poppins(
                                  fontSize: bodyTextFontSize,
                                  color: secondaryColor.withOpacity(0.7),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => viewModel.navigateToLogin(),
                                child: Text(
                                  "Sign In",
                                  style: GoogleFonts.poppins(
                                    fontSize: bodyTextFontSize,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: verticalSpacing),

                        // Terms and Privacy Policy
                        FadeEffectRegister(
                          delay: 1200,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                  fontSize: smallTextFontSize,
                                  color: secondaryColor.withOpacity(0.6),
                                ),
                                children: [
                                  const TextSpan(
                                    text:
                                        'By creating an account, you agree to our ',
                                  ),
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: GoogleFonts.poppins(
                                      fontSize: smallTextFontSize,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Handle terms tap
                                      },
                                  ),
                                  const TextSpan(text: ' and acknowledge our '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: GoogleFonts.poppins(
                                      fontSize: smallTextFontSize,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Handle privacy policy tap
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    required double screenWidth,
    required double screenHeight,
    required double bodyTextFontSize,
    required double smallTextFontSize,
    required Color primaryColor,
    required Color secondaryColor,
    required Color subtleGrey,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: smallTextFontSize,
              fontWeight: FontWeight.w500,
              color: secondaryColor.withOpacity(0.8),
            ),
          ),
        ),
        TextField(
          controller: controller,
          style: GoogleFonts.poppins(
            fontSize: bodyTextFontSize,
            color: secondaryColor,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: subtleGrey,
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              fontSize: bodyTextFontSize,
              color: secondaryColor.withOpacity(0.4),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.018,
              horizontal: screenWidth * 0.05,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(
              icon,
              color: primaryColor,
              size: screenWidth * 0.055,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primaryColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required bool isVisible,
    required VoidCallback toggleVisibility,
    required double screenWidth,
    required double screenHeight,
    required double bodyTextFontSize,
    required double smallTextFontSize,
    required Color primaryColor,
    required Color secondaryColor,
    required Color subtleGrey,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: smallTextFontSize,
              fontWeight: FontWeight.w500,
              color: secondaryColor.withOpacity(0.8),
            ),
          ),
        ),
        TextField(
          controller: controller,
          obscureText: !isVisible,
          style: GoogleFonts.poppins(
            fontSize: bodyTextFontSize,
            color: secondaryColor,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: subtleGrey,
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              fontSize: bodyTextFontSize,
              color: secondaryColor.withOpacity(0.4),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.018,
              horizontal: screenWidth * 0.05,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(
              Icons.lock_outline_rounded,
              color: primaryColor,
              size: screenWidth * 0.055,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: secondaryColor.withOpacity(0.6),
                size: screenWidth * 0.055,
              ),
              onPressed: toggleVisibility,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primaryColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

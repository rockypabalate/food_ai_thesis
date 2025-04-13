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
    final double contentPadding = screenWidth * 0.05; // 5% of screen width
    final double buttonHeight = screenHeight * 0.06; // 6% of screen height
    final double verticalSpacing = screenHeight * 0.02; // 2% of screen height
    final double smallerSpacing = screenHeight * 0.015; // 1.5% of screen height
    final double cardWidth = screenWidth * 0.9; // 90% of screen width
    
    // Text scaling
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final titleFontSize = 27 * (screenWidth / 375); // Base size for iPhone X
    final bodyTextFontSize = 14 * (screenWidth / 375);
    final inputTextFontSize = 16 * (screenWidth / 375);
    final smallTextFontSize = 11 * (screenWidth / 375);
    
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                height: screenHeight,
                color: Colors.white,
              ),

              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.15, // 15% from top
                    left: contentPadding,
                    right: contentPadding,
                    bottom: screenHeight * 0.05, // 5% padding at bottom
                  ),
                  child: Column(
                    children: [
                      FadeEffectRegister(
                        delay: 100,
                        isHorizontalSlide: true,
                        child: Container(
                          width: cardWidth,
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.2),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Title
                              FadeEffectRegister(
                                delay: 200,
                                child: Text(
                                  'Register Account',
                                  style: GoogleFonts.poppins(
                                    fontSize: titleFontSize,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: verticalSpacing * 1.5),
                              
                              // Subtitle
                              FadeEffectRegister(
                                delay: 300,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Create an account to explore the all features of the app',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: bodyTextFontSize,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: verticalSpacing),
                              
                              // Username field
                              FadeEffectRegister(
                                delay: 400,
                                child: _buildTextField(
                                  controller: usernameController,
                                  hintText: 'Username',
                                  icon: Icons.person,
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  inputTextFontSize: inputTextFontSize,
                                  hintTextFontSize: bodyTextFontSize,
                                ),
                              ),
                              SizedBox(height: smallerSpacing),
                              
                              // Email field
                              FadeEffectRegister(
                                delay: 500,
                                child: _buildTextField(
                                  controller: emailController,
                                  hintText: 'Email',
                                  icon: Icons.email,
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  inputTextFontSize: inputTextFontSize,
                                  hintTextFontSize: bodyTextFontSize,
                                ),
                              ),
                              SizedBox(height: smallerSpacing),
                              
                              // Password field
                              FadeEffectRegister(
                                delay: 600,
                                child: _buildPasswordField(
                                  controller: passwordController,
                                  hintText: 'Password',
                                  isVisible: viewModel.isPasswordVisible,
                                  toggleVisibility: viewModel.togglePasswordVisibility,
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  inputTextFontSize: inputTextFontSize,
                                  hintTextFontSize: bodyTextFontSize,
                                ),
                              ),
                              SizedBox(height: smallerSpacing),
                              
                              // Confirm password field
                              FadeEffectRegister(
                                delay: 700,
                                child: _buildPasswordField(
                                  controller: confirmPasswordController,
                                  hintText: 'Confirm Password',
                                  isVisible: viewModel.isPasswordVisible,
                                  toggleVisibility: viewModel.togglePasswordVisibility,
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  inputTextFontSize: inputTextFontSize,
                                  hintTextFontSize: bodyTextFontSize,
                                ),
                              ),
                              SizedBox(height: verticalSpacing),
                              
                              // Sign up button
                              FadeEffectRegister(
                                delay: 800,
                                child: _buildSignUpButton(
                                  viewModel, 
                                  buttonHeight, 
                                  bodyTextFontSize
                                ),
                              ),
                              
                              // Error message
                              if (viewModel.errorMessage != null)
                                FadeEffectRegister(
                                  delay: 900,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: smallerSpacing),
                                    child: Text(
                                      viewModel.errorMessage!,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: bodyTextFontSize,
                                      ),
                                    ),
                                  ),
                                ),
                              SizedBox(height: verticalSpacing),
                              
                              // Sign in text
                              FadeEffectRegister(
                                delay: 1200,
                                child: _buildSignInText(viewModel, smallTextFontSize),
                              ),
                              SizedBox(height: verticalSpacing),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: verticalSpacing * 0.5),
                    ],
                  ),
                ),
              ),
              // Loading overlay
              LoadingIndicator(isLoading: viewModel.isLoading),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required double screenWidth,
    required double screenHeight,
    required double inputTextFontSize,
    required double hintTextFontSize,
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(fontSize: inputTextFontSize),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: hintTextFontSize,
          color: Colors.grey[600],
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.015,
          horizontal: screenWidth * 0.05,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(
          icon, 
          color: Colors.orange[600],
          size: screenWidth * 0.055,
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool isVisible,
    required VoidCallback toggleVisibility,
    required double screenWidth,
    required double screenHeight,
    required double inputTextFontSize,
    required double hintTextFontSize,
  }) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      style: GoogleFonts.poppins(fontSize: inputTextFontSize),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: hintTextFontSize,
          color: Colors.grey[600],
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.015,
          horizontal: screenWidth * 0.05,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(
          Icons.lock, 
          color: Colors.orange[600],
          size: screenWidth * 0.055,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey[600],
            size: screenWidth * 0.055,
          ),
          onPressed: toggleVisibility,
        ),
      ),
    );
  }

  Widget _buildSignUpButton(
    RegisterViewModel viewModel, 
    double buttonHeight,
    double textSize,
  ) {
    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          viewModel.setLoading(true);
          await viewModel.register(
            usernameController.text,
            emailController.text,
            passwordController.text,
            confirmPasswordController.text,
          );
          viewModel.setLoading(false);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange[600],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: viewModel.isBusy
            ? SizedBox(
                height: buttonHeight * 0.6,
                width: buttonHeight * 0.6,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3,
                ),
              )
            : Text(
                'Sign Up',
                style: GoogleFonts.poppins(
                  fontSize: textSize,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }

  Widget _buildSignInText(RegisterViewModel viewModel, double textSize) {
    return RichText(
      text: TextSpan(
        text: "Already have an account?  ",
        style: GoogleFonts.poppins(fontSize: textSize, color: Colors.black),
        children: [
          TextSpan(
            text: "Sign In here",
            style: GoogleFonts.poppins(
              fontSize: textSize,
              color: Colors.orange[900],
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                viewModel.navigateToLogin();
              },
          ),
        ],
      ),
    );
  }
}
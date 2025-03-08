import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import 'loginregister_viewmodel.dart';

class LoginregisterView extends StackedView<LoginregisterViewModel> {
  const LoginregisterView({Key? key}) : super(key: key);

 @override
  Widget builder(
    BuildContext context,
    LoginregisterViewModel viewModel,
    Widget? child,
  ) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Prevent going back to the last page
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/food_back.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Subtle gradient overlay without blur
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.white.withOpacity(0.3),
                    ],
                    stops: const [0.4, 1.0],
                  ),
                ),
              ),
            ),
            // "Welcome" text positioned at the top left
            const Positioned(
              top: 50,
              left: 25,
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // Centered content positioned at the bottom center
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 50.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Sign in or create an account to get started!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    _buildButton(
                      context,
                      label: 'Login',
                      onPressed: viewModel.navigateToLogin,
                      textColor: Colors.black, // Set text color to black
                    ),
                    const SizedBox(height: 15),
                    _buildButton(
                      context,
                      label: 'Register',
                      onPressed: viewModel.navigateToRegister,
                      isPrimary: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required String label,
      required VoidCallback onPressed,
      bool isPrimary = true,
      Color? textColor}) {
    // Added textColor parameter
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isPrimary ? Colors.white.withOpacity(0.8) : Colors.transparent,
          foregroundColor: textColor ?? // Use provided textColor or default
              (isPrimary
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: isPrimary
                ? BorderSide.none
                : BorderSide(color: Colors.white.withOpacity(0.7)),
          ),
          elevation: isPrimary ? 4 : 0,
          shadowColor: Colors.black26,
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            // Use Poppins font
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor, // Use the provided text color
          ),
        ),
      ),
    );
  }

  @override
  LoginregisterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginregisterViewModel();
}

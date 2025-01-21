import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/register/widgets_loading_sign_up.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import 'sign_in_viewmodel.dart';

class SignInView extends StackedView<SignInViewModel> {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignInViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          // Background container
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.orange, // Orange background color
            child: Center(
              child: Text(
                'Welcome Back!',
                style: GoogleFonts.poppins(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Bottom container with login fields
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Login header
                  Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Email field
                  TextFormField(
                    controller: viewModel.emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: GoogleFonts.poppins(
                        color: Colors.black, // Black label color when typing
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      prefixIcon: const Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Password field
                  TextFormField(
                    controller: viewModel.passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: GoogleFonts.poppins(
                        color: Colors.black, // Black label color when typing
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          viewModel.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: viewModel.togglePasswordVisibility,
                      ),
                    ),
                    obscureText: !viewModel.isPasswordVisible,
                  ),
                  const SizedBox(height: 20.0),
                  // Sign In button
                  ElevatedButton(
                    onPressed: () => viewModel.login(
                      viewModel.emailController.text,
                      viewModel.passwordController.text,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Button color orange
                      foregroundColor: Colors.white, // Text color white
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Sign up prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: GoogleFonts.poppins(),
                      ),
                      GestureDetector(
                        onTap: viewModel.navigateToSignUp,
                        child: Text(
                          'Sign up here',
                          style: GoogleFonts.poppins(
                            color: Colors.orange, // Sign up text color orange
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Loading indicator
          if (viewModel.isLoading)
            const LoadingIndicatorSignUp(isLoading: true),
        ],
      ),
    );
  }

  @override
  SignInViewModel viewModelBuilder(BuildContext context) => SignInViewModel();
}

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
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
              ),

              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: FadeEffectRegister(
                          delay: 100,
                          isHorizontalSlide: true,
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
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
                                FadeEffectRegister(
                                  delay: 200,
                                  child: Text(
                                    'Sign Up Account',
                                    style: GoogleFonts.poppins(
                                      fontSize: 27,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                FadeEffectRegister(
                                  delay: 300,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Create an account to explore the all features of the app',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                FadeEffectRegister(
                                  delay: 400,
                                  child: _buildTextField(
                                    controller: usernameController,
                                    hintText: 'Username',
                                    icon: Icons.person,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                FadeEffectRegister(
                                  delay: 500,
                                  child: _buildTextField(
                                    controller: emailController,
                                    hintText: 'Email',
                                    icon: Icons.email,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                FadeEffectRegister(
                                  delay: 600,
                                  child: _buildPasswordField(
                                    controller: passwordController,
                                    hintText: 'Password',
                                    isVisible: viewModel.isPasswordVisible,
                                    toggleVisibility:
                                        viewModel.togglePasswordVisibility,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                FadeEffectRegister(
                                  delay: 700,
                                  child: _buildPasswordField(
                                    controller: confirmPasswordController,
                                    hintText: 'Confirm Password',
                                    isVisible: viewModel.isPasswordVisible,
                                    toggleVisibility:
                                        viewModel.togglePasswordVisibility,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                FadeEffectRegister(
                                  delay: 800,
                                  child: _buildSignUpButton(viewModel),
                                ),
                                if (viewModel.errorMessage != null)
                                  FadeEffectRegister(
                                    delay: 900,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        viewModel.errorMessage!,
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 20),
                                FadeEffectRegister(
                                  delay: 1200,
                                  child: _buildSignInText(viewModel),
                                ),
                                const SizedBox(height: 20),
                                FadeEffectRegister(
                                  delay: 1300,
                                  child: _buildTermsAndConditions(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
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

  Widget _buildTextField(
      {required TextEditingController controller,
      required String hintText,
      required IconData icon}) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon, color: Colors.orange[600]),
      ),
    );
  }

  Widget _buildPasswordField(
      {required TextEditingController controller,
      required String hintText,
      required bool isVisible,
      required VoidCallback toggleVisibility}) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      style: GoogleFonts.poppins(fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.lock, color: Colors.orange[600]),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey[600],
          ),
          onPressed: toggleVisibility,
        ),
      ),
    );
  }

  Widget _buildSignUpButton(RegisterViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
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
        ),
        child: viewModel.isBusy
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                'Sign Up',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildSignInText(RegisterViewModel viewModel) {
    return RichText(
      text: TextSpan(
        text: "Already have an account?  ",
        style: GoogleFonts.poppins(fontSize: 11, color: Colors.black),
        children: [
          TextSpan(
            text: "Sign In here",
            style: GoogleFonts.poppins(
              fontSize: 11,
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

  Widget _buildTermsAndConditions() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: GoogleFonts.poppins(fontSize: 9, color: Colors.black),
        children: [
          const TextSpan(
              text:
                  'By creating or logging into an account you are agreeing with our '),
          TextSpan(
            text: 'Terms & Conditions',
            style: GoogleFonts.poppins(
              fontSize: 9,
              color: Colors.orange[900],
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: GoogleFonts.poppins(
              fontSize: 9,
              color: Colors.orange[900],
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }
}

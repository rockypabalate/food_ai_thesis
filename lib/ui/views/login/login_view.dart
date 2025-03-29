import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/login/login_viewmodel.dart';
import 'package:food_ai_thesis/ui/views/login/widgets_fade_effect_login.dart';
import 'package:food_ai_thesis/ui/views/login/widgets_loading_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, viewModel, child) {
        return WillPopScope(
          onWillPop: () async {
            // Prevent the user from going back
            return false;
          },
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 170),
                      child: Column(
                        children: [
                          FadeEffectLogin(
                            delay: 100,
                            isHorizontalSlide: true,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
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
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 0),
                                    FadeEffectLogin(
                                      delay: 200,
                                      child: Text(
                                        'Sign In Account',
                                        style: GoogleFonts.poppins(
                                          fontSize: 27,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    FadeEffectLogin(
                                      delay: 300,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Welcome to Food Ai app. Sign in to experience the best app recipe',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    FadeEffectLogin(
                                      delay: 400,
                                      child: TextField(
                                        controller: emailController,
                                        keyboardType: TextInputType
                                            .emailAddress, // Email keyboard
                                        autofillHints:
                                            null, // Disables email suggestions
                                        enableSuggestions:
                                            false, // Prevents predictions
                                        autocorrect:
                                            false, // No auto-correction
                                        style:
                                            GoogleFonts.poppins(fontSize: 16),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                          hintText: 'Email',
                                          hintStyle: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 15,
                                            horizontal: 20,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Colors.orange[600],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    FadeEffectLogin(
                                      delay: 500,
                                      child: TextField(
                                        controller: passwordController,
                                        obscureText:
                                            !viewModel.isPasswordVisible,
                                        keyboardType: TextInputType
                                            .visiblePassword, // Password input type
                                        autofillHints:
                                            null, // Disables password autofill
                                        enableSuggestions:
                                            false, // Disables predictive input
                                        autocorrect:
                                            false, // Prevents autocorrect
                                        style:
                                            GoogleFonts.poppins(fontSize: 16),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                          hintText: 'Password',
                                          hintStyle: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 15,
                                            horizontal: 20,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Colors.orange[600],
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              viewModel.isPasswordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.grey[600],
                                            ),
                                            onPressed: () {
                                              viewModel
                                                  .togglePasswordVisibility();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    FadeEffectLogin(
                                      delay: 600,
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            viewModel.login(
                                              emailController.text,
                                              passwordController.text,
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors.orange[600],
                                          ),
                                          child: Text(
                                            'Sign In',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    FadeEffectLogin(
                                      delay: 800,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Center horizontally
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                'other way to sign up',
                                                textAlign: TextAlign
                                                    .center, // Center text inside the widget
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    FadeEffectLogin(
                                      delay: 900,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    spreadRadius: 1,
                                                    blurRadius: 2,
                                                    offset: const Offset(0, 1),
                                                  ),
                                                ],
                                              ),
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white,
                                                child: Image.asset(
                                                  'lib/assets/search.png',
                                                  height: 23,
                                                  width: 23,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    spreadRadius: 1,
                                                    blurRadius: 2,
                                                    offset: const Offset(0, 1),
                                                  ),
                                                ],
                                              ),
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white,
                                                child: Image.asset(
                                                  'lib/assets/facebook.png',
                                                  height: 23,
                                                  width: 23,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    FadeEffectLogin(
                                      delay: 1000,
                                      child: RichText(
                                        text: TextSpan(
                                          text: "Don't have an account?  ",
                                          style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              color: Colors
                                                  .black), // Font size for text
                                          children: [
                                            TextSpan(
                                              text: "Sign Up here",
                                              style: GoogleFonts.poppins(
                                                fontSize:
                                                    11, // Font size for register link
                                                color: Colors.orange[900],
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  viewModel
                                                      .navigateToregister();
                                                },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    FadeEffectLogin(
                                      delay: 1100,
                                      child: RichText(
                                        textAlign: TextAlign
                                            .center, // Center align the text
                                        text: TextSpan(
                                          style: GoogleFonts.poppins(
                                            fontSize: 9,
                                            color: Colors
                                                .black, // Default text color
                                          ),
                                          children: [
                                            const TextSpan(
                                                text:
                                                    'By creating or logging into an account you are agreeing with our '),
                                            TextSpan(
                                              text: 'Terms and Conditions',
                                              style: GoogleFonts.poppins(
                                                fontSize: 9,
                                                color: Colors.orange[
                                                    900], // Color for Terms and Conditions
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  // Handle tap for Terms and Conditions
                                                },
                                            ),
                                            const TextSpan(text: ' and '),
                                            TextSpan(
                                              text: 'Privacy Statement.',
                                              style: GoogleFonts.poppins(
                                                fontSize: 9,
                                                color: Colors.orange[
                                                    900], // Color for Privacy Statement
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  // Handle tap for Privacy Statement
                                                },
                                            ),
                                          ],
                                        ),
                                      ),
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
                ),
                if (viewModel.isLoading)
                  Positioned.fill(
                    child: Center(
                      child: LoadingIndicator(isLoading: viewModel.isLoading),
                    ),
                  ),
              ],
            ),
          ),
        );
        //
      },
    );
  }
}

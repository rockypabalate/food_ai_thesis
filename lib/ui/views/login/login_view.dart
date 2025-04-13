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
    // Get screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    
    // Calculate responsive sizes based on screen dimensions
    final double logoSize = screenWidth * 0.3; // 30% of screen width
    final double contentPadding = screenWidth * 0.05; // 5% of screen width
    final double buttonHeight = screenHeight * 0.06; // 6% of screen height
    final double verticalSpacing = screenHeight * 0.02; // 2% of screen height
    final double cardWidth = screenWidth * 0.9; // 90% of screen width
    
    // Text scaling
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final titleFontSize = 27 * (screenWidth / 375); // Base size for iPhone X
    final bodyTextFontSize = 14 * (screenWidth / 375);
    final smallTextFontSize = 11 * (screenWidth / 375);
    final tinyTextFontSize = 9 * (screenWidth / 375);
    
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
                  height: screenHeight,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.07, // 7% from top
                        left: contentPadding,
                        right: contentPadding,
                      ),
                      child: Column(
                        children: [
                          FadeEffectLogin(
                            delay: 100,
                            child: Image.asset(
                              'lib/assets/logologo.png',
                              width: logoSize,
                              height: logoSize,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: verticalSpacing),
                          FadeEffectLogin(
                            delay: 200,
                            child: Text(
                              'Food AI',
                              style: GoogleFonts.poppins(
                                fontSize: titleFontSize,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: verticalSpacing),
                          FadeEffectLogin(
                            delay: 300,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Welcome to Food Ai app. Sign in to experience the best app recipe',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: bodyTextFontSize,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: verticalSpacing * 1.5),
                          FadeEffectLogin(
                            delay: 400,
                            isHorizontalSlide: true,
                            child: Container(
                              width: cardWidth,
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
                              padding: EdgeInsets.all(screenWidth * 0.04),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Login Text
                                  FadeEffectLogin(
                                    delay: 500,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Login',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize: titleFontSize * 0.8,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: verticalSpacing),
                                  
                                  // Email TextField
                                  FadeEffectLogin(
                                    delay: 600,
                                    child: TextField(
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      autofillHints: null,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      style: GoogleFonts.poppins(
                                        fontSize: bodyTextFontSize,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                        hintText: 'Email',
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: bodyTextFontSize,
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
                                          Icons.email,
                                          color: Colors.orange[600],
                                          size: screenWidth * 0.055,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: verticalSpacing),
                                  
                                  // Password TextField
                                  FadeEffectLogin(
                                    delay: 700,
                                    child: TextField(
                                      controller: passwordController,
                                      obscureText: !viewModel.isPasswordVisible,
                                      keyboardType: TextInputType.visiblePassword,
                                      autofillHints: null,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      style: GoogleFonts.poppins(
                                        fontSize: bodyTextFontSize,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                        hintText: 'Password',
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: bodyTextFontSize,
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
                                            viewModel.isPasswordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.grey[600],
                                            size: screenWidth * 0.055,
                                          ),
                                          onPressed: () {
                                            viewModel.togglePasswordVisibility();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: verticalSpacing),
                                  
                                  // Sign In Button
                                  FadeEffectLogin(
                                    delay: 800,
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: buttonHeight,
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
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          'Sign In',
                                          style: GoogleFonts.poppins(
                                            fontSize: bodyTextFontSize,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: verticalSpacing),
                                  
                                  // Other way to sign up text
                                  FadeEffectLogin(
                                    delay: 900,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'other way to sign up',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                              fontSize: bodyTextFontSize,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: verticalSpacing),
                                  
                                  // Social login buttons
                                  FadeEffectLogin(
                                    delay: 1000,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        // Google button
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: const Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: CircleAvatar(
                                              radius: screenWidth * 0.05,
                                              backgroundColor: Colors.white,
                                              child: Image.asset(
                                                'lib/assets/search.png',
                                                height: screenWidth * 0.05,
                                                width: screenWidth * 0.05,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.05),
                                        
                                        // Facebook button
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: const Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: CircleAvatar(
                                              radius: screenWidth * 0.05,
                                              backgroundColor: Colors.white,
                                              child: Image.asset(
                                                'lib/assets/facebook.png',
                                                height: screenWidth * 0.05,
                                                width: screenWidth * 0.05,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: verticalSpacing * 1.5),
                                  
                                  // Sign up link
                                  FadeEffectLogin(
                                    delay: 1100,
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Don't have an account?  ",
                                        style: GoogleFonts.poppins(
                                          fontSize: smallTextFontSize,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "Sign Up here",
                                            style: GoogleFonts.poppins(
                                              fontSize: smallTextFontSize,
                                              color: Colors.orange[900],
                                              decoration: TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                viewModel.navigateToregister();
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: verticalSpacing),
                                  
                                  // Terms and conditions
                                  FadeEffectLogin(
                                    delay: 1200,
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: GoogleFonts.poppins(
                                          fontSize: tinyTextFontSize,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          const TextSpan(
                                            text: 'By creating or logging into an account you are agreeing with our ',
                                          ),
                                          TextSpan(
                                            text: 'Terms and Conditions',
                                            style: GoogleFonts.poppins(
                                              fontSize: tinyTextFontSize,
                                              color: Colors.orange[900],
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
                                              fontSize: tinyTextFontSize,
                                              color: Colors.orange[900],
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
                          SizedBox(height: verticalSpacing),
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
      },
    );
  }
}
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_ai_thesis/ui/views/login/login_viewmodel.dart';
import 'package:food_ai_thesis/ui/views/login/widgets_fade_effect_login.dart';
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

    // Calculate responsive sizes
    final double logoSize = screenWidth * 0.33;
    final double contentPadding = screenWidth * 0.05;
    final double buttonHeight = screenHeight * 0.06;
    final double verticalSpacing = screenHeight * 0.02;

    // Text scaling
    final titleFontSize = 28 * (screenWidth / 375);
    final bodyTextFontSize = 14 * (screenWidth / 375);
    final smallTextFontSize = 12 * (screenWidth / 375);
    final tinyTextFontSize = 10 * (screenWidth / 375);

    // Colors
    const primaryColor = Color(0xFFFF6B00); // Vibrant orange
    const secondaryColor = Color(0xFF2E3E5C); // Dark blue for text
    const backgroundColor = Color(0xFFFAFAFA); // Light background
    const cardColor = Colors.white;
    const subtleGrey = Color(0xFFF1F1F1); // For input fields

    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, viewModel, child) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: backgroundColor,
            body: Stack(
              children: [
                // Background with subtle pattern
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: backgroundColor,
                      image: DecorationImage(
                        image: AssetImage(
                            'lib/assets/bg_food.jpg'), // Add a subtle pattern background
                        repeat: ImageRepeat.repeat,
                        opacity: 0.07,
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
                        vertical: screenHeight * 0.04,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Logo with subtle animation
                          FadeEffectLogin(
                            delay: 100,
                            child: Center(
                              child: Hero(
                                tag: 'app_logo',
                                child: Container(
                                  height: logoSize,
                                  width: logoSize,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryColor.withOpacity(0.2),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    'lib/assets/logologo.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: verticalSpacing),

                          // App name
                          FadeEffectLogin(
                            delay: 200,
                            child: Text(
                              'Food AI',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: titleFontSize,
                                color: secondaryColor,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),

                          SizedBox(height: verticalSpacing * 0.5),

                          // Welcome text
                          FadeEffectLogin(
                            delay: 300,
                            child: Text(
                              'Discover recipes tailored just for you',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: bodyTextFontSize,
                                color: secondaryColor.withOpacity(0.7),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),

                          SizedBox(height: verticalSpacing * 2),

                          // Login card
                          FadeEffectLogin(
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
                                  // Welcome back text
                                  FadeEffectLogin(
                                    delay: 500,
                                    child: Text(
                                      'Welcome back',
                                      style: GoogleFonts.poppins(
                                        fontSize: titleFontSize * 0.8,
                                        color: secondaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: verticalSpacing * 0.5),

                                  // Subtitle
                                  FadeEffectLogin(
                                    delay: 550,
                                    child: Text(
                                      'Sign in to continue',
                                      style: GoogleFonts.poppins(
                                        fontSize: bodyTextFontSize,
                                        color: secondaryColor.withOpacity(0.6),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: verticalSpacing * 1.5),

                                  // Email field
                                  FadeEffectLogin(
                                    delay: 600,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, bottom: 8),
                                          child: Text(
                                            'Email',
                                            style: GoogleFonts.poppins(
                                              fontSize: smallTextFontSize,
                                              fontWeight: FontWeight.w500,
                                              color: secondaryColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                        ),
                                        TextField(
                                          controller: emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: GoogleFonts.poppins(
                                            fontSize: bodyTextFontSize,
                                            color: secondaryColor,
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: subtleGrey,
                                            hintText: 'Enter your email',
                                            hintStyle: GoogleFonts.poppins(
                                              fontSize: bodyTextFontSize,
                                              color: secondaryColor
                                                  .withOpacity(0.4),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: screenHeight * 0.018,
                                              horizontal: screenWidth * 0.05,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                            prefixIcon: Icon(
                                              Icons.email_outlined,
                                              color: primaryColor,
                                              size: screenWidth * 0.055,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                  color: primaryColor,
                                                  width: 1.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: verticalSpacing),

                                  // Password field
                                  FadeEffectLogin(
                                    delay: 700,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, bottom: 8),
                                          child: Text(
                                            'Password',
                                            style: GoogleFonts.poppins(
                                              fontSize: smallTextFontSize,
                                              fontWeight: FontWeight.w500,
                                              color: secondaryColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                        ),
                                        TextField(
                                          controller: passwordController,
                                          obscureText:
                                              !viewModel.isPasswordVisible,
                                          style: GoogleFonts.poppins(
                                            fontSize: bodyTextFontSize,
                                            color: secondaryColor,
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: subtleGrey,
                                            hintText: 'Enter your password',
                                            hintStyle: GoogleFonts.poppins(
                                              fontSize: bodyTextFontSize,
                                              color: secondaryColor
                                                  .withOpacity(0.4),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: screenHeight * 0.018,
                                              horizontal: screenWidth * 0.05,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                            prefixIcon: Icon(
                                              Icons.lock_outline_rounded,
                                              color: primaryColor,
                                              size: screenWidth * 0.055,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                viewModel.isPasswordVisible
                                                    ? Icons.visibility_rounded
                                                    : Icons
                                                        .visibility_off_rounded,
                                                color: secondaryColor
                                                    .withOpacity(0.6),
                                                size: screenWidth * 0.055,
                                              ),
                                              onPressed: viewModel
                                                  .togglePasswordVisibility,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                  color: primaryColor,
                                                  width: 1.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: verticalSpacing * 0.5),

                                  // Forgot password link
                                  FadeEffectLogin(
                                    delay: 750,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {
                                          // Handle forgot password
                                        },
                                        style: TextButton.styleFrom(
                                          minimumSize: Size.zero,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                            horizontal: 8,
                                          ),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: Text(
                                          'Forgot Password?',
                                          style: GoogleFonts.poppins(
                                            fontSize: smallTextFontSize,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: verticalSpacing),

                                  // Sign In Button with circular loading
                                  FadeEffectLogin(
                                    delay: 800,
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: buttonHeight,
                                      child: ElevatedButton(
                                        onPressed: viewModel.isLoading
                                            ? null
                                            : () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                viewModel.login(
                                                  emailController.text,
                                                  passwordController.text,
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
                                                      width:
                                                          screenWidth * 0.03),
                                                  Text(
                                                    'Signing In...',
                                                    style: GoogleFonts.poppins(
                                                      fontSize:
                                                          bodyTextFontSize,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: 0.5,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                'Sign In',
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
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: verticalSpacing * 1.5),

                          // // Divider with text
                          // FadeEffectLogin(
                          //   delay: 900,
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //         child: Divider(
                          //           color: secondaryColor.withOpacity(0.2),
                          //           thickness: 1,
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 16),
                          //         child: Text(
                          //           'Or continue with',
                          //           style: GoogleFonts.poppins(
                          //             fontSize: smallTextFontSize,
                          //             color: secondaryColor.withOpacity(0.6),
                          //           ),
                          //         ),
                          //       ),
                          //       Expanded(
                          //         child: Divider(
                          //           color: secondaryColor.withOpacity(0.2),
                          //           thickness: 1,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          // SizedBox(height: verticalSpacing),

                          // // Social login buttons
                          // FadeEffectLogin(
                          //   delay: 1000,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       // Google button
                          //       _socialButton(
                          //         image: 'lib/assets/search.png',
                          //         onTap: () {},
                          //         screenWidth: screenWidth,
                          //         label: 'Google',
                          //         color: Colors.white,
                          //         textColor: secondaryColor,
                          //       ),

                          //       SizedBox(width: screenWidth * 0.04),

                          //       // Facebook button
                          //       _socialButton(
                          //         image: 'lib/assets/facebook.png',
                          //         onTap: () {},
                          //         screenWidth: screenWidth,
                          //         label: 'Facebook',
                          //         color: Colors.white,
                          //         textColor: secondaryColor,
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          // SizedBox(height: verticalSpacing * 2),

                          // Sign up text
                          FadeEffectLogin(
                            delay: 1100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: GoogleFonts.poppins(
                                    fontSize: bodyTextFontSize,
                                    color: secondaryColor.withOpacity(0.7),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => viewModel.navigateToregister(),
                                  child: Text(
                                    "Sign Up",
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

                          // Terms and conditions
                          FadeEffectLogin(
                            delay: 1200,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                  fontSize: tinyTextFontSize,
                                  color: secondaryColor.withOpacity(0.6),
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'By signing in, you agree to our ',
                                  ),
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: GoogleFonts.poppins(
                                      fontSize: tinyTextFontSize,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Handle terms of service
                                      },
                                  ),
                                  const TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: GoogleFonts.poppins(
                                      fontSize: tinyTextFontSize,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Handle privacy policy
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper method to create social login buttons
  Widget _socialButton({
    required String image,
    required Function() onTap,
    required double screenWidth,
    required String label,
    required Color color,
    required Color textColor,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: screenWidth * 0.12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: screenWidth * 0.05,
                width: screenWidth * 0.05,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13 * (screenWidth / 375),
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            // Background image with modern handling
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/food_back.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Improved overlay gradient with modern colors
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),
            ),
            // Content layout with SafeArea
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    // Modern welcome text with more interesting typography
                    Text(
                      'Welcome',
                      style: GoogleFonts.montserrat(
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'to FOOD AI',
                      style: GoogleFonts.montserrat(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.9),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Spacer(),
                    // Bottom section with card for better visual hierarchy
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Sign in or create an account to get started!',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          _buildButton(
                            context,
                            label: 'Login',
                            onPressed: viewModel.navigateToLogin,
                            icon: Icons.login_rounded,
                            buttonColor: const Color(0xFFFF6B00),
                            textColor: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          _buildButton(
                            context,
                            label: 'Create Account',
                            onPressed: viewModel.navigateToRegister,
                            isPrimary: false,
                            icon: Icons.person_add_rounded,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required VoidCallback onPressed,
    bool isPrimary = true,
    IconData? icon,
    Color? buttonColor,
    Color? textColor,
  }) {
    final Color finalButtonColor = buttonColor ??
        (isPrimary
            ? Theme.of(context).colorScheme.primaryContainer
            : Colors.transparent);

    final Color finalTextColor = textColor ??
        (isPrimary
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Colors.white);

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: finalButtonColor,
          foregroundColor: finalTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isPrimary
                ? BorderSide.none
                : BorderSide(color: Colors.white.withOpacity(0.5), width: 1.5),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, size: 20, color: finalTextColor),
            if (icon != null) const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                color: finalTextColor,
              ),
            ),
          ],
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

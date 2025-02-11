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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 50.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10.0),
                          Text(
                            'Welcome Back!',
                            style: GoogleFonts.poppins(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            'Log in to explore your favorite pastries and exclusive deals.',
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 160.0),
                          TextFormField(
                            controller: viewModel.emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter your email address',
                              hintStyle:
                                  GoogleFonts.poppins(color: Colors.black45),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              prefixIcon: const Icon(Icons.email_outlined,
                                  color: Colors.black54),
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          TextFormField(
                            controller: viewModel.passwordController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter your password',
                              hintStyle:
                                  GoogleFonts.poppins(color: Colors.black45),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              prefixIcon: const Icon(Icons.lock_outline,
                                  color: Colors.black54),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  viewModel.isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black54,
                                ),
                                onPressed: viewModel.togglePasswordVisibility,
                              ),
                            ),
                            obscureText: !viewModel.isPasswordVisible,
                          ),
                          const SizedBox(height: 30.0),
                          ElevatedButton(
                            onPressed: viewModel.isLoading
                                ? null // ✅ Disables the button when loading
                                : () => viewModel.login(
                                      viewModel.emailController.text,
                                      viewModel.passwordController.text,
                                    ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 55),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(fontSize: 16.0),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? ",
                                  style: GoogleFonts.poppins()),
                              GestureDetector(
                                onTap: viewModel.navigateToSignUp,
                                child: Text(
                                  'Sign up',
                                  style: GoogleFonts.poppins(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Center(
                            child: GestureDetector(
                              child: Text(
                                'Forgot password?',
                                style: GoogleFonts.poppins(
                                  color: Colors.black54,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // ✅ Shows the loading indicator when logging in
          if (viewModel.isLoading)
            const LoadingIndicatorSignUp(isLoading: true),
        ],
      ),
    );
  }

  @override
  SignInViewModel viewModelBuilder(BuildContext context) => SignInViewModel();
}

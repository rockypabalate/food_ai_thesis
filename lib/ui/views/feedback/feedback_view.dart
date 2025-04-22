import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'feedback_viewmodel.dart';

class FeedbackView extends StackedView<FeedbackViewModel> {
  const FeedbackView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FeedbackViewModel viewModel,
    Widget? child,
  ) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          primary: Colors.orange,
          secondary: Colors.deepOrange,
          surface: Colors.white,
          background: Colors.orange.shade50,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Your Feedback',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        elevation: 3,
                        shadowColor: Colors.orange.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Let us know what you think!',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              const SizedBox(height: 50),

                              // Star Rating
                              Center(
                                child: Column(
                                  children: [
                                    const Text(
                                      'Rate your experience',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    // Wrap with LayoutBuilder to make it responsive
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        // Calculate appropriate size based on available width
                                        final double maxWidth =
                                            constraints.maxWidth;
                                        final double starSize =
                                            maxWidth < 300 ? 40 : 48;
                                        final double padding =
                                            maxWidth < 300 ? 2 : 6;

                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize
                                              .min, // Prevent row from taking full width
                                          children: List.generate(
                                            5,
                                            (index) => GestureDetector(
                                              onTap: () {
                                                viewModel.selectedRating =
                                                    index + 1;
                                                viewModel.notifyListeners();
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: padding),
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  transform: Matrix4.identity()
                                                    ..scale(index <
                                                            viewModel
                                                                .selectedRating
                                                        ? 1.1
                                                        : 0.9),
                                                  child: Icon(
                                                    index <
                                                            viewModel
                                                                .selectedRating
                                                        ? Icons.star_rounded
                                                        : Icons
                                                            .star_outline_rounded,
                                                    color: index <
                                                            viewModel
                                                                .selectedRating
                                                        ? Colors.orange
                                                        : Colors.grey.shade400,
                                                    size: starSize,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      _getRatingText(viewModel.selectedRating),
                                      style: TextStyle(
                                        color: Colors.orange.shade800,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),

                              // Feedback Text Field
                              const Text(
                                'Write your feedback',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.orange.withOpacity(0.15),
                                      blurRadius: 12,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: viewModel.feedbackController,
                                  maxLines: 7,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your feedback here...',
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade400),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                      borderSide: BorderSide(
                                        color: Colors.orange.shade200,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                      borderSide: BorderSide(
                                        color: Colors.orange.shade400,
                                        width: 2.0,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Submit Button
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: viewModel.isBusy
                              ? null
                              : () {
                                  if (viewModel.selectedRating == 5) {
                                    viewModel.shouldShowConfetti = true;
                                  }
                                  viewModel.submitFeedback(context);
                                },
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            shadowColor: Colors.orange.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: viewModel.isBusy
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Submit Feedback',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.send_rounded,
                                      color: Colors.white.withOpacity(0.9),
                                      size: 18,
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

            // Confetti controller - now only triggered on submission
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: viewModel.confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                maxBlastForce: 7,
                minBlastForce: 3,
                emissionFrequency: 0.08,
                numberOfParticles: 30,
                gravity: 0.2,
                colors: const [
                  Colors.orange,
                  Colors.deepOrange,
                  Colors.amber,
                  Colors.yellow,
                  Colors.red,
                  Colors.white,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Very Good';
      case 5:
        return 'Excellent!';
      default:
        return '';
    }
  }

  @override
  FeedbackViewModel viewModelBuilder(BuildContext context) =>
      FeedbackViewModel();

  @override
  void onViewModelReady(FeedbackViewModel viewModel) {
    viewModel.getCurrentUser();
    viewModel.initConfetti();
    super.onViewModelReady(viewModel);
  }
}

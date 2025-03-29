import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  final bool isLoading;

  const LoadingIndicator({required this.isLoading, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Container(
        color: Colors.black.withOpacity(0.7), // Darker dim background
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SpinKitThreeBounce(
                color: Colors.orange,
                size: 30.0, // Made it smaller
              ),
              SizedBox(height: 10), // Reduced space
              Text(
                'Loading, please wait...',
                style: TextStyle(
                  color: Colors.white, // White text for better visibility
                  fontSize: 16,
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

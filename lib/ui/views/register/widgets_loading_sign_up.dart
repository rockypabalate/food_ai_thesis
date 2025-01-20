import 'package:flutter/material.dart';

class LoadingIndicatorSignUp extends StatelessWidget {
  final bool isLoading;

  const LoadingIndicatorSignUp({required this.isLoading, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Stack(
        children: [
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Container(
                color: Colors.white.withOpacity(0.8),
                padding: const EdgeInsets.all(16),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      color: Colors.orange,
                      strokeWidth: 5,
                    ),
                    SizedBox(width: 16), // Space between spinner and text
                    Text(
                      'Loading',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';

class TiltingFab extends StatefulWidget {
  final VoidCallback onPressed;

  const TiltingFab({Key? key, required this.onPressed}) : super(key: key);

  @override
  _TiltingFabState createState() => _TiltingFabState();
}

class _TiltingFabState extends State<TiltingFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600), // 3 quick tilts
    )..repeat(reverse: false); // Keeps repeating

    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: pi / 8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: pi / 8, end: -pi / 8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -pi / 8, end: pi / 8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: pi / 8, end: -pi / 8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -pi / 8, end: pi / 8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: pi / 8, end: 0.0), weight: 1),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 2), // 1s Pause
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66,
      height: 66,
      child: FloatingActionButton(
        onPressed: widget.onPressed, // Navigate on click
        backgroundColor: Colors.orange,
        shape: const CircleBorder(),
        elevation: 3.0,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _animation.value,
              child:
                  const Icon(Icons.camera_alt, color: Colors.white, size: 36),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

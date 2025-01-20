import 'package:flutter/material.dart';

class DelayedFadeIn extends StatefulWidget {
  final Widget child;
  final int delay;

  const DelayedFadeIn({Key? key, required this.child, required this.delay})
      : super(key: key);

  @override
  _DelayedFadeInState createState() => _DelayedFadeInState();
}

class _DelayedFadeInState extends State<DelayedFadeIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _offsetAnimation;
  bool _hasAnimated = false;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Initialize the slide animation
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted && !_hasAnimated) {
        _controller.forward();
        setState(() {
          _hasAnimated = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: widget.child,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FadeEffectSettings extends StatefulWidget {
  final Widget child;
  final int delay;
  final bool isHorizontalSlide; // New parameter to control horizontal sliding

  const FadeEffectSettings({
    Key? key,
    required this.child,
    required this.delay,
    this.isHorizontalSlide = false, // Default is vertical slide
  }) : super(key: key);

  @override
  _FadeEffectState createState() => _FadeEffectState();
}

class _FadeEffectState extends State<FadeEffectSettings>
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

    // Conditional offset for horizontal or vertical slide
    _offsetAnimation = widget.isHorizontalSlide
        ? Tween<Offset>(
            begin: const Offset(0.2, 0), // Horizontal slide from right
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn))
        : Tween<Offset>(
            begin: const Offset(0, 0.04), // Vertical slide from below
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

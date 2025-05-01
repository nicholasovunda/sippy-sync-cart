import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// Custom animated loading bar with a drink animations
class CustomLoadingIndicator extends StatelessWidget {
  final double size;
  final bool repeat;
  final bool animate;
  final String animationPath;

  const CustomLoadingIndicator({
    super.key,
    this.size = 100.0,
    this.repeat = true,
    this.animate = true,
    this.animationPath = '/animations/loading_animation.json',
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        animationPath,
        width: size,
        height: size,
        repeat: repeat,
        animate: animate,
        errorBuilder: (context, error, stackTrace) {
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

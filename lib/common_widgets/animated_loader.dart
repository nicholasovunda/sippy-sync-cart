import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final double size; // Optional: size of the loading animation

  const CustomLoadingIndicator({super.key, this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/loading_animation.json',
        width: size,
        height: size,
        repeat: true,
        animate: true,
      ),
    );
  }
}

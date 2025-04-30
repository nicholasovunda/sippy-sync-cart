import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Future<void> Function()? onPressed;
  final Color color;
  final String title;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BackToHomeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  double borderRadius;
  BackToHomeButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

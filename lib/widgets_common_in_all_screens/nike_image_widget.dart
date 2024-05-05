import 'package:flutter/material.dart';

class NikeImageWidget extends StatelessWidget {
  final double height;
  final String imagePath;
  const NikeImageWidget({
    super.key,
    required this.height,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      height: height,
    );
  }
}

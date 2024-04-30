import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/images_paths.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final double borderRadius;
  final String imageUrl;
  const CustomCachedNetworkImage({
    super.key,
    required this.borderRadius,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Image.asset(
          ImagesPaths.loadingImageError,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

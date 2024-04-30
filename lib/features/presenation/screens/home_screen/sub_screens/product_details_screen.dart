import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/features/data/models/product_model.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets/custom_cached_network_image.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: getMediaQueryWidth(context, 0.8),
            flexibleSpace: CustomCachedNetworkImage(
              imageUrl: product.image,
              borderRadius: kDefautlVerticalGap20,
            ),
          ),
        ],
      ),
    );
  }
}

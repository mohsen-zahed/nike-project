import 'package:flutter/material.dart';
import 'package:nike_project/config/constants/colors.dart';
import 'package:nike_project/config/constants/constant_variables.dart';
import 'package:nike_project/features/data/models/banner_model.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets_common_in_all_screens/custom_cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSliderWidget extends StatelessWidget {
  final PageController _controller = PageController();
  final List<BannerModel> banners;
  final double borderRadius;
  BannerSliderWidget({
    super.key,
    required this.banners,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: banners.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      getMediaQueryWidth(context, constantVariables.kDefaultPaddingWidth20)),
              child: CustomCachedNetworkImage(
                imageUrl: banners[index].image,
                borderRadius: borderRadius,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: banners.length,
                axisDirection: Axis.horizontal,
                effect: WormEffect(
                  spacing: 5,
                  radius: 50,
                  dotWidth: 5,
                  dotHeight: 5,
                  dotColor: kGreyColorShade300,
                  activeDotColor: kGreyColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

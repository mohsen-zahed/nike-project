import 'package:flutter/material.dart';
import 'package:nike_project/config/constants/images_paths.dart';
import 'package:nike_project/utils/media_query.dart';

class DefaultFailedWidget extends StatelessWidget {
  const DefaultFailedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getMediaQueryWidth(context),
      height: getMediaQueryHeight(context),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagesPaths.notResponding),
          opacity: 0.5,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

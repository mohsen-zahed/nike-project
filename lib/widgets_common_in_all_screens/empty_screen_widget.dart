import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nike_project/config/constants/numeric_contants.dart';
import 'package:nike_project/utils/media_query.dart';

class EmptyScreenWidget extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onPressed;
  final String buttonText;
  const EmptyScreenWidget({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
            width: getMediaQueryHeight(context, 0.15),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getMediaQueryWidth(context, kDefaultPaddingWidth20),
            ),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onPressed,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}

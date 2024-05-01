import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/utils/media_query.dart';

class CustomEmailTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  const CustomEmailTextField({
    super.key,
    required this.labelText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getMediaQueryWidth(context, kDefaultPaddingWidth20),
      ),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: kCaptionsTextColor),
        decoration: InputDecoration(
          label: Text(labelText),
          hintText: hintText,
        ),
      ),
    );
  }
}

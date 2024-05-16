import 'package:flutter/material.dart';
import 'package:nike_project/config/constants/colors.dart';
import 'package:nike_project/config/constants/constant_variables.dart';
import 'package:nike_project/utils/media_query.dart';

class CustomEmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  const CustomEmailTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getMediaQueryWidth(context, constantVariables.kDefaultPaddingWidth20),
      ),
      child: TextField(
        controller: controller,
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

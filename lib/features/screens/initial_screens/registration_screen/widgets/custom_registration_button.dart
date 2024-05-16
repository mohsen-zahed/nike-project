import 'package:flutter/material.dart';
import 'package:nike_project/config/constants/colors.dart';
import 'package:nike_project/config/constants/constant_variables.dart';
import 'package:nike_project/utils/media_query.dart';

class CustomRegistrationButton extends StatelessWidget {
  const CustomRegistrationButton({
    super.key,
    required this.onPressed,
    required this.child,
  });
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.06,
      margin: EdgeInsets.symmetric(
        horizontal: getMediaQueryWidth(context, constantVariables.kDefaultPaddingWidth20),
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(constantVariables.kDefaultTextFieldBorderRadius10),
            ),
            backgroundColor: kWhiteColor,
            foregroundColor: kPrimaryTextColor,
          ),
          child: child),
    );
  }
}

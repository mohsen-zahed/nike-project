import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/utils/media_query.dart';

class CustomRegistrationButton extends StatelessWidget {
  const CustomRegistrationButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.06,
      margin: EdgeInsets.symmetric(
        horizontal: getMediaQueryWidth(context, kDefaultPaddingWidth20),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(kDefaultTextFieldBorderRadius10),
          ),
          backgroundColor: kWhiteColor,
          foregroundColor: kPrimaryTextColor,
        ),
        child: Text(
          buttonText,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/utils/media_query.dart';

class CustomPasswordTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  const CustomPasswordTextField({
    super.key,
    required this.labelText,
    required this.hintText,
  });

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool isObsecured = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getMediaQueryWidth(context, kDefaultPaddingWidth20),
      ),
      child: TextField(
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: kCaptionsTextColor),
        obscureText: isObsecured,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isObsecured = !isObsecured;
              });
            },
            child: Icon(
              isObsecured ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          label: Text(
            widget.labelText,
          ),
          hintText: widget.hintText,
        ),
      ),
    );
  }
}

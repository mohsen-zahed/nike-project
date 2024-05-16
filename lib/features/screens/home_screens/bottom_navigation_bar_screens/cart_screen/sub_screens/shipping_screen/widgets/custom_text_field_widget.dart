import 'package:flutter/material.dart';
import 'package:nike_project/config/constants/colors.dart';
import 'package:nike_project/config/constants/numeric_contants.dart';
import 'package:nike_project/utils/media_query.dart';

class CustomTextFieldForm extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onSubmitted;
  final TextInputAction textInputAction;
  final String errorText;
  final Function(String) onChanged;
  final TextInputType? textInputType;
  const CustomTextFieldForm({
    super.key,
    required this.hintText,
    required this.controller,
    required this.focusNode,
    required this.onSubmitted,
    required this.textInputAction,
    required this.errorText,
    required this.onChanged,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getMediaQueryWidth(context, kDefaultPaddingWidth20)),
      child: TextField(
        keyboardType: textInputType ?? TextInputType.text,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          errorMaxLines: 1,
          errorText: errorText.isEmpty
              ? null
              : errorText, // Set errorText to null when there is no error
          hintText: hintText,
          errorStyle: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: kRedColorShade700),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(kDefaultTextFieldBorderRadius10),
            borderSide: BorderSide(
                color: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .color!
                    .withOpacity(0.5)),
          ),
          labelText: '$hintText *',
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(kDefaultTextFieldBorderRadius10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(kDefaultTextFieldBorderRadius10),
            borderSide: BorderSide(
                color: Theme.of(context).textTheme.labelSmall!.color!),
          ),
        ),
      ),
    );
  }
}

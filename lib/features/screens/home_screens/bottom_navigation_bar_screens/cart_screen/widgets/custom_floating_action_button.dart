import 'package:flutter/material.dart';
import 'package:nike_project/config/constants/constant_variables.dart';
import 'package:nike_project/utils/media_query.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Widget widget;
  final Function() onPressed;

  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: getMediaQueryWidth(context, constantVariables.kDefaultPaddingWidth20),
      ),
      child: FloatingActionButton.extended(
        onPressed: onPressed,
        label: widget,
      ),
    );
  }
}

import 'package:flutter/material.dart';

double getMediaQueryWidth(BuildContext context, [double width = 1]) {
  return MediaQuery.of(context).size.width * width;
}

double getMediaQueryHeight(BuildContext context, [double height = 1]) {
  return MediaQuery.of(context).size.height * height;
}

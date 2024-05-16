import 'package:flutter/material.dart';

class ConstantVariables {
  static ConstantVariables? _constantVariables;
  ConstantVariables._();
  static ConstantVariables get instance {
    _constantVariables ??= ConstantVariables._();
    return _constantVariables!;
  }

  //* Numerics...
  double kDefaultPaddingWidth20 = 0.04; // is equal to 20 horizontaly
  double kDefaultPaddingWidth10 = 0.02; // is equal to 20 horizontaly
  double kDefaultPaddingHeight15 = 0.015; // is equal to 15 verticaly
  double kDefaultCardWidgetLeftPadding = 20;
  double kDefaultBorderRadius20 = 20;
  double kDefaultTextFieldBorderRadius10 = 10;
  double kDefautlVerticalGap20 = 20;
  double kDefautlVerticalGap10 = 10;
  double kDefautlTextFieldVerticalGap10 = 10;
  FontWeight kDefaultTitleFontWeight700 = FontWeight.w700;
  FontWeight kDefaultCardTitleFontWeight400 = FontWeight.w400;

  //* Client secret...
  String clientSecret = 'kyj1c9sVcksqGU4scMX7nLDalkjp2WoqQEf8PKAC';
}

final ConstantVariables constantVariables = ConstantVariables.instance;

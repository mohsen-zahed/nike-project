import 'package:flutter/material.dart';

class CustomDividerWidget extends StatelessWidget {
  final Color? color;
  final double space;
  final double thickness;
  const CustomDividerWidget(
      {super.key, required this.space, required this.thickness, this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? Theme.of(context).dividerTheme.color,
      height: space,
      thickness: thickness,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nike_project/utils/media_query.dart';

class AppExceptionWidget extends StatelessWidget {
  final String errorMessage;
  final String buttonText;
  final VoidCallback onPressed;
  const AppExceptionWidget({
    super.key,
    required this.errorMessage,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage),
          SizedBox(
            height: getMediaQueryHeight(context, 0.02),
          ),
          ElevatedButton(
            onPressed: onPressed,
            child: Text(
              buttonText,
            ),
          ),
        ],
      ),
    );
  }
}

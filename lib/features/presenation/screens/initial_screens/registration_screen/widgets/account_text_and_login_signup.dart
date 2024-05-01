import 'package:flutter/material.dart';
import 'package:nike_project/core/constants/colors.dart';
import 'package:nike_project/core/constants/numeric_contants.dart';
import 'package:nike_project/utils/media_query.dart';

class AccountTextAndLoginSignup extends StatelessWidget {
  final String accountText;
  final String registerText;
  final VoidCallback onTap;
  const AccountTextAndLoginSignup({
    super.key,
    required this.accountText,
    required this.registerText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getMediaQueryWidth(context, kDefaultPaddingWidth20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            accountText,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: kCaptionsTextColor,
                ),
          ),
          SizedBox(
            width: getMediaQueryWidth(context, kDefaultPaddingWidth20),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              registerText,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor:
                        Theme.of(context).textTheme.titleSmall!.color,
                    decorationThickness: 3,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
